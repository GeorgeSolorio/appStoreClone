//
//  UIView+Layout.swift
//  appStoreClone
//
//  Created by George Solorio on 7/6/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//

import UIKit

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        var anchoredContraints = AnchoredConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            anchoredContraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredContraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredContraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredContraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredContraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredContraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredContraints.top, anchoredContraints.leading, anchoredContraints.bottom, anchoredContraints.trailing, anchoredContraints.width, anchoredContraints.height].forEach { $0?.isActive = true }
        
        return anchoredContraints
    }
    
    func fillSuperView(padding: UIEdgeInsets = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superViewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superViewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superViewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superViewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superViewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superViewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superViewTrailing = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superViewTrailing, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperView(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
        
        if let superViewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superViewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func constraintWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constraintHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
