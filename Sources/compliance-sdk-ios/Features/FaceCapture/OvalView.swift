//
//  OvalView.swift
//
//  Created by Mayowa Olunuga on 27/11/2023.
//

import UIKit

class OvalView: UIView {
    let borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutOvalMask()
    }

    private func layoutOvalMask() {
        let mask = self.shapeMaskLayer()
        let bounds = self.bounds
        
        let maskPath = CGPath(ellipseIn: bounds, transform: nil)
        mask.frame = bounds
        mask.path = maskPath
        
        borderLayer.path = maskPath
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    }

    private func shapeMaskLayer() -> CAShapeLayer {
        if let layer = self.layer.mask as? CAShapeLayer {
            return layer
        }
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.black.cgColor
        self.layer.mask = layer
        return layer
    }
    
    

}
