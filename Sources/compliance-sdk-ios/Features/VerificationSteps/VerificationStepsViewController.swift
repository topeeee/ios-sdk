//
//  VerificationStepsViewController.swift
//
//  Created by Mayowa Olunuga on 20/11/2023.
//

import UIKit

import SwiftUI






protocol VerificationStepsViewControllerDelegate: AnyObject {
    func onSaveLaterCliced()
    func onSaveClicked()
}

class VerificationStepsViewController: UIViewController, F4bDialogDelegate{
    let modalView =  F4bDialogViewController()
   weak var delegate: VerificationStepsViewControllerDelegate?
    
    private var layout = VerificationStepsLayout()
    private let theme = ComplianceSDK.shared.configuration.theme
    private let idOptions = ["Driver's license","International passport","Voters card"]
    private let pickerView = UIPickerView()
   
   
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
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        layout.continueButton.addTarget(self, action: #selector(presentSuccessModal), for: .touchUpInside)
        layout.laterButton.addTarget(self, action: #selector(handleSaveLaterButtonClicked), for: .touchUpInside)
        layout.idSelection.textField.inputView = pickerView
        layout.idSelection.textField.setInputMode(to: .pickerView)
        
        modalView.laterButton.addTarget(self, action: #selector(onCancelClicked), for: .touchUpInside)
    
    }
    
   
    @objc func presentSuccessModal() {
        modalView.modalPresentationStyle = .overFullScreen
        modalView.modalTransitionStyle = .coverVertical
        modalView.delegate = self
    self.present(modalView, animated: true)
    }
   
    


    
    @objc func handleSaveButtonClicked() {
        delegate?.onSaveClicked()
    }
    
    @objc func handleSaveLaterButtonClicked() {
        delegate?.onSaveLaterCliced()
    }
    

    
    @objc func onCancelClicked() {
            modalView.dismiss(animated: true, completion: nil)
        }
}

extension VerificationStepsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        idOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        idOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        layout.idSelection.text =  idOptions[row]
        layout.idSelection.textField.resignFirstResponder()
    }
    
    func continueButtonTapped() {
        handleSaveButtonClicked()
        }
    
}
