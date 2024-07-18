//
//  CSBorderStyle.swift
//  ComplianceSDK
//
//  Created by Mayowa Olunuga on 27/11/2022.
//

import UIKit

public struct CSBorderStyle: Hashable {
    let width: CGFloat
    let color: UIColor?
    
    init(width: CGFloat, color: UIColor?){
        self.width = width
        self.color = color
    }
}
