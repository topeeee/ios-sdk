//
//  SheetViewController.swift
//  sample-app
//
//  Created by Tope Ajibuwa on 25/01/2024.



import Foundation
import UIKit

protocol ModalViewControllerDelegate: AnyObject {
    func onAllowClicked()
    func onCancelClicked()
}

class ModalViewController: UIViewController {
    private var layout = ModalViewLayout()
    private let theme = ComplianceSDK.shared.configuration.theme
    weak var delegate: ModalViewControllerDelegate?
    
    public var titleText: String? {
        didSet {
            layout.updateTitle(titleText ?? "")
        }
    }
    public var bodyText: String? {
        didSet {
            layout.updateBody(bodyText ?? "")
        }
    }
    public var iconName: String = "" {
        didSet {
            layout.updateIcon(iconName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(layout)
        
        layout.continueButton.addTarget(self, action: #selector(handleAllowButtonClicked), for: .touchUpInside)
        
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
    }

    @objc func handleAllowButtonClicked() {
        delegate?.onAllowClicked()
    }

    @objc func handleCancelButtonClicked() {
        delegate?.onCancelClicked()
    }
}
