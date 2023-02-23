//
//  MeTableFooterView.swift
//  BlogClient
//
//  Created by LongMac on 2020/5/16.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

@objc protocol MeTableFooterViewDelegate: NSObjectProtocol {
    @objc func logout()
}

class MeTableFooterView: UIBaseView, InitViewProtocol {
    weak var delegate: MeTableFooterViewDelegate?
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        logoutButton = UIButton.lc.initButton(frame: CGRect.zero, title: R.string.localizable.logout(preferredLanguages: kAppLanguage), font: R.font.stHeitiSCMedium(size: 14), titleColor: R.color.red_F15A43())
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        logoutButton.lc.addBorderAndCorner(borderWidth: 0.5, borderColor: R.color.black_000000_14(), radius: 25)
        self.addSubview(logoutButton)
    }
    
    func autoLayoutView() {
        logoutButton.mas_makeConstraints { (make) in
            make?.bottom.mas_equalTo()(self)?.offset()(0)
            make?.top.mas_equalTo()(self)?.offset()(30)
            make?.leading.mas_equalTo()(self)?.offset()(15)
            make?.trailing.mas_equalTo()(self)?.offset()(-15)
        }
    }
    
    @objc func logoutAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.logout)) {
            delegate?.logout()
        }
    }
}
