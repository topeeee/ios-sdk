//
//  CSButton.swift
//  ComplianceSDK
//
//  Created by Mayowa Olunuga on 19/11/2022.
//

import UIKit

class CSButton: UIButton {
    private var style: ButtonStyle!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    convenience init(title: String, style: ButtonStyle){
        self.init(type: .system)
        self.style = style
        self.setTitle(title, for: .normal)
        update()
    }

    private func update(){
        self.translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: style.height ?? 50).isActive = true
        clipsToBounds = true
        
        if let text = self.title(for: .normal) {
            super.setAttributedTitle(NSAttributedString(
                string: text,
                attributes: style.textStyle.attributes(
                    color: style.textStyle.color,
                    alignment: .center)),for: .normal)
        }else {
            super.setAttributedTitle(nil, for: .normal)
        }
        
        self.backgroundColor = style.color
        self.layer.cornerRadius = style.borderRadius ?? 0
        self.layer.borderWidth = style.borderStyle?.width ?? 0
        self.layer.borderColor = style.borderStyle?.color?.cgColor ?? UIColor.clear.cgColor
    }
    
    public override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        setTitleColor(color, for: .normal)
        update()
    }
    
    override var isEnabled: Bool{
        didSet{
            if isEnabled{
                backgroundColor = style.color
            }else{
                backgroundColor = style.color.withAlphaComponent(0.5)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
