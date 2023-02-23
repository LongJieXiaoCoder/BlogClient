//
//  UIViewExtension.swift
//  BlogClient
//
//  Created by LongMac on 2020/4/28.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

extension UIView: LCCompatible {}
extension LC where Base: UIView {
    // MARK: - Frame
    var width: CGFloat {
        base.frame.size.width
    }
    var height: CGFloat {
        base.frame.size.height
    }
    var x: CGFloat {
        base.frame.origin.x
    }
    var y: CGFloat {
        base.frame.origin.y
    }
    var centerX: CGFloat {
        self.x + self.width/2
    }
    var centerY: CGFloat {
        self.y + self.height/2
    }
    var center: CGPoint {
        CGPoint(x: self.x/2, y: self.y/2)
    }
    var right: CGFloat {
        self.x + self.width
    }
    var left: CGFloat {
        self.x
    }
    
    // MARK: - Corner
    
    // 添加圆角
    func addCorner(_ radius: CGFloat) {
        base.layer.masksToBounds = true
        base.layer.cornerRadius = radius
    }
    
    // 添加边框和圆角
    func addBorderAndCorner(borderWidth: CGFloat, borderColor: UIColor?, radius: CGFloat) {
        base.layer.borderWidth = borderWidth
        base.layer.borderColor = borderColor?.cgColor
        addCorner(radius)
    }
    
    // 添加阴影
    func addShadow(shadowColor: UIColor?, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat, viewCornerRadius: CGFloat) {
        base.layer.shadowColor = shadowColor?.cgColor
        base.layer.shadowOffset = shadowOffset
        base.layer.shadowOpacity = shadowOpacity
        base.layer.shadowRadius = shadowRadius
        base.layer.cornerRadius = viewCornerRadius
    }
    
    // MARK: - Gesture
    func addTapGesture(target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer.init(target: target, action: action)
        tapGesture.cancelsTouchesInView = true
        base.isUserInteractionEnabled = true
        base.addGestureRecognizer(tapGesture)
    }
    
    
}
