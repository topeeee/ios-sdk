
////  KycStep1ViewController.swift
////
////  Created by Tope Ajibuwa on 06/05/2024.

import UIKit
import SwiftUI


protocol KycStep1ViewControllerDelegate: AnyObject {
    func onNext(from viewController: UIViewController)
}

class KycStep1ViewController: UIViewController {

    weak var delegate: KycStep1ViewControllerDelegate?
    private var layout = KycStep1Layout()
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
    }

    @objc func handleNextButtonClicked() {
        delegate?.onNext(from: self)
    }
}

