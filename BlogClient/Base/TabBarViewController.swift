//
//  TabBarViewController.swift
//  BlogClient
//
//  Created by Long on 2020/4/24.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(R.string.localizable.blog(preferredLanguages: kAppLanguage), R.image.tabBarItem_blog(), R.image.tabBarItem_blog_selected(), HomeViewController.self)
        addChild(R.string.localizable.news(preferredLanguages: kAppLanguage), R.image.tabBarItem_news(), R.image.tabBarItem_news_selected(), NewsViewController.self)
        addChild(R.string.localizable.flash(preferredLanguages: kAppLanguage), R.image.tabBarItem_flash(), R.image.tabBarItem_flash_selected(), FlashViewController.self)
        addChild(R.string.localizable.library(preferredLanguages: kAppLanguage), R.image.tabBarItem_liberary(), R.image.tabBarItem_liberary_selected(), LibraryViewController.self)
        addChild(R.string.localizable.me(preferredLanguages: kAppLanguage), R.image.tabBarItem_me(), R.image.tabBarItem_me_selected(), MeViewController.self)
        
        // 处理iOS 13 背景和字体问题
        self.setTabBarFontAndBackgroundColor()
    }
    
    func addChild(_ title: String, _ image: UIImage?, _ selectedImage: UIImage?, _ type: UIViewController.Type) {
        let child = NavigationViewController(rootViewController: type.init())
        child.title = title
        child.tabBarItem.image = image
        child.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        child.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: R.color.red_F15A43() ?? UIColor.red], for: .selected)
        self.addChild(child);
    }
    
    func setTabBarFontAndBackgroundColor() {
        if #available(iOS 15.0, *) {
            let appearance: UITabBarAppearance =  UITabBarAppearance.init()
            appearance.backgroundColor = R.color.white_FFFFFF()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: R.font.hkGroteskRegular(size: 12) ?? UIFont.init(), NSAttributedString.Key.foregroundColor: R.color.black_444444() ?? UIColor.black]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: R.font.hkGroteskRegular(size: 12) ?? UIFont.init(), NSAttributedString.Key.foregroundColor: R.color.red_F15A43() ?? UIColor.red]
            self.tabBar.scrollEdgeAppearance = appearance
        } else {
            // 设置文字颜色
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: R.font.hkGroteskRegular(size: 12) ?? UIFont.init(), NSAttributedString.Key.foregroundColor: R.color.black_444444() ?? UIColor.black], for: .normal)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: R.font.hkGroteskRegular(size: 12) ?? UIFont.init(), NSAttributedString.Key.foregroundColor: R.color.red_F15A43() ?? UIColor.red], for: .selected)
        }
    }
}
