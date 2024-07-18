//  File.swift
//  Created by Tope Ajibuwa on 27/05/2024.

import Foundation
import UIKit

public protocol F4bDialogDelegate: AnyObject {
    func continueButtonTapped()
}

class F4bDialogViewController: UIViewController {
    public weak var delegate: F4bDialogDelegate?
    
    private lazy var canvas: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let buttonStack = UIStackView()
    let infoStackView = UIStackView()
    let imageStackView = UIStackView()
    
    lazy var headingLabel: CSLabel = { [weak self] in
        guard let self = self else { fatalError("Unable to capture self") }
        let v = CSLabel(
            text: "Flutterwave wants to access your personal data information",
            style: CSTextStyles.titleTwo18)
        v.numberOfLines = 0
        v.textAlignment = .center
        v.textColor = ComplianceSDK.shared.configuration.theme.color.surfaceTextPrimary
        return v
    }()
    
    lazy var subtitleLabel: CSLabel = { [weak self] in
        guard let self = self else { fatalError("Unable to capture self") }
        let v = CSLabel(
            text: "This gives Flutterwave access to:",
            style: CSTextStyles.bodyTwoRegular18)
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.grey60
        v.textAlignment = .center
        return v
    }()
    
    let continueButton: UIButton = {
        let button = CSButton(
            title: "Continue",
            style: CSButtonStyles.primary)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let infoText: CSLabel = {
        let v = CSLabel(
            text: "Process your personal details and contact information",
            style: CSTextStyles.bodyTwoRegular18)
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.grey60
        v.textAlignment = .left
        return v
    }()
    
    lazy var policyTextView: UITextView = { [weak self] in
        guard let self = self else { fatalError("Unable to capture self") }
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .center
        textView.backgroundColor = UIColor(rgb: 0xF2F2F2)
        
        textView.layer.cornerRadius = 8
        textView.layer.masksToBounds = true
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        // Add padding to the text view
        textView.textContainerInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        
        let policyText = "By clicking on \"Allow\" you agree that you read and accepted Flutterwave’s policy"
        let attributedString = NSMutableAttributedString(string: policyText)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: UIColor(rgb: 0x828282), range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, attributedString.length))
        
        // Add a clickable link for "Send App's policy"
        let linkText = "Flutterwave’s policy"
        let policyLinkRange = (attributedString.string as NSString).range(of: linkText)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: policyLinkRange)
        let policyURL = URL(string: "https://send.flutterwave.com/legal/terms/")
        attributedString.addAttribute(.link, value: policyURL, range: policyLinkRange)
        
        textView.attributedText = attributedString
        return textView
    }()
    
    public var laterButton: CSButton = {
        let v = CSButton(
            title: "Cancel",
            style: CSButtonStyles.blackInverted)
        return v
    }()
    
    let logo: UIImageView = {
        let v = UIImageView(image: UIImage(name: "flutterwave_logo"))
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let checkIconSteps: UIImageView = {
        let v = UIImageView(image: UIImage(systemName: "checkmark"))
        v.contentMode = .scaleAspectFit
        v.tintColor = ComplianceSDK.shared.configuration.theme.color.black
        v.widthAnchor.constraint(equalToConstant: 24).isActive = true // Set width to 24
        v.heightAnchor.constraint(equalToConstant: 18).isActive = true // Set height to 18
        return v
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(canvas)
        
        // Create a vertical stack view to contain titleLabel, message, and button
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
       
    
        
        buttonStack.alignment = .fill
        buttonStack.axis = .vertical
        buttonStack.spacing = 10
        buttonStack.distribution = .fillEqually
        
        infoStackView.axis = .horizontal
        infoStackView.alignment = .top
        
        buttonStack.addArrangedSubview(continueButton)
        buttonStack.addArrangedSubview(laterButton)
        
        infoStackView.addArrangedSubview(checkIconSteps)
        infoStackView.addArrangedSubview(infoText)
        
        let spacerView = UIView()
        spacerView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        // Add arranged subviews to the stack view
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(headingLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(infoStackView)
        stackView.addArrangedSubview(policyTextView)
        stackView.addArrangedSubview(spacerView) // Add the spacer view here
        stackView.addArrangedSubview(buttonStack)
        
        canvas.addSubview(stackView)
        
        // Activate constraints
        NSLayoutConstraint.activate([
            // Canvas constraints
            canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            canvas.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            canvas.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            // StackView constraints
            stackView.topAnchor.constraint(equalTo: canvas.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: canvas.bottomAnchor, constant: -16),
            
            // Logo constraints
            logo.widthAnchor.constraint(equalToConstant: 50),
            logo.heightAnchor.constraint(equalToConstant: 40),
            
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            laterButton.heightAnchor.constraint(equalToConstant: 50),
            checkIconSteps.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 4),
            infoText.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 0)
        ])
    }
    
    @objc private func continueButtonTapped() {
        delegate?.continueButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
}

