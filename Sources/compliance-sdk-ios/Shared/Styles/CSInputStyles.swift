//
//  CSInputStyles.swift
//
//  Created by Mayowa Olunuga on 03/12/2023.
//

import UIKit

final class CSInputStyles {
    private static let theme = ComplianceSDK.shared.configuration.theme
    
    static var primary: InputStyle {
        InputStyle(
            labelStyle: CSTextStyles.bodyTwoRegular,
            labelSpacing: theme.space.one,
            textStyle: CSTextStyles.bodyTwoRegular.with(color: theme.color.surfaceTextPrimary),
            textStylePlaceholder: CSTextStyles.bodyTwoRegular.with(color: theme.color.surfaceTextPrimary),
            textColorPlaceholder: theme.color.surfaceTextPrimary,
            borderStyle: CSBorderStyles.subduedRegular,
            borderStyleActive: CSBorderStyles.primaryRegular,
            borderRadius: 3,
            verticalContentInset: theme.space.one,
            horizontalContentInset: theme.space.half)
     }
    
}
