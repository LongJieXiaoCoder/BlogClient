//
//  UIView+HUD.swift
//  BlogClient
//
//  Created by Long on 2020/5/13.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

extension UIView {
    func showHUD() {
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .indeterminate
        hud.bezelView.blurEffectStyle = .regular
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}




