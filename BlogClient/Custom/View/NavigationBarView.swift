//
//  NavigationBarView.swift
//  BlogClient
//
//  Created by Long on 2020/5/18.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol NavigationBarViewDelegate: NSObjectProtocol {
    @objc func logoAction()
    @objc func searchAction()
    
}

class NavigationBarView: UIBaseView {
    weak var delegate: NavigationBarViewDelegate?
    
    lazy var leftIcon: UIImageView = {
        leftIcon = UIImageView.lc.initImageView(frame: CGRect.zero, image: R.image.home_logo())
        leftIcon.lc.addTapGesture(target: self, action: #selector(selectLogo))
        return leftIcon
    }()
    
    
    lazy var searchBar: SearchBar = {
        searchBar = SearchBar.init(frame: CGRect.zero)
        searchBar.lc.addCorner(17)
        return searchBar
    }()
    
    

//    lazy var rightIcon: UIImageView = {
//        rightIcon = UIImageView.lc.initImageView(frame: CGRect.zero, image: R.image.search())
//        rightIcon.lc.addTapGesture(target: self, action: #selector(selectSearch))
//        return rightIcon
//    }()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Method
extension NavigationBarView {
    
    
//    func loadTabMenu(_ datas: [TabMenuItemProtocol]) {
//        tabMenuView.loadTabMenu(datas: datas, selectedIndex: 0)
//    }
}

// MARK: - InitViewProtocol
extension NavigationBarView: InitViewProtocol {
    func initView() {
        self.addSubview(leftIcon)
        self.addSubview(searchBar)
//        self.addSubview(rightIcon)
    }
    
    func autoLayoutView() {
        leftIcon.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(16)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.size.equalTo(CGSize(width: 85, height: 28))
        }
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(self.leftIcon.snp.trailing).offset(8)
            make.trailing.equalTo(self).offset(-16)
            make.centerY.equalTo(self).offset(0)
            make.height.equalTo(34);
        }
        
//        rightIcon.snp.makeConstraints { make in
//            make.trailing.equalTo(self).offset(-16)
//            make.centerY.equalTo(self).offset(0)
//            make.size.equalTo(CGSize(width: 20, height: 20))
//        }
    }
}

// MARK: - Action
extension NavigationBarView {
    @objc func selectLogo() {
        if let _ = delegate?.responds(to: #selector(delegate?.logoAction)) {
            delegate?.logoAction()
        }
    }
    
    @objc func selectSearch() {
        if let _ = delegate?.responds(to: #selector(delegate?.searchAction)) {
            delegate?.searchAction()
        }
    }
}
