//
//  StepItem.swift
//
//  Created by Mayowa Olunuga on 03/12/2023.
//

import UIKit

class StepItem: UIView {
    
    private let theme = ComplianceSDK.shared.configuration.theme
    private let contentStack = UIStackView()
    private let mainStack = UIStackView()
    private let imageContainer = UIView()
    
    public let headingLabel: CSLabel = {
        let v = CSLabel(
            text: "...",
            style: CSTextStyles.bodyTwoBold)
        v.textAlignment = .left
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimary
        return v
    }()
    
    public let subtitleLabel: CSLabel = {
        let v = CSLabel(
            text: "...",
            style: CSTextStyles.bodyTwoRegular)
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimary
        v.textAlignment = .left
        return v
    }()
    
    public let icon: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentStack.alignment = .fill
        contentStack.axis = .vertical
        contentStack.spacing = theme.space.half
        
        mainStack.alignment = .top
        mainStack.distribution = .fill
        mainStack.axis = .horizontal
        mainStack.spacing = theme.space.half
        
        contentStack.addArrangedSubview(headingLabel)
        contentStack.addArrangedSubview(subtitleLabel)
        
        imageContainer.addSubview(icon)
        
        mainStack.addArrangedSubview(imageContainer)
        mainStack.addArrangedSubview(contentStack)
        
        icon.anchor(
            top: imageContainer.topAnchor,
            leading: imageContainer.leadingAnchor,
            trailing: imageContainer.trailingAnchor,
            size: .init(
                width: 40,
                height: 40))
        
        addSubview(mainStack)
        mainStack.fillSuperview()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
