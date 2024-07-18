//
//  FaceCapturePreviewViewController.swift
//
//  Created by Mayowa Olunuga on 03/12/2023.
//

import UIKit

protocol FaceCapturePreviewViewDelegate: AnyObject {
    func onFaceCaptureContinueClicked()
    func onFaceCaptureRetakeClicked()
}

class FaceCapturePreviewViewController: UIViewController {
    private var layout = FaceCapturePreviewViewLayout()
    private let theme = ComplianceSDK.shared.configuration.theme
    private let platformType = ComplianceSDK.shared.configuration.platformType
    
    weak var delegate: FaceCapturePreviewViewDelegate?
    var capturedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.color.surfaceBackgroundPrimary
        
        view.addSubview(layout)
        layout.fillSuperview()
        
        layout.continueButton.addTarget(self, action: #selector(handleOnContinueClicked), for: .touchUpInside)
        layout.retakeButton.addTarget(self, action: #selector(handleOnRetakeClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = platformType == .send ? theme.color.sendSecondary : theme.color.surfaceTextSecondary
        
        
        
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.navigationBar.tintColor = .white
        }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let capturedImage = capturedImage else { return }
        layout.imagePreview.image = capturedImage
    }
    
    @objc func handleOnContinueClicked() {
        delegate?.onFaceCaptureContinueClicked()
    }
    
    @objc func handleOnRetakeClicked() {
        delegate?.onFaceCaptureRetakeClicked()
    }
}

