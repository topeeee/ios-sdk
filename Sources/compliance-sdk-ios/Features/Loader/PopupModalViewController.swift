import Foundation
import UIKit

public protocol PopUpModalDelegate: AnyObject {
    func continueButtonTapped()
}

class PopUpModalViewController: UIViewController {
    public weak var delegate: PopUpModalDelegate?
    
    public var titleText: String?
    public var bodyText: String?
    public var iconName: String = ""
    
    private lazy var canvas: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: CSLabel = {
        let label = CSLabel(
            text: titleText ?? "Verification in progress",
            style: CSTextStyles.titleTwo)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageLabel: CSLabel = {
        let label = CSLabel(
            text: bodyText ?? "We are working on verifying your identity, we'll let you know once we are done",
            style: CSTextStyles.bodyTwoRegular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(canvas)
        
        // Create a vertical stack view to contain titleLabel, message, and button
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill // Ensure full width alignment
        
        // Add arranged subviews to the stack view
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(continueButton)
        
        canvas.addSubview(stackView)

        // Activate constraints
        NSLayoutConstraint.activate([
            // Canvas constraints
            canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            canvas.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            canvas.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.5),
            
            // StackView constraints
            stackView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor), // Center horizontally
            stackView.centerYAnchor.constraint(equalTo: canvas.centerYAnchor), // Center vertically
            stackView.widthAnchor.constraint(equalTo: canvas.widthAnchor, constant: -32), // Set width to canvas width minus padding
        ])
        
        // Set up the continue button
        continueButton.setContentHuggingPriority(.required, for: .horizontal) // Ensure button hugs content tightly
        continueButton.setContentCompressionResistancePriority(.required, for: .horizontal) // Ensure button doesn't stretch
    }
    
    let continueButton: UIButton = {
        let button = CSButton(
            title: "Continue",
            style: CSButtonStyles.primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20) // Vertical padding
        return button
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(name: iconName)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return imageView
    }()
    
    @objc private func continueButtonTapped() {
        delegate?.continueButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
}

