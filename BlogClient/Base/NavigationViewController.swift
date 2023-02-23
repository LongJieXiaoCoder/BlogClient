//
//  NavigationViewController.swift
//  BlogClient
//
//  Created by Long on 2020/4/24.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self;
    }

    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    
        let isHiddenNavigation = self.hiddenNavigationController().contains { (vcType) -> Bool in
            if type(of: viewController) == vcType {
                return true
            } else {
                return false
            }
        }
        self.setNavigationBarHidden(isHiddenNavigation, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    // 需要隐藏导航栏的viewController
    func hiddenNavigationController() -> [UIViewController.Type] {
        return [MeViewController.self, WKWebViewController.self, HomeViewController.self, DisplayContentViewController.self]
    }
    
    
    // MARK: - Static Method
    static func pushViewController(_ viewControlller: UIViewController, animation: Bool) {
        if let topViewController = UIWindow.topViewController() {
            if let navigationVc = topViewController.navigationController {
                navigationVc.pushViewController(viewControlller, animated: animation)
            } else {
                topViewController.present(viewControlller, animated: animation, completion: nil)
            }
        }
    }
}
