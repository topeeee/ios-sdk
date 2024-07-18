
//  SheetViewLayout.swift
//  sample-app

//  Created by Tope Ajibuwa on 25/01/2024.

import Foundation
import UIKit


class ModalViewLayout: UIView {
    let theme = ComplianceSDK.shared.configuration.theme

    let mainStack = UIStackView()
    let headingStack = UIStackView()
    let stepsStack = UIStackView()
    let buttonStack = UIStackView()
    let imageContainer = UIView()

    public func headingLabel(withText text: String) -> CSLabel {
        let v = CSLabel(
            text: text,
            style: CSTextStyles.sendHeading1)
        v.numberOfLines = 0
        v.textAlignment = .center
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimary
        return v
    }

    public func subtitleLabel(withText text: String) -> CSLabel {
        let v = CSLabel(
            text: text,
            style: CSTextStyles.bodyTwoRegular)
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.grey60
        v.textAlignment = .center
        return v
    }

    let continueButton: CSButton = {
        let v = CSButton(
            title: "Continue",
            style: CSButtonStyles.primarySend)
        return v
    }()

    public lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        headingStack.alignment = .fill
        headingStack.axis = .vertical
        headingStack.spacing = theme.space.one

        mainStack.alignment = .fill
        mainStack.axis = .vertical
        mainStack.spacing = theme.space.one

        mainStack.addArrangedSubview(imageContainer)
        mainStack.addArrangedSubview(headingStack)
        mainStack.addArrangedSubview(stepsStack)
        mainStack.addArrangedSubview(buttonStack)

        imageContainer.addSubview(logo)

        // Add labels with default text
        headingStack.addArrangedSubview(headingLabel(withText: "Default Title"))
        headingStack.addArrangedSubview(subtitleLabel(withText: "Default Body"))

        buttonStack.addArrangedSubview(continueButton)

        addSubview(mainStack)

        mainStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)

        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            logo.heightAnchor.constraint(equalToConstant: 80),
            logo.widthAnchor.constraint(equalToConstant: 80),
            imageContainer.heightAnchor.constraint(equalToConstant: 100)
        ])

        mainStack.distribution = .equalSpacing
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateIcon(_ name: String) {
        logo.image = UIImage(name: name)
    }


    func updateTitle(_ text: String) {
        let headingStyle = CSTextStyles.sendHeading1
        // Iterate through the arranged subviews of headingStack
        for subview in headingStack.arrangedSubviews {
            // Check if the subview is a CSLabel and its style matches sendHeading1
            if let label = subview as? CSLabel, label.style.name == headingStyle.name {
                // Update the text of the label
                label.text = text
                return // Exit the function after updating the text
            }
        }
        
        // If no label with sendHeading1 style is found, create a new one and add it to the stack
        let newHeadingLabel = headingLabel(withText: text)
        headingStack.insertArrangedSubview(newHeadingLabel, at: 0)
    }

    func updateBody(_ text: String) {
        let subtitleStyle = CSTextStyles.bodyTwoRegular
        // Iterate through the arranged subviews of headingStack
        for subview in headingStack.arrangedSubviews {
            // Check if the subview is a CSLabel and its style matches bodyTwoRegular
            if let label = subview as? CSLabel, label.style.name == subtitleStyle.name {
                // Update the text of the label
                label.text = text
                return // Exit the function after updating the text
            }
        }
        
        // If no label with bodyTwoRegular style is found, create a new one and add it to the stack
        let newSubtitleLabel = subtitleLabel(withText: text)
        headingStack.insertArrangedSubview(newSubtitleLabel, at: 1)
    }

}
