//
//  IconLabelView.swift
//  BlogClient
//
//  Created by Long on 2020/5/20.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

class IconLabelView: UIBaseView {
    var iconView: UIImageView!
    var textLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView(withIcon icon: UIImage?, text: String) {
        iconView.image = icon
        textLabel.text = text
    }
}

extension IconLabelView: InitViewProtocol {
    func initView() {
        iconView = UIImageView.lc.initImageView(frame: CGRect.zero, image: nil)
        self.addSubview(iconView)
        
        textLabel = UILabel.lc.initLable(frame: CGRect.zero, title: "", textColor: R.color.black_444444(), font: R.font.stHeitiSCMedium(size: 12), numberOfLines: 1)
        self.addSubview(textLabel)
    }
    
    func autoLayoutView() {
        iconView.mas_makeConstraints { (make) in
            make?.top.bottom()?.mas_equalTo()(self)?.offset()(0)
            make?.leading.mas_equalTo()(self)?.offset()(0)
            make?.width.mas_equalTo()(self.mas_height)
        }
        
        textLabel.mas_makeConstraints { (make) in
            make?.centerY.mas_equalTo()(self)?.offset()(0)
            make?.leading.mas_equalTo()(iconView.mas_trailing)?.offset()(5)
            make?.trailing.lessThanOrEqualTo()(self)?.offset()(-5)
        }
    }
}
