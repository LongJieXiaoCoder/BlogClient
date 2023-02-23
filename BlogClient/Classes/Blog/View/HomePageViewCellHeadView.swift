//
//  HomePageViewCellHeadView.swift
//  BlogClient
//
//  Created by Long on 2020/5/20.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

@objc protocol HomePageViewCellHeadViewDelegate: NSObjectProtocol {
    @objc func avatarAction()
}

class HomePageViewCellHeadView: UIBaseView {
    static let kHeadViewHeight: CGFloat = 40
    
    weak var delegate: HomePageViewCellHeadViewDelegate?
    var avatarView: UIImageView!
    var blogNameLabel: UILabel!
    var postTimeLabel: UILabel!
    var leftIconView: UIImageView!
    var nameAndTimeView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHeadView(avatarUrl: String, blogName: String, postTime: String) {
        avatarView.kf.setImage(with:URL(string: avatarUrl), placeholder: R.image.accountAvatar())
        blogNameLabel.text = blogName
        postTimeLabel.text = postTime
    }
    
    @objc func avatarAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.avatarAction)) {
            delegate?.avatarAction()
        }
    }
}

extension HomePageViewCellHeadView: InitViewProtocol {
    func initView() {
        avatarView = UIImageView.lc.initImageView(frame: CGRect.zero, image: R.image.accountBlog())  // modify by longchi
        avatarView.lc.addTapGesture(target: self, action: #selector(avatarAction))
        avatarView.lc.addCorner(Self.kHeadViewHeight/2)
        self.addSubview(avatarView)
        
        nameAndTimeView = UIView()
        self.addSubview(nameAndTimeView)
        
        blogNameLabel = UILabel.lc.initLable(frame: CGRect.zero, textColor: R.color.black_444444(), font: R.font.stHeitiSCMedium(size: 16))
        postTimeLabel = UILabel.lc.initLable(frame: CGRect.zero, textColor: R.color.black_444444(), font: R.font.hkGroteskRegular(size: 12))
        nameAndTimeView.addSubview(blogNameLabel)
        nameAndTimeView.addSubview(postTimeLabel)
        
        leftIconView = UIImageView.lc.initImageView(frame: CGRect.zero, image: R.image.more())  // modify by longchi
        self.addSubview(leftIconView)
    }
    
    func autoLayoutView() {
        avatarView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self)?.offset()(0)
            make?.leading.mas_equalTo()(self)?.offset()(15)
            make?.centerY.mas_equalTo()(self)?.offset()(0)
            make?.size.mas_equalTo()(CGSize(width: Self.kHeadViewHeight, height: Self.kHeadViewHeight))
            make?.bottom.mas_equalTo()(self)?.offset()(0)
        }
        leftIconView.mas_makeConstraints { (make) in
            make?.trailing.mas_equalTo()(self)?.offset()(-15)
            make?.centerY.mas_equalTo()(self.mas_centerY)
            make?.size.mas_equalTo()(CGSize(width: 25, height: 25))
        }
        nameAndTimeView.mas_makeConstraints { (make) in
            make?.leading.mas_equalTo()(avatarView.mas_trailing)?.offset()(10)
            make?.centerY.mas_equalTo()(self)?.offset()(0)
            make?.trailing.mas_equalTo()(leftIconView.mas_leading)?.offset()(0)
        }
        blogNameLabel.mas_makeConstraints { (make) in
            make?.leading.mas_equalTo()(nameAndTimeView)?.offset()(0)
            make?.top.mas_equalTo()(nameAndTimeView)?.offset()(0)
        }
        postTimeLabel.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(blogNameLabel.mas_bottom)?.offset()(5)
            make?.leading.bottom()?.mas_equalTo()(nameAndTimeView)?.offset()(0)
        }
    }
}
