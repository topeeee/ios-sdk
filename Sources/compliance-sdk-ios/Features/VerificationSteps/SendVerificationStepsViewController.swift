
//  SendVerificationStepsViewController.swift
//
//  Created by Tope Ajibuwa on 06/05/2024.
//

import UIKit
import SwiftUI

protocol SendVerificationStepsViewControllerDelegate: AnyObject {
    func onSaveLater()
    func onSave()
}

class SendVerificationStepsViewController: UIViewController, SheetViewControllerDelegate {
    let sheetTVC = SheetViewController()

    func onAllowClicked() {
        sheetTVC.dismiss(animated: true, completion: nil)
        handleContinueButtonClicked()
    }

    func onCancelClicked() {
        sheetTVC.dismiss(animated: true, completion: nil)
    }

    weak var delegate: SendVerificationStepsViewControllerDelegate?

    private var layout = SendVerificationStepsLayout()
    private let theme = ComplianceSDK.shared.configuration.theme

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.color.surfaceBackgroundPrimary

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

        layout.continueButton.addTarget(self, action: #selector(presentCustomSheet), for: .touchUpInside)
        layout.laterButton.addTarget(self, action: #selector(handleSaveLaterButtonClicked), for: .touchUpInside)
       
    }

    @objc func presentCustomSheet() {
        sheetTVC.delegate = self
        if let sheet = sheetTVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 24
            sheetTVC.isModalInPresentation = true
        }

        self.present(self.sheetTVC, animated: true, completion: nil)
    }

    @objc func handleFinishCarousel() {
        delegate?.onSave()
    }

    @objc func handleContinueButtonClicked() {
        delegate?.onSave()
    }

    @objc func handleSaveLaterButtonClicked() {
        delegate?.onSaveLater()
    }
    

}

extension SendVerificationStepsViewController: KycPageViewControllerDelegate {
    func finishCarousel() {
        handleFinishCarousel()
    }
}

