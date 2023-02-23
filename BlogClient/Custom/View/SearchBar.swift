//
//  SearchBar.swift
//  BlogClient
//
//  Created by Long on 2023/2/17.
//  Copyright © 2023 LongMac. All rights reserved.
//

import UIKit
import SnapKit

class SearchBar: UIView {
    lazy var searchIcon: UIImageView = {
        searchIcon = UIImageView.init()
        searchIcon.image = R.image.search()
        return searchIcon
    }()
    
    lazy var searchInputView: UITextField = {
        searchInputView = UITextField.init()
        searchInputView.font = R.font.hkGroteskRegular(size: 12)
        searchInputView.textColor = R.color.black_444444()
//        searchInputView.delegate = self
        searchInputView.placeholder = "请输入关键词"
        return searchInputView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.gray_F1F3F2()
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBar: InitViewProtocol {
    func initView() {
        self.addSubview(searchIcon)
        self.addSubview(searchInputView)
    }
    
    func autoLayoutView() {
        searchIcon.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(10)
            make.centerY.equalTo(self).offset(0)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        searchInputView.snp.makeConstraints { make in
            make.leading.equalTo(searchIcon.snp.trailing).offset(5)
            make.top.bottom.equalTo(self).offset(0)
            make.trailing.equalTo(self).offset(-16)
        }
    }
}


//extension SearchBar: UITextFieldDelegate {
//
//}
