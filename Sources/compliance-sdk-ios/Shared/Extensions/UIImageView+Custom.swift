//
//  UIImageView+Custom.swift
//
//  Created by Mayowa Olunuga on 03/12/2023.
//

import UIKit

public extension UIImage {

    convenience init?(name: String) {
        self.init(named: name, in: .module, compatibleWith: nil)
    }
}


public extension UITextField {
    func setInputMode(to mode: InputMode) {
        switch mode {
        case .pickerView:
            let theme = ComplianceSDK.shared.configuration.theme
            let caret = UIImageView()
            caret.frame = CGRect(x: 0, y: 0, width: theme.space.one, height: theme.space.one)
            caret.image = UIImage(named: "chevron_right")
            self.rightView = caret
            self.rightViewMode = .always
        }
    }
    
    enum InputMode {
        case pickerView
    }
}
