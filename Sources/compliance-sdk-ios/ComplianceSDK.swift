//
//  ComplianceSDK.swift
//
//  Created by Mayowa Olunuga on 18/11/2023.
//

import Foundation
import UIKit

/***
 Required setup steps to be added to SDK documentation
 1 - request privacy camera usage description
 
 */


private class DefaultSDKColor: CSColor {
    //TODO: change these colors to use named colors so that it can be compatible with dark mode
    
    var surfaceTextSecondary: UIColor = UIColor(rgb: 0x2A3362)
    var surfaceTextPrimarySubdued: UIColor = UIColor(rgb: 0xF0EDEA)
    var surfaceTextPrimary: UIColor =  UIColor(rgb: 0x000000)
    var surfaceBackgroundPrimary: UIColor = .white
    var primaryColor: UIColor = UIColor(rgb: 0xFF9B00)
    var secondaryColor: UIColor = .black
    var black: UIColor = .black
    var decorativeDark: UIColor = UIColor(rgb: 0x2A3362)
    
    var surfaceTextPrimaryBright: UIColor = UIColor(rgb: 0xFFFFFF)
    var surfaceTextPrimaryBrightSubdued: UIColor = UIColor(rgb: 0x828282)
    var surfaceBackgroundSubdued: UIColor = UIColor(rgb: 0xD9D9D9)
    var grey60: UIColor = UIColor(rgb: 0x4F4F4F)
    var grey40: UIColor = UIColor(rgb: 0x828282)
    var sendPrimary: UIColor = UIColor(rgb: 0x5E3030)
    var sendSecondary: UIColor = UIColor(rgb: 0x6931A1)
}

private class DefaultSendSDKColor: CSColor {
    //TODO: change these colors to use named colors so that it can be compatible with dark mode
    
    var surfaceTextSecondary: UIColor = .white
    var surfaceTextPrimarySubdued: UIColor = UIColor(rgb: 0xF0EDEA)
    var surfaceTextPrimary: UIColor =  UIColor(rgb: 0x5E3030)
    var surfaceBackgroundPrimary: UIColor = UIColor(rgb: 0xFFF9F2)
    var primaryColor: UIColor = UIColor(rgb: 0x6931A1)
    var secondaryColor: UIColor = .black
    var black: UIColor = .black
    var decorativeDark: UIColor = UIColor(rgb: 0x2A3362)
    
    var surfaceTextPrimaryBright: UIColor = UIColor(rgb: 0xFFFFFF)
    var surfaceTextPrimaryBrightSubdued: UIColor = UIColor(rgb: 0x828282)
    var surfaceBackgroundSubdued: UIColor = UIColor(rgb: 0xD9D9D9)
    var grey60: UIColor = UIColor(rgb: 0x4F4F4F)
    var grey40: UIColor = UIColor(rgb: 0x828282)
    var sendPrimary: UIColor = UIColor(rgb: 0x5E3030)
    var sendSecondary: UIColor = UIColor(rgb: 0x6931A1)
}

private class DefaultSDKSpace: CSSpace {
    var none: CGFloat = 0
    var half: CGFloat = 8
    var one: CGFloat = 16
    var oneAndHalf: CGFloat = 24
    var two: CGFloat = 32
}

open class DefaultSDKTheme: CSTheme {
    public init() {}
   open var color: CSColor = DefaultSDKColor()
   open var space: CSSpace = DefaultSDKSpace()
}

open class DefaultSendSDKTheme: CSTheme {
    public init() {}
   open var color: CSColor = DefaultSendSDKColor()
   open var space: CSSpace = DefaultSDKSpace()
}

open class DefaultSDKConfiguration: CSConfiguration {
    public init(theme: CSTheme? = DefaultSDKTheme(), platformType: PlatformType) {
        self.theme = theme ?? DefaultSDKTheme()
        self.platformType = platformType
    }
  public var theme: CSTheme = DefaultSDKTheme()
    open var platformType: PlatformType = .send
}


public class ComplianceSDK {
    private(set) var configuration: CSConfiguration = DefaultSDKConfiguration( platformType: .f4b)
    private let mainCoordinator: MainCoordinator

    public func setConfiguration(config: CSConfiguration) {
        self.configuration = config
        switch config.platformType {
        case .send:
            self.configuration.theme = DefaultSendSDKTheme()
        case .f4b:
            self.configuration.theme = DefaultSDKTheme()
        }
        
    }
    
    public func start(presentingViewController: UIViewController) {
            mainCoordinator.start(presentingViewController: presentingViewController, config: configuration)
        }
    
    public static let shared = ComplianceSDK()
    
    init(){
        mainCoordinator = MainCoordinator()
    }
    
    public static func registerFonts() {
        ComplianceSDKFont.allCases.forEach {
            let fontExtension: String
            if $0 == .malik || $0.rawValue.contains("Garnett") {
                fontExtension = "otf"
            } else {
                fontExtension = "ttf"
            }
            registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: fontExtension)
//            registerFont(bundle: Bundle(for: ComplianceSDK.self), fontName: $0.rawValue, fontExtension: fontExtension)
        }
    }


    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
            let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
            let font = CGFont(fontDataProvider) else {
                fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
        }
        
        var error: Unmanaged<CFError>?

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}

