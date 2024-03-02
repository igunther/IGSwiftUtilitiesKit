//
//  File.swift
//  
//
//  Created by Øystein Günther on 02/03/2024.
//

import UIKit

extension UIView {
    
    // MARK: - Constraints
    
    public func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        priority: UILayoutPriority = UILayoutPriority.required,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        top.map({ constraints.append(topAnchor.constraint(equalTo: $0, constant: paddingTop)) })
        left.map({ constraints.append(leftAnchor.constraint(equalTo: $0, constant: paddingLeft)) })
        bottom.map({ constraints.append(bottomAnchor.constraint(equalTo: $0, constant: -paddingBottom)) })
        right.map({ constraints.append(rightAnchor.constraint(equalTo: $0, constant: -paddingRight)) })
        centerX.map({ constraints.append(centerXAnchor.constraint(equalTo: $0)) })
        centerY.map({ constraints.append(centerYAnchor.constraint(equalTo: $0)) })
        width.map({ constraints.append(widthAnchor.constraint(equalToConstant: $0)) })
        height.map({ constraints.append(heightAnchor.constraint(equalToConstant: $0)) })
        
        constraints.forEach({ $0.priority = priority })
        NSLayoutConstraint.activate(constraints)
    }
    
    public var safeTopAnchor: NSLayoutYAxisAnchor { safeAreaLayoutGuide.topAnchor }
    public var safeLeftAnchor: NSLayoutXAxisAnchor { safeAreaLayoutGuide.leftAnchor }
    public var safeRightAnchor: NSLayoutXAxisAnchor { safeAreaLayoutGuide.rightAnchor }
    public var safeBottomAnchor: NSLayoutYAxisAnchor { safeAreaLayoutGuide.bottomAnchor }
        
    // MARK: - Borders
    
    public enum ViewSide {
        case top, left, bottom, right, all, none
    }
    
    public func addBorder(viewSides: [ViewSide], color: UIColor?, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        border.translatesAutoresizingMaskIntoConstraints = false
        
        if viewSides.contains(.top) {
            addTopBorder(color: color, thickness: thickness)
        }
        
        if viewSides.contains(.left) {
            addLeftBorder(color: color, thickness: thickness)
        }
        
        if viewSides.contains(.bottom) {
            addBottomBorder(color: color, thickness: thickness)
        }
        
        if viewSides.contains(.right) {
            addRightBorder(color: color, thickness: thickness)
        }
        
        if viewSides.contains(.all) {
            addTopBorder(color: color, thickness: thickness)
            addLeftBorder(color: color, thickness: thickness)
            addBottomBorder(color: color, thickness: thickness)
            addRightBorder(color: color, thickness: thickness)
        }
        
        addSubview(border)
    }
    
    public func addTopBorder(color: UIColor?, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: thickness)
        addSubview(border)
    }
    
    public func addBottomBorder(color: UIColor?, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - thickness, width: frame.size.width, height: thickness)
        addSubview(border)
    }
    
    public func addLeftBorder(color: UIColor?, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.size.height)
        addSubview(border)
    }
    
    public func addRightBorder(color: UIColor?, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - thickness, y: 0, width: thickness, height: frame.size.height)
        addSubview(border)
    }
    
    // MARK: - Animations
    
    public func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    public func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 1 },
                       completion: { (value: Bool) in
                        if let complete = onCompletion { complete() }
        }
        )
    }
    
    public func fadeOut(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 0 },
                       completion: { (value: Bool) in
                        self.isHidden = true
                        if let complete = onCompletion { complete() }
        }
        )
    }
}
