//
//  InputStyle.swift
//  ComplianceSDK
//
//  Created by Mayowa Olunuga on 15/11/2023.
//

import UIKit

struct InputStyle: Hashable {
    
    static func == (lhs: InputStyle, rhs: InputStyle) -> Bool {
        lhs.verticalContentInset == rhs.verticalContentInset
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(verticalContentInset)
    }

    // MARK: Lifecycle

    init(
        labelStyle: TextStyle,
        labelSpacing: CGFloat,
        textStyle: TextStyle,
        textStylePlaceholder: TextStyle,
        textColorPlaceholder: UIColor,
        borderStyle: CSBorderStyle,
        borderStyleActive: CSBorderStyle,
        borderRadius: CGFloat,
        verticalContentInset: CGFloat,
        horizontalContentInset: CGFloat)
    {
        self.labelStyle = labelStyle
        self.labelSpacing = labelSpacing
        self.textStyle = textStyle
        self.textStylePlaceholder = textStylePlaceholder
        self.textColorPlaceholder = textColorPlaceholder
        self.borderStyle = borderStyle
        self.borderStyleActive = borderStyleActive
        self.borderRadius = borderRadius
        self.verticalContentInset = verticalContentInset
        self.horizontalContentInset = horizontalContentInset
    }

    // MARK: Fileprivate

    public let labelStyle: TextStyle
    public let labelSpacing: CGFloat
    
    public let textStyle: TextStyle
    public let textStylePlaceholder: TextStyle
    public let textColorPlaceholder: UIColor

    public let borderStyle: CSBorderStyle
    public let borderStyleActive: CSBorderStyle
    public let borderRadius: CGFloat

    public let verticalContentInset: CGFloat
    public let horizontalContentInset: CGFloat

}
