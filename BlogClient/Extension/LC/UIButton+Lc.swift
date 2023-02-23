//
//  UIButton+Lc.swift
//  BlogClient
//
//  Created by LongMac on 2020/5/16.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

extension LC where Base: UIButton {
    static func initButton(frame: CGRect, title: String, font: UIFont?, titleColor: UIColor?) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = frame
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        return button
    }
}
