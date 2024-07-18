//
//  MainCoordinator.swift
//
//  Created by Mayowa Olunuga on 20/11/2023.
//

import UIKit
import CryptoKit

internal class MainCoordinator {
    private var presentingViewController: UIViewController?
    private var capturedFaceImage: UIImage?
    private var capturedIDImage: UIImage?
    
    
    internal init(){}
    
    func start(presentingViewController: UIViewController, config: CSConfiguration) {
        self.presentingViewController = presentingViewController
        switch config.platformType {
        case .send:
            showSendVerificationSteps()
        case .f4b:
            showVerificationSteps()
        }
    }
    
    private func showVerificationSteps() {
        let stepsViewController = VerificationStepsViewController()
        stepsViewController.delegate = self
        presentingViewController?.navigationController?.pushViewController(stepsViewController, animated: true)
    }
    
    private func showSendVerificationSteps() {
        let sendStepsViewController = SendVerificationStepsViewController()
        sendStepsViewController.delegate = self
        presentingViewController?.navigationController?.pushViewController(sendStepsViewController, animated: true)
    }
       
    private func showFaceCaptureScreen() {
        let faceCaptureViewController = FaceCaptureViewController()
        faceCaptureViewController.delegate = self
        presentingViewController?.navigationController?.pushViewController(faceCaptureViewController, animated: true)
    }
    
    private func showFaceCapturePreviewScreen(image: UIImage) {
        let faceCapturePreviewViewController = FaceCapturePreviewViewController()
        faceCapturePreviewViewController.delegate = self
        faceCapturePreviewViewController.capturedImage = image
        presentingViewController?.navigationController?.pushViewController(faceCapturePreviewViewController, animated: true)
    }
    
    private func showIDCaptureScreen() {
        let idCaptureViewController = IDCaptureViewController()
        idCaptureViewController.delegate = self
        presentingViewController?.navigationController?.pushViewController(idCaptureViewController, animated: true)
    }
    
    private func showIDCapturePreviewScreen(image: UIImage) {
        let idCapturePreviewViewController = IDCapturePreviewViewController()
        idCapturePreviewViewController.capturedImage = image
        idCapturePreviewViewController.capturedFaceImage = capturedFaceImage
        idCapturePreviewViewController.delegate = self
        presentingViewController?.navigationController?.pushViewController(idCapturePreviewViewController, animated: true)
    }
    
    private func showLoader() {
        let loaderViewController = LoaderViewController()
        loaderViewController.delegate = self
    
        presentingViewController?.navigationController?.pushViewController(loaderViewController, animated: true)
    }
}

extension MainCoordinator: VerificationStepsViewControllerDelegate {
    func onSaveLaterCliced() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
    
    func onSaveClicked() {
        showIDCaptureScreen()
    }
}

extension MainCoordinator: SendVerificationStepsViewControllerDelegate {
    func onSaveLater() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
    
    func onSave() {
        showIDCaptureScreen()
    }
}




extension MainCoordinator: FaceCaptureViewControllerViewControllerDelegate {
    func onFaceCaptured(image: UIImage) {
        capturedFaceImage = image
        showFaceCapturePreviewScreen(image: image)
    }
}

extension MainCoordinator: FaceCapturePreviewViewDelegate {
    func onFaceCaptureContinueClicked() {
        showLoader()
    }
    
    func onFaceCaptureRetakeClicked() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
}

extension MainCoordinator: IDCaptureViewControllerViewControllerDelegate {
    func onIDCaptured(image: UIImage) {
        capturedIDImage = image
        showIDCapturePreviewScreen(image: image)
    }
}

extension MainCoordinator: IDCapturePreviewViewDelegate {
    func onIDCaptureContinueClicked() {
        showFaceCaptureScreen()
    }
    func onIDCaptureRetakeClicked() {
        presentingViewController?.navigationController?.popViewController(animated: true)
    }
}

extension MainCoordinator: LoaderViewDelegate {
    func onSubmit(completion: @escaping (Result<String, Error>) -> Void) {
        guard let capturedFaceImage = capturedFaceImage, let capturedIDImage = capturedIDImage else {
            print("Error: Face image or ID image is missing.")
            completion(.failure("Error: Face image or ID image is missing." as! Error))
            return
        }
        
        NetworkingRX.submitData(faceImage: capturedFaceImage, idImage: capturedIDImage) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    

}

extension String {
    func extractStringBetween(_ start: String, _ end: String) -> String? {
        guard let startIndex = range(of: start)?.upperBound,
              let endIndex = range(of: end, range: startIndex ..< endIndex)?.lowerBound else {
            return nil
        }
        return String(self[startIndex ..< endIndex])
    }
}




