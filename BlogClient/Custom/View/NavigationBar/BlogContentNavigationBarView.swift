//
//  BlogContentNavigationBarView.swift
//  BlogClient
//
//  Created by Long on 2023/2/24.
//  Copyright © 2023 LongMac. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol BlogContentNavigationBarViewDelegate: NSObjectProtocol {
    @objc func backAction()
    @objc func shareAction()
}

class BlogContentNavigationBarView: UIBaseView {
    weak var delegate: BlogContentNavigationBarViewDelegate?
    
    lazy var backImageView: UIImageView = {
        backImageView = UIImageView.lc.initImageView(frame: CGRect.zero, image: R.image.nav_back_icon())
        backImageView.lc.addTapGesture(target: self, action: #selector(backAction))
        return backImageView
    }()
    
    lazy var searchBar: SearchBar = {
        searchBar = SearchBar.init(frame: CGRect.zero)
        searchBar.lc.addCorner(17)
        searchBar.isHidden = true
        return searchBar
    }()
    
    lazy var shareImageView: UIImageView = {
        shareImageView = UIImageView.lc.initImageView(frame: CGRect.zero, image: R.image.nav_share_icon())
        shareImageView.lc.addTapGesture(target: self, action: #selector(shareAction))
        return shareImageView
    }()
    
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
extension BlogContentNavigationBarView {

}

// MARK: - InitViewProtocol
extension BlogContentNavigationBarView: InitViewProtocol {
    func initView() {
        self.addSubview(backImageView)
        self.addSubview(searchBar)
        self.addSubview(shareImageView)
    }
    
    func autoLayoutView() {
        backImageView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(12)
            make.centerY.equalTo(self.snp.centerY).offset(0)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalTo(self.backImageView.snp.trailing).offset(8)
            make.trailing.equalTo(self).offset(-16)
            make.centerY.equalTo(self).offset(0)
            make.height.equalTo(34);
        }
        
        shareImageView.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-16)
            make.centerY.equalTo(self).offset(0)
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
    }
}

// MARK: - Action
extension BlogContentNavigationBarView {
    @objc func backAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.backAction)) {
            delegate?.backAction()
        }
    }
    
    @objc func shareAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.shareAction)) {
            delegate?.shareAction()
        }
    }
    
}
