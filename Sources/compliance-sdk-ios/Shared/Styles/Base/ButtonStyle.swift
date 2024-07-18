//
//  ButtonStyle.swift
//
//  Created by Mayowa Olunuga on 03/12/2023.
//

import UIKit

public struct ButtonStyle {
    public let borderRadius: CGFloat?
    public let textStyle: TextStyle
    public let borderStyle: CSBorderStyle?
    public let color: UIColor
    public let height: CGFloat?
    
    public init(
        borderRadius: CGFloat?,
        textStyle: TextStyle,
        borderStyle: CSBorderStyle? = nil,
        color: UIColor,
        height: CGFloat? = 50)
    {
        self.borderRadius = borderRadius
        self.textStyle = textStyle
        self.color = color
        self.height = height
        self.borderStyle = borderStyle
    }
    
    func with(height: CGFloat) -> ButtonStyle {
        return ButtonStyle(
            borderRadius: borderRadius,
            textStyle: textStyle,
            borderStyle: borderStyle,
            color: color,
            height: height)
    }
}
