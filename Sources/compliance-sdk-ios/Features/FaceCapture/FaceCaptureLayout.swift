//
//  FaceCaptureLayout.swift
//
//  Created by Mayowa Olunuga on 27/11/2023.
//

import UIKit

class FaceCaptureLayout: UIView {
    private let theme = ComplianceSDK.shared.configuration.theme
    
    let contentStack = UIStackView()
    let mainStack = UIStackView()
    let textStack = UIStackView()
    
    let cameraView: OvalView = {
       let v = OvalView()
        v.frame = .init(origin: .zero, size: .init(width: 293, height: 386))
        v.borderLayer.strokeColor = UIColor.white.cgColor
        v.backgroundColor = ComplianceSDK.shared.configuration.theme.color.surfaceBackgroundSubdued
        return v
    }()
    
    let capturButtonView = UIView()
    let captureButton: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(name: "capture_button")
        return v
    }()

    let titleLabel: CSLabel = {
        let v = CSLabel(
            text: "Take a selfie",
            style: CSTextStyles.bodyOneBold)
        v.textAlignment = .center
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimaryBright
        return v
    }()
    
    let subtitleLabel: CSLabel = {
        let v = CSLabel(
            text: "Please make sure your face fits into the frame above",
            style: CSTextStyles.bodyTwoMedium)
        v.textAlignment = .center
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimaryBrightSubdued
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cameraView.heightAnchor.constraint(equalToConstant: 386).isActive = true
        cameraView.widthAnchor.constraint(equalToConstant: 293).isActive = true
        
        contentStack.alignment = .center
        contentStack.axis = .vertical
        contentStack.distribution = .fillProportionally
        contentStack.spacing = theme.space.none
        
        mainStack.alignment = .center
        mainStack.axis = .vertical
        mainStack.distribution = .fillProportionally
        mainStack.spacing = theme.space.two
        
        textStack.alignment = .center
        textStack.axis = .vertical
        textStack.distribution = .fillProportionally
        textStack.spacing = theme.space.two
        
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        
        mainStack.addArrangedSubview(cameraView)
        mainStack.addArrangedSubview(textStack)
        
        capturButtonView.addSubview(captureButton)
        captureButton.centerInSuperview(size: .init(width: 80, height: 80))
        
        capturButtonView.translatesAutoresizingMaskIntoConstraints = false
        capturButtonView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        capturButtonView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        contentStack.addArrangedSubview(mainStack)
        
        addSubview(contentStack)
        addSubview(capturButtonView)
        contentStack.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(
                top: theme.space.none,
                left: theme.space.one,
                bottom: theme.space.none,
                right: theme.space.two)
        )
        
        capturButtonView.anchor(bottom: bottomAnchor, padding: .init(top: 0, left: 0, bottom: 53, right: 0), size: .init(width: 80, height: 80))
        capturButtonView.centerXInSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
