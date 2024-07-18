//
//  FaceCaptureViewController.swift
//
//  Created by Mayowa Olunuga on 04/12/2023.
//

import UIKit
import AVKit
import Vision

protocol FaceCaptureViewControllerViewControllerDelegate: AnyObject {
    func onFaceCaptured(image: UIImage)
}

class FaceCaptureViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var layout = FaceCaptureLayout()
    private let theme = ComplianceSDK.shared.configuration.theme
    weak var delegate: FaceCaptureViewControllerViewControllerDelegate?
    private var smileConfidenceHistory: [Float] = []
    
    
    // AVCapture variables to hold sequence data
    var session: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var videoDataOutput: AVCaptureVideoDataOutput?
    var videoDataOutputQueue: DispatchQueue?
    
    var captureDevice: AVCaptureDevice?
    var captureDeviceResolution: CGSize = CGSize()
    
    var resolution: CGSize?
    var sampleBuffer: CMSampleBuffer?
    var displayMessage: String = "Please make sure your face fits into the frame above" {
        didSet {
            layout.subtitleLabel.text = displayMessage
        }
    }
    
    var enableCaptureButton: Bool = false {
        didSet {
            if enableCaptureButton {
//                layout.captureButton.isHidden = false
                layout.captureButton.isUserInteractionEnabled = false
                layout.captureButton.tintColor = .gray
                layout.cameraView.borderLayer.lineWidth = 6
                layout.cameraView.borderLayer.strokeColor = UIColor.green.cgColor
            }else {
//                layout.captureButton.isHidden = true
                layout.captureButton.isUserInteractionEnabled = true
                layout.captureButton.tintColor = .white
                layout.cameraView.borderLayer.lineWidth = 4
                layout.cameraView.borderLayer.strokeColor = UIColor.white.cgColor
            }
        }
    }
    
    // Vision requests
    private var detectionRequests: [VNDetectFaceRectanglesRequest]?
    private var trackingRequests: [VNTrackObjectRequest]?
    
    lazy var sequenceRequestHandler = VNSequenceRequestHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.color.surfaceBackgroundPrimary
        
        view.addSubview(layout)
        layout.fillSuperview()
        
        layout.capturButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCaptureClicked)))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupFaceDetection()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session?.startRunning()
        }
    }

    @objc func handleCaptureClicked() {
        if enableCaptureButton {
            captureImage()
        }
    }
    
    private func setupFaceDetection(){
        self.session = self.setupAVCaptureSession()
        self.prepareVisionRequest()
    }
    
    private func captureImage() {
        guard let sampleBuffer = sampleBuffer, let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        let ciimage = CIImage(cvPixelBuffer: imageBuffer)
        let image = self.convert(cmage: ciimage)
        self.delegate?.onFaceCaptured(image: image)
    }
    
    // Convert CIImage to UIImage
    private func convert(cmage: CIImage) -> UIImage {
         let context = CIContext(options: nil)
         let cgImage = context.createCGImage(cmage, from: cmage.extent)!
        let image = UIImage(cgImage: cgImage, scale: 1, orientation: .leftMirrored)
         return image
    }

}

// MARK: AVCapture Setup

extension FaceCaptureViewController {
    
    /// - Tag: CreateCaptureSession
    fileprivate func setupAVCaptureSession() -> AVCaptureSession? {
        let captureSession = AVCaptureSession()
        do {
            let inputDevice = try self.configureFrontCamera(for: captureSession)
            self.configureVideoDataOutput(for: inputDevice.device, resolution: inputDevice.resolution, captureSession: captureSession)
            self.designatePreviewLayer(for: captureSession)
            self.resolution = inputDevice.resolution
            return captureSession
        } catch let executionError as NSError {
            self.presentError(executionError)
        } catch {
            self.presentErrorAlert(message: "An unexpected failure has occured")
        }
        
        self.teardownAVCapture()
        
        return nil
    }
    
