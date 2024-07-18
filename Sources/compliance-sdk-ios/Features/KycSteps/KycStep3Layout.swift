import UIKit

class KycStep3Layout: UIView {
    let theme = ComplianceSDK.shared.configuration.theme

    let mainStack = UIStackView()
    let stepsStack = UIStackView()
    let buttonStack = UIStackView()

    private let imageContainer = UIView()
    private let iconContainer = UIView()
    private let indicatorContainer = UIView()



    let infoLabel: CSLabel = {
        let v = CSLabel(
            text: "Accepted IDs for verification include:",
            style: CSTextStyles.sendHeadingMedium1
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .left

        return v
    }()
    

    let info1: CSLabel = {
        let v = CSLabel(
            text: "1. International passport",
            style: CSTextStyles.bodyTwoRegular
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .left
        return v
    }()
    let info2: CSLabel = {
        let v = CSLabel(
            text: "2. National ID (NIN slips are not supported)",
            style: CSTextStyles.bodyTwoRegular
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .left
        return v
    }()

    let info3: CSLabel = {
        let v = CSLabel(
            text: "3. Residence Permit",
            style: CSTextStyles.bodyTwoRegular
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .left
        return v
    }()
    
    let info4: CSLabel = {
        let v = CSLabel(
            text: "3. Driver’s License",
            style: CSTextStyles.bodyTwoRegular
        )
        v.numberOfLines = 0
        v.textColor = ComplianceSDK.shared.configuration.theme.color.sendPrimary
        v.textAlignment = .left
        return v
    }()



    let logo: UIImageView = {
        let v = UIImageView(image: UIImage(name: "kyc_logo32"))
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let continueButton: CSButton = {
        let v = CSButton(
            title: "Next",
            style: CSButtonStyles.primarySend)
        return v
    }()
    
    let backButton: CSButton = {
        let v = CSButton(
            title: "Back",
            style: CSButtonStyles.blackBorderedSend)
        return v
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)


        mainStack.alignment = .fill
        mainStack.axis = .vertical
        mainStack.spacing = theme.space.two

        buttonStack.alignment = .fill
        buttonStack.axis = .vertical
        buttonStack.spacing = theme.space.one
        buttonStack.addArrangedSubview(continueButton)
        buttonStack.addArrangedSubview(backButton)

        stepsStack.alignment = .fill
        stepsStack.axis = .vertical
        stepsStack.spacing = theme.space.one


        info1.setContentHuggingPriority(.defaultLow, for: .horizontal) // Lowest hugging value
        info1.setContentCompressionResistancePriority(.defaultLow, for: .horizontal) //

        stepsStack.addArrangedSubview(infoLabel)
        stepsStack.addArrangedSubview(info1)
        stepsStack.addArrangedSubview(info2)
        stepsStack.addArrangedSubview(info3)
        stepsStack.addArrangedSubview(info4)


        imageContainer.addSubview(logo)

        // Add constraints for logo
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor).isActive = true
        logo.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor).isActive = true
        logo.heightAnchor.constraint(equalToConstant: 160).isActive = true
        logo.topAnchor.constraint(equalTo: imageContainer.topAnchor).isActive = true
        logo.contentMode = .scaleAspectFill

        mainStack.addArrangedSubview(iconContainer)
        mainStack.addArrangedSubview(indicatorContainer)
        mainStack.addArrangedSubview(imageContainer)
        mainStack.addArrangedSubview(stepsStack)
        mainStack.addArrangedSubview(buttonStack)

        addSubview(mainStack)
        mainStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)

        // Adjust constraints to create space between logo and text stack
        let padding: CGFloat = 24 // Adjust as needed
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor).isActive = true
        imageContainer.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor).isActive = true
        imageContainer.heightAnchor.constraint(equalToConstant: 160).isActive = true

        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor).isActive = true
        iconContainer.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor).isActive = true
        iconContainer.heightAnchor.constraint(equalToConstant: 24).isActive = true

        indicatorContainer.heightAnchor.constraint(equalToConstant: 8).isActive = true

        stepsStack.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: padding).isActive = true

            addSubview(buttonStack)
            buttonStack.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
       
    }



    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
