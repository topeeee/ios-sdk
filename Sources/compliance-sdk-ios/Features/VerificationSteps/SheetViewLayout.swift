//
//  SheetViewLayout.swift
//  sample-app
//
//  Created by Tope Ajibuwa on 25/01/2024.
//

import Foundation

import UIKit

class SheetViewLayout: UIView {
    let theme = ComplianceSDK.shared.configuration.theme
    
    let mainStack = UIStackView()
    let headingStack = UIStackView()
    let stepsStack = UIStackView()
    let buttonStack = UIStackView()
    let imageContainer = UIStackView()
    let infoStackView = UIStackView()

    

    lazy var headingLabel: CSLabel = { [weak self] in
            guard let self = self else { fatalError("Unable to capture self") }
            let v = CSLabel(
                text: "Sendapp wants to access your personal data informaton",
                style: CSTextStyles.buttonMediumSend18)
        v.numberOfLines = 0
        v.textAlignment = .center
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        return v
        }()
    

    lazy var subtitleLabel: CSLabel = { [weak self] in
            guard let self = self else { fatalError("Unable to capture self") }
            let v = CSLabel(
                text: "This gives Send access to:",
                style: CSTextStyles.bodyTwoRegular18)
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .center
        return v
        }()
    
    let infoText: CSLabel = {
        let v = CSLabel(
            text: "Process your personal details and contact information",
            style: CSTextStyles.bodyTwoRegular18)
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .center
        return v
    }()
    
    lazy var policyTextView: UITextView = { [weak self] in
        guard let self = self else { fatalError("Unable to capture self") }
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.backgroundColor = UIColor(rgb: 0xDCE2FB)


        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8

        // Add padding to the text view
        textView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)

        let policyText = "By clicking on \"Allow\" you agree that you read and accepted Send App’s policy"
        let attributedString = NSMutableAttributedString(string: policyText)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor(rgb: 0x273875), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, attributedString.length))


        // Add a clickable link for "Send App's policy"
        let linkText = "Send App’s policy"
        let policyLinkRange = (attributedString.string as NSString).range(of: linkText)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: policyLinkRange)
        let policyURL = URL(string: "https://send.flutterwave.com/legal/terms/")
        attributedString.addAttribute(.link, value: policyURL, range: policyLinkRange)

        textView.attributedText = attributedString
        return textView
    }()

    
    
    let continueButton: CSButton = {
        let v = CSButton(
            title: "Allow",
            style: CSButtonStyles.primarySend)
        return v
    }()
    
    let laterButton: CSButton = {
        let v = CSButton(
            title: "Cancel",
            style: CSButtonStyles.blackBorderedSend)
        return v
    }()
    
    let logo: UIImageView = {
            let v = UIImageView(image: UIImage(name: "send_logo"))
            v.contentMode = .scaleAspectFit
            v.translatesAutoresizingMaskIntoConstraints = false
            return v
        }()
    
    let checkIconSteps: UIImageView = {
        let v = UIImageView(image: UIImage(systemName: "checkmark"))
        v.contentMode = .scaleAspectFit
        v.tintColor = UIColor(rgb: 0x21C863) // Set color to black
        v.widthAnchor.constraint(equalToConstant: 24).isActive = true // Set width to 24
        v.heightAnchor.constraint(equalToConstant: 18).isActive = true // Set height to 24
        return v
    }()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headingStack.alignment = .fill
        headingStack.axis = .vertical
        headingStack.spacing = theme.space.one
        
        headingStack.addArrangedSubview(headingLabel)
        headingStack.addArrangedSubview(subtitleLabel)
        
        mainStack.alignment = .fill
        mainStack.axis = .vertical
        mainStack.spacing = theme.space.one
        
        imageContainer.addSubview(logo)
        
        logo.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
        logo.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true

        
        stepsStack.alignment = .fill
        stepsStack.axis = .vertical
        stepsStack.spacing = theme.space.one
        
        
        buttonStack.alignment = .fill
        buttonStack.axis = .vertical
        buttonStack.spacing = theme.space.one
        
        
        infoStackView.axis = .horizontal
        infoStackView.alignment = .top
        
        infoStackView.addArrangedSubview(checkIconSteps)
        infoStackView.addArrangedSubview(infoText)
       

        // Add the horizontal stack view to stepsStack
        stepsStack.addArrangedSubview(infoStackView)
        
        buttonStack.addArrangedSubview(continueButton)
        buttonStack.addArrangedSubview(laterButton)
        
        
        mainStack.addArrangedSubview(imageContainer)
        mainStack.addArrangedSubview(headingStack)
        mainStack.addArrangedSubview(stepsStack)
        mainStack.addArrangedSubview(policyTextView)
        mainStack.addArrangedSubview(buttonStack)
        
        addSubview(mainStack)
        mainStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

