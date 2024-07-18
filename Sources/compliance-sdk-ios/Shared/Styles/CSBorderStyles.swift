//
//  File.swift
//  
//
//  Created by Mayowa Olunuga on 03/12/2023.
//

import UIKit

final class CSBorderStyles {
    private static let theme = ComplianceSDK.shared.configuration.theme
    
    static var primaryBold: CSBorderStyle {
        CSBorderStyle(width: 2, color: theme.color.decorativeDark)
    }

    static var primaryRegular: CSBorderStyle {
        CSBorderStyle(width: 1, color: theme.color.decorativeDark)
    }
    
    static var primaryRegularSend: CSBorderStyle {
        CSBorderStyle(width: 1.5, color: UIColor(rgb: 0x6931A1))
    }
    
    static var subduedRegular: CSBorderStyle {
        CSBorderStyle(width: 1, color: theme.color.surfaceTextPrimarySubdued)
    }
}
