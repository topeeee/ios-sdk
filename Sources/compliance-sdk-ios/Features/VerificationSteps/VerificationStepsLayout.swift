//
//  VerificationStepsLayout.swift
//
//  Created by Mayowa Olunuga on 03/12/2023.
//

import UIKit

class VerificationStepsLayout: UIView {
    let theme = ComplianceSDK.shared.configuration.theme
    
    let mainStack = UIStackView()
    let headingStack = UIStackView()
    let stepsStack = UIStackView()
    let selectionStack = UIStackView()
    let buttonStack = UIStackView()
    
    let headingLabel: CSLabel = {
        let v = CSLabel(
            text: "Verify your identity",
            style: CSTextStyles.titleTwo)
        v.textAlignment = .left
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimary
        return v
    }()
    
    let subtitleLabel: CSLabel = {
        let v = CSLabel(
            text: "Kindly ensure the following for a successful verification",
            style: CSTextStyles.bodyTwoRegular)
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimary
        v.textAlignment = .left
        return v
    }()
    
    var idSelection: CSTextInput = {
        let v = CSTextInput(
            style: CSInputStyles.primary,
            label: "Which government ID document do you want to use?",
            text: nil,
            placeHolder: "Select ID type")
        return v
    }()
    
    var pickerView = UIPickerView()
    
    let continueButton: CSButton = {
        let v = CSButton(
            title: "Save and Continue",
            style: CSButtonStyles.primary)
        return v
    }()
    
    let laterButton: CSButton = {
        let v = CSButton(
            title: "I'll do this later",
            style: CSButtonStyles.blackInverted)
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
        mainStack.spacing = theme.space.two
        
        stepsStack.alignment = .fill
        stepsStack.axis = .vertical
        stepsStack.spacing = theme.space.one
        
        selectionStack.alignment = .fill
        selectionStack.axis = .vertical
        selectionStack.spacing = theme.space.one
        
        buttonStack.alignment = .fill
        buttonStack.axis = .vertical
        buttonStack.spacing = theme.space.one
        
        let selfieStep = StepItem()
        selfieStep.icon.image = UIImage(name: "selfie_icon")
        selfieStep.headingLabel.text = "Take a selfie"
        selfieStep.subtitleLabel.text = "Make sure you’re directly facing the camera in a well lit background and nothing is covering your face."
        
        let idStep = StepItem()
        idStep.icon.image = UIImage(name: "selfie_icon")
        idStep.headingLabel.text = "Prepare a valid Identity document"
        idStep.subtitleLabel.text = "Ensure it’s not physically damaged and has not expired."
        
        let smartPhoneStep = StepItem()
        smartPhoneStep.icon.image = UIImage(name: "smart_phone_icon")
        smartPhoneStep.headingLabel.text = "Use a smart phone"
        smartPhoneStep.subtitleLabel.text = "To complete ID verification, please ensure that you’re on your smart phone."
        
        stepsStack.addArrangedSubview(selfieStep)
        stepsStack.addArrangedSubview(idStep)
        stepsStack.addArrangedSubview(smartPhoneStep)
        
        buttonStack.addArrangedSubview(continueButton)
        buttonStack.addArrangedSubview(laterButton)
        
        mainStack.addArrangedSubview(headingStack)
        mainStack.addArrangedSubview(stepsStack)
        mainStack.addArrangedSubview(idSelection)
        mainStack.addArrangedSubview(buttonStack)
        
        addSubview(mainStack)
        mainStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
