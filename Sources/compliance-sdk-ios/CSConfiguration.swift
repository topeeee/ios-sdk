//
//  CSConfiguration.swift
//
//  Created by Mayowa Olunuga on 18/11/2023.
//

import Foundation
import UIKit

public protocol CSConfiguration {
    var theme: CSTheme { get set }
    var platformType: PlatformType { get set } 
    //var strings: CSStrings { get set }
}

public extension CSConfiguration {
    var theme: CSTheme  {DefaultSDKTheme()}
}

//THEME

public protocol CSTheme {
    var color: CSColor { get set  }
    var space: CSSpace { get set  }
}

public protocol CSSpace {
    var none: CGFloat { get set }
    var half: CGFloat { get set }
    var one: CGFloat { get set }
    var oneAndHalf: CGFloat { get set }
    var two: CGFloat { get set }
}

public protocol CSColor {
    var primaryColor: UIColor { get set }
    var secondaryColor: UIColor { get set }
    
    var black: UIColor { get set }
    var surfaceTextSecondary: UIColor { get set }
    var surfaceTextPrimaryBright: UIColor { get set }
    var surfaceTextPrimaryBrightSubdued: UIColor { get set }
    var surfaceTextPrimary: UIColor { get set }
    var surfaceTextPrimarySubdued: UIColor { get set }
    var surfaceBackgroundPrimary: UIColor { get set }
    var decorativeDark: UIColor { get set }
    var surfaceBackgroundSubdued: UIColor { get set }
    var grey40: UIColor { get set }
    var grey60: UIColor { get set }
    var sendPrimary: UIColor { get set }
    var sendSecondary: UIColor { get set }
}

//STRINGS

public protocol CSStrings {
    var captureText: String { get set }
    var nextText: String { get set }
}

public protocol CSType {
    var type: String { get set }

}

//LINKS

public protocol CSLinks {
    var termsAndConditionsLink: URL { get set }
    var privacyPolicyLink: URL { get set }
}

// Added new protocol for platformType
public enum PlatformType: String {
    case send = "send"
    case f4b = "f4b"
}

