//
//  CSTextStyles.swift
//  ComplianceSDK
//
//  Created by Mayowa Olunuga on 16/11/2022.
//

import Foundation

final class CSTextStyles {
    private static let theme = ComplianceSDK.shared.configuration.theme
    
    static var titleTwo: TextStyle {
         TextStyle(
             name: "titleTwo",
             fontSize: 24,
             fontweight: 400,
             fontFamily: .malik,
             lineHeight: 3,
             ios: .init(textStyle: PlatformStyle.UICTFontTextStyleTitle3.rawValue)
         )
     }
    
    static var titleTwo18: TextStyle {
         TextStyle(
             name: "titleTwo18",
             fontSize: 18,
             fontweight: 400,
             fontFamily: .malik,
             lineHeight: 3,
             ios: .init(textStyle: PlatformStyle.UICTFontTextStyleTitle3.rawValue)
         )
     }
    
   static var titleThree: TextStyle {
        TextStyle(
            name: "titleThree",
            fontSize: 20,
            fontweight: 600,
            fontFamily: .moderatRegular,
            lineHeight: 2,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleTitle3.rawValue)
        )
    }
    
    static var bodyOneMedium: TextStyle {
        TextStyle(
            name: "bodyOneMedium",
            fontSize: 16,
            fontweight: 500,
            fontFamily: .moderatMedium,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    
    static var bodyOneRegular: TextStyle {
        TextStyle(
            name: "bodyOneRegular",
            fontSize: 16,
            fontweight: 500,
            fontFamily: .moderatRegular,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    static var bodyOneBold: TextStyle {
        TextStyle(
            name: "bodyOneBold",
            fontSize: 16,
            fontweight: 500,
            fontFamily: .moderateBold,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    static var bodyTwoRegular: TextStyle {
        TextStyle(
            name: "bodyTwoRegular",
            fontSize: 18,
            fontweight: 500,
            fontFamily: .moderatRegular,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    static var bodyTwoRegular18: TextStyle {
        TextStyle(
            name: "bodyTwoRegular",
            fontSize: 18,
            fontweight: 500,
            fontFamily: .moderatMedium,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    
    static var bodyTwoMedium: TextStyle {
        TextStyle(
            name: "bodyTwoMedium",
            fontSize: 14,
            fontweight: 500,
            fontFamily: .moderatMedium,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    static var bodyTwoMedium16: TextStyle {
        TextStyle(
            name: "bodyTwoMedium16",
            fontSize: 16,
            fontweight: 500,
            fontFamily: .garnettMedium,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    static var bodyTwoBold: TextStyle {
        TextStyle(
            name: "bodyTwoBold",
            fontSize: 14,
            fontweight: 700,
            fontFamily: .moderateBold,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    
   static var buttonBold: TextStyle {
        TextStyle(
            name: "button",
            fontSize: 14,
            fontweight: 600,
            fontFamily: .moderateBold,
            lineHeight: 1.5,
            color: theme.color.surfaceTextSecondary,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    static var buttonMedium: TextStyle {
         TextStyle(
             name: "button",
             fontSize: 16,
             fontweight: 400,
             fontFamily: .moderatMedium,
             lineHeight: 1.5,
             color: theme.color.surfaceTextSecondary,
             ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
         )
     }
    
    static var buttonMediumSend: TextStyle {
         TextStyle(
             name: "button",
             fontSize: 14,
             fontweight: 400,
             fontFamily: .garnettMedium,
             lineHeight: 1.5,
             color: theme.color.sendSecondary,
             ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
         )
     }
    
    static var buttonMediumSend16: TextStyle {
         TextStyle(
             name: "button",
             fontSize: 16,
             fontweight: 400,
             fontFamily: .garnettMedium,
             lineHeight: 1.5,
             color: theme.color.sendSecondary,
             ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
         )
     }
    
    static var buttonMediumSend18: TextStyle {
         TextStyle(
             name: "button",
             fontSize: 18,
             fontweight: 500,
             fontFamily: .garnettMedium,
             lineHeight: 1.5,
             color: theme.color.sendPrimary,
             ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
         )
     }
    
    
    static var buttonLarge: TextStyle {
         TextStyle(
             name: "button",
             fontSize: 24,
             fontweight: 500,
             fontFamily: .moderatMedium,
             lineHeight: 1.5,
             color: theme.color.surfaceTextPrimary,
             ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
         )
     }
    
    
    static var headingOne: TextStyle {
         TextStyle(
             name: "headingOne",
             fontSize: 18,
             fontweight: 400,
             fontFamily: .malik,
             lineHeight: 3,
             ios: .init(textStyle: PlatformStyle.UICTFontTextStyleTitle3.rawValue)
         )
     }
    
    static var sendHeading1: TextStyle {
        TextStyle(
            name: "sendHeading1",
            fontSize: 24,
            fontweight: 400,
            fontFamily: .garnettRegular,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
    
    static var sendHeadingMedium1: TextStyle {
        TextStyle(
            name: "sendHeading1",
            fontSize: 24,
            fontweight: 500,
            fontFamily: .garnettMedium,
            lineHeight: 1.5,
            ios: .init(textStyle: PlatformStyle.UICTFontTextStyleSubhead.rawValue)
        )
    }
}
