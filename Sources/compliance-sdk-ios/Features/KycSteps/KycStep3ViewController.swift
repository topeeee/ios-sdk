

//
//  KycStep3ViewController.swift
//
//  Created by Tope Ajibuwa on 06/05/2024.
//

import UIKit

protocol KycStep3ViewControllerDelegate: AnyObject {
    func onNext(from viewController: UIViewController)
    func goBack(from viewController: UIViewController)
}

class KycStep3ViewController: UIViewController, IDCaptureViewControllerViewControllerDelegate {
    func onIDCaptured(image: UIImage) {
       
    }
    

    weak var delegate: KycStep3ViewControllerDelegate?
    var coordinator: MainCoordinator?

    private var layout = KycStep3Layout()
    private let theme = ComplianceSDK.shared.configuration.theme

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.color.surfaceBackgroundPrimary
        navigationController?.setNavigationBarHidden(true, animated: false)

        view.addSubview(layout)
        layout.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            padding: .init(
                top: theme.space.oneAndHalf,
                left: theme.space.one,
                bottom: theme.space.one,
                right: theme.space.one)
        )

        layout.continueButton.addTarget(self, action: #selector(handleNextButtonClicked), for: .touchUpInside)
        layout.backButton.addTarget(self, action: #selector(handleBackButtonClicked), for: .touchUpInside)
    }

    @objc func handleNextButtonClicked() {
        delegate?.onNext(from: self)
    }

    @objc func handleBackButtonClicked() {
        delegate?.goBack(from: self)
    }
}


