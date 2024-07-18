import UIKit

protocol KycPageViewControllerDelegate: AnyObject {
    func finishCarousel()
}

class KycPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    weak var carouselDelegate: KycPageViewControllerDelegate?

    private var pages: [UIViewController] = []
    private let theme = ComplianceSDK.shared.configuration.theme

    private let closeButton: UIButton = {
        let button = UIButton(type: .custom)
        let closeImage = UIImage(name: "close2")
        button.setImage(closeImage, for: .normal)
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let indicatorContainer = UIView()
    private let indicator: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var currentPageIndex: Int = 0 {
        didSet {
            updateIndicator()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        view.backgroundColor = theme.color.surfaceBackgroundPrimary

        // Instantiate each step's view controller
        let step1VC = KycStep1ViewController()
        let step2VC = KycStep2ViewController()
        let step3VC = KycStep3ViewController()

        // Set the delegate
        step1VC.delegate = self
        step2VC.delegate = self
        step3VC.delegate = self

        // Add to pages array
        pages = [step1VC, step2VC, step3VC]

        // Set the initial view controller
        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Add close button and indicator to the view
        setupCloseButton()
        setupIndicator()
    }

    private func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        closeButton.addTarget(self, action: #selector(handleCloseButtonClicked), for: .touchUpInside)
    }

    private func setupIndicator() {
        view.addSubview(indicatorContainer)
        indicatorContainer.translatesAutoresizingMaskIntoConstraints = false
        indicatorContainer.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16).isActive = true
        indicatorContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        indicatorContainer.heightAnchor.constraint(equalToConstant: 4).isActive = true

        indicatorContainer.addSubview(indicator)
        indicator.leadingAnchor.constraint(equalTo: indicatorContainer.leadingAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: indicatorContainer.centerYAnchor).isActive = true

        for _ in pages {
            let dot = UIView()
            dot.widthAnchor.constraint(equalToConstant: 8).isActive = true
            dot.heightAnchor.constraint(equalToConstant: 8).isActive = true
            dot.backgroundColor = .lightGray
            dot.layer.cornerRadius = 4
            indicator.addArrangedSubview(dot)
        }
        updateIndicator()
    }
    
    private func updateIndicator() {
        for (index, view) in indicator.arrangedSubviews.enumerated() {
            if let dot = view as? UIView {
                dot.backgroundColor = index == currentPageIndex ? theme.color.sendPrimary : .lightGray
                if let widthConstraint = dot.constraints.first(where: { $0.firstAttribute == .width }) {
                    widthConstraint.isActive = false
                }
                dot.widthAnchor.constraint(equalToConstant: index == currentPageIndex ? 24 : 8).isActive = true
            }
        }
    }

    @objc func handleCloseButtonClicked() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < (pages.count - 1) else {
            return nil
        }
        return pages[index + 1]
    }

    // MARK: - UIPageViewControllerDelegate

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let visibleVC = viewControllers?.first, let index = pages.firstIndex(of: visibleVC) {
            currentPageIndex = index
        }
    }
}

extension KycPageViewController: KycStep1ViewControllerDelegate, KycStep2ViewControllerDelegate, KycStep3ViewControllerDelegate {
    func onNext(from viewController: UIViewController) {
        if let currentIndex = pages.firstIndex(of: viewController) {
            if currentIndex < (pages.count - 1) {
                setViewControllers([pages[currentIndex + 1]], direction: .forward, animated: true, completion: nil)
                currentPageIndex = currentIndex + 1
            } else {
                // Last step, finish the carousel
                carouselDelegate?.finishCarousel()
                handleCloseButtonClicked()
            }
        }
    }

    func goBack(from viewController: UIViewController) {
        if let currentIndex = pages.firstIndex(of: viewController), currentIndex > 0 {
            setViewControllers([pages[currentIndex - 1]], direction: .reverse, animated: true, completion: nil)
            currentPageIndex = currentIndex - 1
        }
    }
}



