//
//  IDCapturePreviewViewLayout.swift
//
//  Created by Mayowa Olunuga on 27/11/2023.
//

import UIKit

class IDCapturePreviewViewLayout: UIView {
    private let theme = ComplianceSDK.shared.configuration.theme
    
    let mainStack = UIStackView()
    let checkmarkStack = UIStackView()
    let buttonStack = UIStackView()
    
    let imagePreviewContainer = UIView()
    let imagePreview: UIImageView = {
        let v = UIImageView()
        v.backgroundColor = .white
        v.contentMode = .scaleAspectFill
        return v
    }()

    let titleLabel: CSLabel = {
        let v = CSLabel(
            text: "Check your Photo",
            style: CSTextStyles.titleTwo)
        v.textAlignment = .left
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimary
        return v
    }()
    
    let continueButton: CSButton = {
        let v = CSButton(
            title: "Use this photo",
            style: ComplianceSDK.shared.configuration.platformType == .send ? CSButtonStyles.primarySend : CSButtonStyles.primary)
        return v
    }()
    
    let retakeButton: CSButton = {
        let v = CSButton(
            title: "Retake photo",
            style: ComplianceSDK.shared.configuration.platformType == .send ? CSButtonStyles.blackBorderedSend : CSButtonStyles.primaryClear)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imagePreviewContainer.translatesAutoresizingMaskIntoConstraints = false
        imagePreviewContainer.heightAnchor.constraint(equalToConstant: 255).isActive = true
        imagePreviewContainer.widthAnchor.constraint(equalToConstant: frame.size.width * 0.90).isActive = true
        imagePreviewContainer.layer.cornerRadius = 10
        imagePreviewContainer.layer.masksToBounds = true
        imagePreviewContainer.clipsToBounds = true
        imagePreviewContainer.layer.borderColor = theme.color.surfaceBackgroundSubdued.cgColor
        imagePreviewContainer.layer.borderWidth = 1
        imagePreviewContainer.layer.cornerRadius = 5
        
        mainStack.alignment = .fill
        mainStack.axis = .vertical
        mainStack.spacing = theme.space.one
        
        checkmarkStack.alignment = .leading
        checkmarkStack.axis = .vertical
        checkmarkStack.spacing = theme.space.one
        
        buttonStack.alignment = .fill
        buttonStack.axis = .vertical
        buttonStack.spacing = theme.space.half
        
        buttonStack.addArrangedSubview(continueButton)
        buttonStack.addArrangedSubview(retakeButton)
        
        
        let insideFrameCHeck = CheckItem()
        insideFrameCHeck.textabel.text = "Is the document inside the frame?"
        
        let blurryCheck = CheckItem()
        blurryCheck.textabel.text = "Is the picture clear and not blurry?"
        
        checkmarkStack.addArrangedSubview(insideFrameCHeck)
        checkmarkStack.addArrangedSubview(blurryCheck)
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(imagePreviewContainer)
        mainStack.addArrangedSubview(checkmarkStack)
        mainStack.addArrangedSubview(buttonStack)
        
        mainStack.setCustomSpacing(theme.space.oneAndHalf, after: titleLabel)
        mainStack.setCustomSpacing(theme.space.two, after: checkmarkStack)
        
        imagePreviewContainer.addSubview(imagePreview)
        imagePreview.fillSuperview()
        
        addSubview(mainStack)
        mainStack.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(
                top: theme.space.two,
                left: theme.space.one,
                bottom: theme.space.none,
                right: theme.space.one)
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

