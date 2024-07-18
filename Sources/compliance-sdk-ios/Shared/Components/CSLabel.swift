//
//  CSLabel.swift
//  ComplianceSDK
//
//  Created by Mayowa Olunuga on 20/11/2022.
//

import Foundation
import UIKit

public final class CSLabel: UILabel {
    public let style: TextStyle
   
    public init(text: String, style: TextStyle){
        self.style = style
        super.init(frame: .zero)
        self.text = text
        update()
    }
    
    private func update(){
        if let text = text {
            super.attributedText = NSAttributedString(
                string: text,
                attributes: style.attributes(color: textColor, alignment: textAlignment))
        }else{
            super.attributedText = nil
        }
    }
    
    public override var textAlignment: NSTextAlignment{
        didSet {
            update()
        }
    }
    
    public override var textColor: UIColor? {
        didSet{
            update()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
