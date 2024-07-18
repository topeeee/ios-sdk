//
//  ViewController.swift
//  sample-app
//
//  Created by Mayowa Olunuga on 24/11/2023.
//

import UIKit
import compliance_sdk_ios

class ViewController: UIViewController {
    
    let button = UIButton()
    let complianceSDK = ComplianceSDK.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        view.backgroundColor = .white
        
        ComplianceSDK.registerFonts()
        complianceSDK.setConfiguration(config: DefaultSDKConfiguration(platformType: .send))
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.setTitle("Start verification", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(onButtonClicked), for: .touchUpInside)
    }

    @objc private func onButtonClicked() {
        complianceSDK.start(presentingViewController: self)
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}


