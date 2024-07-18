//
//  TextStyle.swift
//  barter
//
//  Created by Mayowa Olunuga on 11/08/2022.
//

import UIKit

public enum PlatformStyle: String {
    case UICTFontTextStyleSubhead
    case UICTFontTextStyleTitle3
}

public struct TextStyle {
    
    public struct Platform {
        public init(textStyle: String) {
            self.textStyle = textStyle
        }
        
        public let textStyle: String
    }
    
    public let name: String

    public let fontSize: Float
    public let fontweight: Int
    public let fontFamily: ComplianceSDKFont?
    public let lineHeight: Float?
    public let letterSpacing: Float?
    public let color: UIColor?
    public let ios: Platform?
    
    public init(
        name: String,
        fontSize: Float,
        fontweight: Int,
        fontFamily: ComplianceSDKFont? = nil,
        lineHeight: Float? = nil,
        letterSpacing: Float? = nil,
        color: UIColor? = nil,
        ios: Platform?)
    {
        self.name = name
        self.fontSize = fontSize
        self.fontFamily = fontFamily
        self.fontweight = fontweight
        self.lineHeight = lineHeight
        self.letterSpacing = letterSpacing
        self.color = color
        self.ios = ios
    }
    
    public func with(color: UIColor) -> TextStyle {
        TextStyle(
            name: name,
            fontSize: fontSize,
            fontweight: fontweight,
            fontFamily: fontFamily,
            lineHeight: lineHeight,
            letterSpacing: letterSpacing,
            color: color,
            ios: ios)
    }
}

extension TextStyle {
    public func attributes(
        color: UIColor?,
        alignment: NSTextAlignment? = nil,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    )
    -> [NSAttributedString.Key: Any]
    {
 
        guard let fontFamily = fontFamily else {
            fatalError("""
                Failed to load the "CustomFont-Light" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        
        let customFont = UIFont.custom(fontFamily, size: CGFloat(fontSize))
        
        let scaledFont = self.scaledFont(for: customFont)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        
        if let lineHeight = lineHeight {
            paragraphStyle.lineSpacing = CGFloat(lineHeight)
        }
        
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }
        
        var attributes = [NSAttributedString.Key: Any]()
        attributes[.foregroundColor] = color
        attributes[.font] = scaledFont
        attributes[.kern] = letterSpacing
        attributes[.paragraphStyle] = paragraphStyle
        return attributes
    }
    
    private var adjustedFontWeight: Int {
        let adjustedWeight: Int
        if UIAccessibility.isBoldTextEnabled {
            adjustedWeight = min(fontweight + StyleConstant.boldTextAdjustment, StyleConstant.maximumFontWeight)
        }else{
            adjustedWeight = fontweight
        }
        return adjustedWeight
    }
    
    private var normalizedFontWeight: Float {
        return Float(adjustedFontWeight - StyleConstant.normalFontWeight) / Float(adjustedFontWeight)
    }
    
    private var dynamicTextStyle: UIFont.TextStyle? {
        guard let textStyle = ios?.textStyle else {
            return nil
        }
        return UIFont.TextStyle(rawValue: textStyle)
    }
    
    
    private func scaledFont(for font: UIFont) -> UIFont {
        var fontAttributes: [UIFontDescriptor.AttributeName: Any] = [
            .traits: [
                UIFontDescriptor.TraitKey.weight: UIFont.Weight(CGFloat(normalizedFontWeight))
            ]
        ]
        fontAttributes[.family] = fontFamily
        font.fontDescriptor.addingAttributes(fontAttributes)
        
        let scaledFont: UIFont
        if let textStyle = dynamicTextStyle {
            let metrics = UIFontMetrics(forTextStyle: textStyle)
            scaledFont = metrics.scaledFont(for: font)
        }else{
            scaledFont = font
        }
        
        return scaledFont
    }
}

private enum StyleConstant {
    static let boldFontWeight = 700
    static let normalFontWeight = 600
    
    static var boldTextAdjustment: Int = {
        boldFontWeight - normalFontWeight
    }()
    
    static let maximumFontWeight = 900
}