    private func updateCaptureButtonState(with confidence: Float) {
        smileConfidenceHistory.append(confidence)
        
        // Keep a window of the last few confidence values
        let windowSize = 5
        if smileConfidenceHistory.count > windowSize {
            smileConfidenceHistory.removeFirst(smileConfidenceHistory.count - windowSize)
        }
        
        // Calculate the average confidence over the window
        let averageConfidence = smileConfidenceHistory.reduce(0, +) / Float(smileConfidenceHistory.count)
        
        // Set a threshold for enabling the capture button
        let threshold: Float = 0.5 // Adjust this threshold as needed
        
        if averageConfidence >= threshold {
            enableCaptureButton = true
        } else {
            enableCaptureButton = false
        }
    }

    
    /// - Tag: ConfigureDeviceResolution
    fileprivate func highestResolution420Format(for device: AVCaptureDevice) -> (format: AVCaptureDevice.Format, resolution: CGSize)? {
        var highestResolutionFormat: AVCaptureDevice.Format? = nil
        var highestResolutionDimensions = CMVideoDimensions(width: 0, height: 0)
        
        for format in device.formats {
            let deviceFormat = format as AVCaptureDevice.Format
            
            let deviceFormatDescription = deviceFormat.formatDescription
            if CMFormatDescriptionGetMediaSubType(deviceFormatDescription) == kCVPixelFormatType_420YpCbCr8BiPlanarFullRange {
                let candidateDimensions = CMVideoFormatDescriptionGetDimensions(deviceFormatDescription)
                if (highestResolutionFormat == nil) || (candidateDimensions.width > highestResolutionDimensions.width) {
                    highestResolutionFormat = deviceFormat
                    highestResolutionDimensions = candidateDimensions
                }
            }
        }
        
        if highestResolutionFormat != nil {
            let resolution = CGSize(width: CGFloat(highestResolutionDimensions.width), height: CGFloat(highestResolutionDimensions.height))
            return (highestResolutionFormat!, resolution)
        }
        
        return nil
    }
    
    fileprivate func configureFrontCamera(for captureSession: AVCaptureSession) throws -> (device: AVCaptureDevice, resolution: CGSize) {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front)
        
        if let device = deviceDiscoverySession.devices.first {
            if let deviceInput = try? AVCaptureDeviceInput(device: device) {
                if captureSession.canAddInput(deviceInput) {
                    captureSession.addInput(deviceInput)
                }
                
                if let highestResolution = self.highestResolution420Format(for: device) {
                    try device.lockForConfiguration()
                    device.activeFormat = highestResolution.format
                    device.unlockForConfiguration()
                    
                    return (device, highestResolution.resolution)
                }
            }
        }
        
        throw NSError(domain: "ViewController", code: 1, userInfo: nil)
    }
    
    /// - Tag: CreateSerialDispatchQueue
    fileprivate func configureVideoDataOutput(for inputDevice: AVCaptureDevice, resolution: CGSize, captureSession: AVCaptureSession) {
        
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        
        // Create a serial dispatch queue used for the sample buffer delegate as well as when a still image is captured.
        // A serial dispatch queue must be used to guarantee that video frames will be delivered in order.
        let videoDataOutputQueue = DispatchQueue(label: "com.complianceSDK.faceDetection")
        videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
        }
        
        videoDataOutput.connection(with: .video)?.isEnabled = true
        
        if let captureConnection = videoDataOutput.connection(with: AVMediaType.video) {
            if captureConnection.isCameraIntrinsicMatrixDeliverySupported {
                captureConnection.isCameraIntrinsicMatrixDeliveryEnabled = true
            }
        }
        
        self.videoDataOutput = videoDataOutput
        self.videoDataOutputQueue = videoDataOutputQueue
        
        self.captureDevice = inputDevice
        self.captureDeviceResolution = resolution
    }
    
    /// - Tag: DesignatePreviewLayer
    fileprivate func designatePreviewLayer(for captureSession: AVCaptureSession) {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer = videoPreviewLayer
        
        videoPreviewLayer.name = "CameraPreview"
        videoPreviewLayer.backgroundColor = UIColor.black.cgColor
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        
        videoPreviewLayer.frame = layout.cameraView.frame
        layout.cameraView.layer.addSublayer(videoPreviewLayer)
        
    }
    
    // Removes infrastructure for AVCapture as part of cleanup.
    fileprivate func teardownAVCapture() {
        self.videoDataOutput = nil
        self.videoDataOutputQueue = nil
        
        if let previewLayer = self.previewLayer {
            previewLayer.removeFromSuperlayer()
            self.previewLayer = nil
        }
    }
}

