//
//  HomeViewController.swift
//  BlogClient
//
//  Created by Long on 2020/4/24.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIBaseViewController {
    lazy var navigationBarView: NavigationBarView = {
        navigationBarView = NavigationBarView(frame: CGRect.zero)
        navigationBarView.delegate = self
        return navigationBarView
    }()
    
    lazy var tabMenuView: TabMenuView = {
        tabMenuView = TabMenuView()
        tabMenuView.delegate = self
        return tabMenuView
    }()
    
    lazy var scrollPageView: ScrollPageView = {
        scrollPageView = ScrollPageView(frame: CGRect.zero)
        scrollPageView.delegate = self
        return scrollPageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = R.color.white_FFFFFF()
        self.setupUI()
        // 配置数据
        tabMenuView.setAssociateScrollView(scrollPageView.scrollView)
        tabMenuView.loadTabMenu(datas:tabMenu(), selectedIndex: 0)
        scrollPageView.loadPage(tabMenu())
    }
    
    func tabMenu() -> [TabMenuItem] {
        [TabMenuItem(R.string.localizable.home(preferredLanguages: kAppLanguage)), TabMenuItem(R.string.localizable.essence(preferredLanguages: kAppLanguage))]
    }
}

// MARK: - InitViewProtocol
extension HomeViewController: InitViewProtocol {
    func initView() {
        self.view.addSubview(navigationBarView)
        self.view.addSubview(tabMenuView)
        self.view.addSubview(scrollPageView)
    }
    
    func autoLayoutView() {
        navigationBarView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(kStatusBarHeight)
            make.leading.trailing.equalTo(self.view).offset(0)
            make.height.equalTo(44)
        }
        
        tabMenuView.snp.makeConstraints { make in
            make.top.equalTo(navigationBarView.snp.bottom).offset(0)
            make.leading.trailing.equalTo(self.view).offset(0)
            make.height.equalTo(44)
        }
        
        scrollPageView.snp.makeConstraints { make in
            make.top.equalTo(tabMenuView.snp.bottom).offset(0)
            make.leading.trailing.equalTo(self.view).offset(0)
            make.bottom.equalTo(self.view).offset(0)
        }
    }
}

// MARK: - NavigationBarViewDelegate
extension HomeViewController: NavigationBarViewDelegate {
    func logoAction() {
        // TODO: 处理点击logo
    }
    
    func searchAction() {
        // TODO: 处理点击search
    }
}


// MARK: - TabMenuViewDelegate
extension HomeViewController: TabMenuViewDelegate {
    func selectMenuTitleIndex(_ index: Int, itemModel: TabMenuItemProtocol?) {
        // TODO: 点击菜单回调
        print("select menu index \(index)")
    }
}


extension HomeViewController: UIScrollViewDelegate {
    
}

extension HomeViewController: ScrollPageViewDelegate {
    func pageScrollView(_ scrollView: ScrollPageView, pageViewForIndex index: Int) -> PageView {
        if index == 0 {
            return HomePageView(frame: CGRect.zero, type: .home)
        }
        return HomePageView(frame: CGRect.zero, type: .essence)
    }
    
    func pageScrollview(_ scrollView: ScrollPageView, loadDataForPageView pageView: PageView, index: Int) {
        if let homePageView = pageView as? HomePageView {
            homePageView.loadPageData()
        }
    }
}
