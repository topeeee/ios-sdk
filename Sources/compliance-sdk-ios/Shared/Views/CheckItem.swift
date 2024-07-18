//
//  CheckItem.swift
//
//  Created by Mayowa Olunuga on 27/11/2023.
//

import UIKit

class CheckItem: UIView {
    
    private let theme = ComplianceSDK.shared.configuration.theme
    private let mainStack = UIStackView()
    private let imageContainer = UIView()
    
    public let textabel: CSLabel = {
        let v = CSLabel(
            text: "...",
            style: CSTextStyles.bodyOneMedium)
        v.textAlignment = .left
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimary
        return v
    }()
    
    public let icon: UIImageView = {
        let v = UIImageView()
        v.image = ComplianceSDK.shared.configuration.platformType == .send ? UIImage(name: "send_check") : UIImage(name: "check_icon")
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainStack.alignment = .center
        mainStack.distribution = .fill
        mainStack.axis = .horizontal
        mainStack.spacing = theme.space.one
        
        mainStack.addArrangedSubview(imageContainer)
        mainStack.addArrangedSubview(textabel)
        
        imageContainer.addSubview(icon)
        
        icon.centerInSuperview(size: .init(width: 12, height: 8))
        icon.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: imageContainer.topAnchor).isActive = true
        icon.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor).isActive = true
        
        addSubview(mainStack)
        mainStack.fillSuperview()
        
        icon.tintColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
