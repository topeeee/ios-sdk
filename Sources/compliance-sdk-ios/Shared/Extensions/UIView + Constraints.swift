//
//  UIView + Constraints.swift
//  ComplianceSDK
//
//  Created by Mayowa Olunuga on 11/08/2022.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    
    func anchorScrollContentLayoutGuide(scrollView : UIScrollView)-> UILayoutGuide {
        let cg = scrollView.contentLayoutGuide
        cg.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cg.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        return cg
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func fillSuperview(size: CGSize?, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
        
        if size?.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size!.width).isActive = true
        }
        
        if size?.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size!.height).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize?) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        
        if let sizePassed = size {
            widthAnchor.constraint(equalToConstant: sizePassed.width).isActive = true
            heightAnchor.constraint(equalToConstant: sizePassed.height).isActive = true
        }
    }
    
    func centerVerticallyInSuperview(padding : CGFloat?) {
        var pad  : CGFloat = 0
        if let passedPadding = padding {
            pad = passedPadding
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor , constant: pad).isActive = true
        }
        
        if let superviewTraillingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTraillingAnchor, constant: -pad ).isActive = true
        }
    }
    
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func dropShadow(color: CGColor = UIColor(red: 0.592, green: 0.561, blue: 0.686, alpha: 0.08).cgColor , radius : CGFloat = 15, x : CGFloat = 0, y : CGFloat = 10){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: x, height: y)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func removeDropShadow(){
        self.layer.shadowColor = nil
        self.layer.shadowOpacity = 0
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    func clickable(){
//        let rippleViewController = MDCRippleTouchController()
//        rippleViewController.addRipple(to: self)
    }
    
    
    func addDashedBorder() {
        let color = UIColor.yellow
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
    
    func addBottomRoundedEdge(desiredCurve: CGFloat?) {
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        
        self.layer.mask = maskLayer
    }
    
    func addBottomRoundedEdgeWithShadow(desiredCurve: CGFloat?) {
        let offset: CGFloat = self.frame.width / desiredCurve!
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        // Create the shape layer and set its path
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        maskLayer.fillColor = UIColor(red: 1, green: 0.917, blue: 0.808, alpha: 1).cgColor
        
        
        let shadowLayer: CAShapeLayer = CAShapeLayer()
        shadowLayer.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        shadowLayer.shadowColor = UIColor(red: 0.737, green: 0.678, blue: 0.6, alpha: 0.15).cgColor
        shadowLayer.frame = bounds
        shadowLayer.shadowPath = rectPath.cgPath
        
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 13
        
        self.layer.insertSublayer(shadowLayer, at: 0)
        
        // Set the newly created shape layer as the mask for the view's layer
        //self.layer.mask = maskLayer
        //self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(maskLayer, at: 1)
    }
    
    func addSubviews(_ views:UIView...){
        views.forEach { self.addSubview($0) }
    }
    
    @discardableResult
    func centerY(inView view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return self
    }
    
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerX = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
    }
    @discardableResult
    func centerX(inView view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        return self
    }
}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
