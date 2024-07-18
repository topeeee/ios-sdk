//
//  CSButtonStyles.swift
//  ComplianceSDK
//
//  Created by Mayowa Olunuga on 11/08/2022.
//

import UIKit


final class CSButtonStyles {
    private static let theme = ComplianceSDK.shared.configuration.theme
    
   static var primary: ButtonStyle {
        ButtonStyle(
            borderRadius: 5,
            textStyle: CSTextStyles.buttonMedium,
            color: theme.color.primaryColor
        )
    }
    
    static var primarySend: ButtonStyle {
         ButtonStyle(
             borderRadius: 30,
             textStyle: CSTextStyles.buttonMedium,
             color: theme.color.primaryColor,
             height: 60
         )
     }
    
    static var blackBorderedSend: ButtonStyle {
         ButtonStyle(
             borderRadius: 30,
             textStyle: CSTextStyles.buttonMediumSend,
             borderStyle: CSBorderStyles.primaryRegularSend,
             color: .clear,
             height: 60
         )
     }
    
    
    static var primaryClear: ButtonStyle {
         ButtonStyle(
             borderRadius: 5,
             textStyle: CSTextStyles.buttonMedium,
             color: .clear
         )
     }
    
    static var blackBordered: ButtonStyle {
         ButtonStyle(
             borderRadius: 5,
             textStyle: CSTextStyles.buttonMedium,
             borderStyle: CSBorderStyles.primaryRegular,
             color: .clear
         )
     }
    
   static var primaryInverted: ButtonStyle {
        ButtonStyle(
            borderRadius: 5,
            textStyle: CSTextStyles.buttonMedium.with(color: .yellow),
            color: .clear
        )
    }
    
    static var blackInverted: ButtonStyle {
         ButtonStyle(
             borderRadius: 5,
             textStyle: CSTextStyles.buttonMedium.with(color: .black),
             color: .clear
         )
     }
    
    static var blackInvertedSend: ButtonStyle {
         ButtonStyle(
             borderRadius: 5,
             textStyle:  CSTextStyles.buttonMediumSend16,
             color: .clear
         )
     }
    
    static var largBlackInverted: ButtonStyle {
         ButtonStyle(
             borderRadius: 5,
             textStyle: CSTextStyles.buttonLarge.with(color: .black),
             color: .clear
         )
     }
}
