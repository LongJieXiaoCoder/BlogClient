//
//  UIWindow+Extension.swift
//  BlogClient
//
//  Created by Long on 2020/5/27.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

extension UIWindow {
    static func topViewController() -> UIViewController? {
        guard let windowOpt = (UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate)?.window else { return nil }
        guard let window = windowOpt else { return nil }
        
        var top = window.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
