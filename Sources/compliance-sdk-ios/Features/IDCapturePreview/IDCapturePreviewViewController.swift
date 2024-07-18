//
//  File.swift
//  
//
//  Created by Mayowa Olunuga on 03/12/2023.
//

import UIKit
import CryptoKit

//Technically, we should be able to re-use the face-preview but
//just incase we need to do extra check differenly, it's best we separate this

//protocol IDCapturePreviewViewDelegate: AnyObject {
//    func onUploadClicked()
//    
//}

protocol IDCapturePreviewViewDelegate: AnyObject {
    func onIDCaptureContinueClicked()
    func onIDCaptureRetakeClicked()
}

class IDCapturePreviewViewController: UIViewController {
    
    
    private var layout = IDCapturePreviewViewLayout()
    private let theme = ComplianceSDK.shared.configuration.theme
    private let platformType = ComplianceSDK.shared.configuration.platformType
    weak var delegate: IDCapturePreviewViewDelegate?
    
    var capturedImage: UIImage?
    var capturedFaceImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.color.surfaceBackgroundPrimary
        
        view.addSubview(layout)
        layout.fillSuperview()
        layout.retakeButton.addTarget(self, action: #selector(retakeButtonTapped), for: .touchUpInside)
        layout.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
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
    
    @objc func continueButtonTapped() {
            delegate?.onIDCaptureContinueClicked()
        }
    
    @objc func retakeButtonTapped() {
            delegate?.onIDCaptureRetakeClicked()
        }

    
}