// MARK: Performing Vision Requests

extension FaceCaptureViewController {
    /// - Tag: WriteCompletionHandler
    fileprivate func prepareVisionRequest() {
        
        //self.trackingRequests = []
        var requests = [VNTrackObjectRequest]()
        
        let faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: { (request, error) in
            
            if error != nil {
                print("FaceDetection error: \(String(describing: error)).")
            }
            
            guard let faceDetectionRequest = request as? VNDetectFaceRectanglesRequest,
                  let results = faceDetectionRequest.results else {
                    return
            }
            DispatchQueue.main.async {
                // Add the observations to the tracking list
                for observation in results {
                    let faceTrackingRequest = VNTrackObjectRequest(detectedObjectObservation: observation)
                    requests.append(faceTrackingRequest)
                }
                self.trackingRequests = requests
            }
        })
        
        // Start with detection.  Find face, then track it.
        self.detectionRequests = [faceDetectionRequest]
        
        self.sequenceRequestHandler = VNSequenceRequestHandler()
    }
}

// MARK: AVCaptureVideoDataOutputSampleBufferDelegate

extension FaceCaptureViewController {
    
    private func resetCameraView(withMessage: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            guard  let self = self else { return }
            self.sampleBuffer = nil
            if withMessage {
                self.displayMessage = "Please make sure your face fits into the frame above"
            }
            self.enableCaptureButton = false
        }
    }
    
    
    /// - Tag: PerformRequests
    // Handle delegate method callback on receiving a sample buffer.
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        var requestHandlerOptions: [VNImageOption: AnyObject] = [:]
        
        let cameraIntrinsicData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil)
        if cameraIntrinsicData != nil {
            requestHandlerOptions[VNImageOption.cameraIntrinsics] = cameraIntrinsicData
        }
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Failed to obtain a CVPixelBuffer for the current output frame.")
            return
        }
        
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: [CIDetectorAccuracy : CIDetectorAccuracyLow])
        
        let attachments = CMCopyDictionaryOfAttachments(allocator: kCFAllocatorDefault, target: sampleBuffer, attachmentMode: kCMAttachmentMode_ShouldPropagate)
        let ciImage = CIImage(cvImageBuffer: pixelBuffer, options: attachments as! [CIImageOption : Any]?)
        let options: [String : Any] = [CIDetectorImageOrientation: exifOrientation(orientation: UIDevice.current.orientation),
                                       CIDetectorSmile: true,
                                       CIDetectorEyeBlink: true]
        let allFeatures = faceDetector?.features(in: ciImage, options: options)

        guard let features = allFeatures else {
            self.displayMessage = "Please make sure your face fits into the frame above"
            return
        }
        
        for feature in features {
            if let faceFeature = feature as? CIFaceFeature {
                print("Has smile: \(faceFeature.hasSmile)")
                print("Left eyes closed: \(faceFeature.leftEyeClosed)" )
                print("Right eyes closed: \(faceFeature.rightEyeClosed)")
                print("Face bound: \(faceFeature.bounds)")
                
                
                DispatchQueue.main.sync { [weak self] in
                    guard let self = self else { return }
                    
                    let faceWidth = faceFeature.bounds.size.width
                    let frameWidth = self.resolution?.width ?? .zero
                    
                    let framePercentageCovered = (faceWidth/frameWidth) * 100
                    
                    if !faceFeature.hasMouthPosition  {
                        self.displayMessage = "Please put your face in the frame"
                    }
                    
                    if framePercentageCovered < 40 {
                        self.displayMessage = "Move closer"
                        print("move closer")
                    }
                    
                    if
                        faceFeature.hasMouthPosition &&
                        framePercentageCovered >= 40
                    {
                        self.displayMessage = "Perfect! now smile for the camera and capture when the frame turns green"
                        self.enableCaptureButton = faceFeature.hasSmile
                        self.sampleBuffer = sampleBuffer
                    } else {
                        self.resetCameraView(withMessage: false)
                    }
                }
            }
            
        }
        
        
        
        let exifOrientation = self.exifOrientationForCurrentDeviceOrientation()
        
        guard let requests = self.trackingRequests, !requests.isEmpty else {
            // No tracking object detected, so perform initial detection
            self.resetCameraView()
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                            orientation: exifOrientation,
                                                            options: requestHandlerOptions)
            
            do {
                guard let detectRequests = self.detectionRequests else {
                    return
                }
                try imageRequestHandler.perform(detectRequests)
            } catch let error as NSError {
                NSLog("Failed to perform FaceRectangleRequest: %@", error)
            }
            return
        }
        
        do {
            try self.sequenceRequestHandler.perform(requests,
                                                     on: pixelBuffer,
                                                     orientation: exifOrientation)
        } catch let error as NSError {
            NSLog("Failed to perform SequenceRequest: %@", error)
        }
        
        // Setup the next round of tracking.
        var newTrackingRequests = [VNTrackObjectRequest]()
        for trackingRequest in requests {
            
            guard let results = trackingRequest.results else {
                return
            }
            
            guard let observation = results[0] as? VNDetectedObjectObservation else {
                return
            }
            
            if !trackingRequest.isLastFrame {
                if observation.confidence > 0.3 {
                    trackingRequest.inputObservation = observation
                } else {
                    trackingRequest.isLastFrame = true
                }
                newTrackingRequests.append(trackingRequest)
            }
        }
        self.trackingRequests = newTrackingRequests
        
        if newTrackingRequests.isEmpty {
            // Nothing to track, so abort.
            return
        }
        
        // Perform face landmark tracking on detected faces.
        var faceLandmarkRequests = [VNDetectFaceLandmarksRequest]()
        
        // Perform landmark detection on tracked faces.
        for trackingRequest in newTrackingRequests {
            
            let faceLandmarksRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request, error) in
                
                if error != nil {
                    print("FaceLandmarks error: \(String(describing: error)).")
                }
                
                guard let landmarksRequest = request as? VNDetectFaceLandmarksRequest,
                      let _ = landmarksRequest.results else {
                        return
                }
            })
            
            guard let trackingResults = trackingRequest.results else {
                return
            }
            
            guard let observation = trackingResults[0] as? VNDetectedObjectObservation else {
                return
            }
            let faceObservation = VNFaceObservation(boundingBox: observation.boundingBox)
            faceLandmarksRequest.inputFaceObservations = [faceObservation]
            
            // Continue to track detected facial landmarks.
            faceLandmarkRequests.append(faceLandmarksRequest)
            
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer,
                                                            orientation: exifOrientation,
                                                            options: requestHandlerOptions)
            
            do {
                try imageRequestHandler.perform(faceLandmarkRequests)
            } catch let error as NSError {
                NSLog("Failed to perform FaceLandmarkRequest: %@", error)
            }
        }
    }
    
    func exifOrientation(orientation: UIDeviceOrientation) -> Int {
        switch orientation {
        case .portraitUpsideDown:
            return 8
        case .landscapeLeft:
            return 3
        case .landscapeRight:
            return 1
        default:
            return 6
        }
    }
}


// MARK: Helper Methods for Error Presentation

extension FaceCaptureViewController {
    
    fileprivate func presentErrorAlert(withTitle title: String = "Unexpected Failure", message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true)
    }
    
    fileprivate func presentError(_ error: NSError) {
        self.presentErrorAlert(withTitle: "Failed with error \(error.code)", message: error.localizedDescription)
    }
}

// MARK: Helper Methods for Handling Device Orientation & EXIF

extension FaceCaptureViewController {
    
    fileprivate func radiansForDegrees(_ degrees: CGFloat) -> CGFloat {
        return CGFloat(Double(degrees) * Double.pi / 180.0)
    }
    
    func exifOrientationForDeviceOrientation(_ deviceOrientation: UIDeviceOrientation) -> CGImagePropertyOrientation {
        
        switch deviceOrientation {
        case .portraitUpsideDown:
            return .rightMirrored
            
        case .landscapeLeft:
            return .downMirrored
            
        case .landscapeRight:
            return .upMirrored
            
        default:
            return .leftMirrored
        }
    }
    
    func exifOrientationForCurrentDeviceOrientation() -> CGImagePropertyOrientation {
        return exifOrientationForDeviceOrientation(UIDevice.current.orientation)
    }
}

