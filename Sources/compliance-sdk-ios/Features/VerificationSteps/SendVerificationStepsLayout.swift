import UIKit

class SendVerificationStepsLayout: UIView {
    let theme = ComplianceSDK.shared.configuration.theme
    
    let mainStack = UIStackView()
    let headingStack = UIStackView()
    let stepsStack = UIStackView()
    let itemsStack1 = UIStackView()
    let itemsStack2 = UIStackView()
    let buttonStack = UIStackView()

    private let imageContainer = UIView()
    
    let headingLabel: CSLabel = {
        let v = CSLabel(
            text: "Verify account",
            style: CSTextStyles.sendHeading1)
        v.textAlignment = .center
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        return v
    }()
    
    let subtitleLabel: CSLabel = {
        let v = CSLabel(
            text: "A valid government-issued ID is required to complete your profile.",
            style: CSTextStyles.bodyTwoMedium16
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .center
    
        return v
    }()
    
    let infoLabel: CSLabel = {
        let v = CSLabel(
            text: "The Send app is required by law to collect your Identity Card to confirm your identity.",
            style: CSTextStyles.bodyTwoRegular
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .center
        return v
    }()
    
    let infoLabelTitle2: CSLabel = {
        let v = CSLabel(
            text: "We protect your privacy",
            style: CSTextStyles.bodyTwoMedium16
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .center
    
        return v
    }()
    
    let infoLabelTitle3: CSLabel = {
        let v = CSLabel(
            text: "Encrypted and Secure",
            style: CSTextStyles.bodyTwoMedium16
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .center
    
        return v
    }()
    
    
    
    let infoLabel2: CSLabel = {
        let v = CSLabel(
            text: "Your Identity card will not be shared without your permission, except as required by law.",
            style: CSTextStyles.bodyTwoRegular
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .center
        return v
    }()
    
    let infoLabel3: CSLabel = {
        let v = CSLabel(
            text: "Your Identity card will be encrypted and transmitted to us via secure (TLSS) connection.",
            style: CSTextStyles.bodyTwoRegular
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .center
        return v
    }()
    
    let logo: UIImageView = {
        let v = UIImageView(image: UIImage(name: "camera"))
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let continueButton: CSButton = {
        let v = CSButton(
            title: "Continue",
            style: CSButtonStyles.primarySend)
        return v
    }()
    
    let laterButton: CSButton = {
        let v = CSButton(
            title: "I'll do this later",
            style: CSButtonStyles.blackBorderedSend)
        return v
    }()
    
    let learnButton: CSButton = {
        let v = CSButton(
            title: "Learn more about verification?",
            style: CSButtonStyles.blackInvertedSend)
        return v
    }()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headingStack.alignment = .fill
        headingStack.axis = .vertical
        headingStack.spacing = theme.space.one
        
        itemsStack1.alignment = .fill
        itemsStack1.axis = .vertical
        itemsStack1.spacing = theme.space.half
        
        itemsStack2.alignment = .fill
        itemsStack2.axis = .vertical
        itemsStack2.spacing = theme.space.half
        
    
        
        headingStack.addArrangedSubview(headingLabel)
        headingStack.addArrangedSubview(subtitleLabel)
        
        mainStack.alignment = .fill
        mainStack.axis = .vertical
        mainStack.spacing = theme.space.two
        
        buttonStack.alignment = .fill
        buttonStack.axis = .vertical
        buttonStack.spacing = theme.space.one
        buttonStack.addArrangedSubview(continueButton)
        buttonStack.addArrangedSubview(laterButton)
        buttonStack.addArrangedSubview(learnButton)
        
      
        
        stepsStack.alignment = .fill
        stepsStack.axis = .vertical
        stepsStack.spacing = theme.space.two
        
        itemsStack1.addArrangedSubview(infoLabelTitle2)
        itemsStack1.addArrangedSubview(infoLabel2)
        
        itemsStack2.addArrangedSubview(infoLabelTitle3)
        itemsStack2.addArrangedSubview(infoLabel3)
        
    
        
        stepsStack.addArrangedSubview(infoLabel)
        
        stepsStack.addArrangedSubview(itemsStack1)
        stepsStack.addArrangedSubview(itemsStack2)
        
        imageContainer.addSubview(logo)
        
        logo.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
        logo.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        
        // Add imageContainer to mainStack
        mainStack.addArrangedSubview(headingStack)
        mainStack.addArrangedSubview(imageContainer)
        mainStack.addArrangedSubview(stepsStack)
        mainStack.addArrangedSubview(buttonStack)
       
        
        addSubview(mainStack)
        mainStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        
        // Adjust constraints to create space between logo and text stack
        let padding: CGFloat = 24 // Adjust as needed
        imageContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true // Adjust height as needed
        stepsStack.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: padding).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

