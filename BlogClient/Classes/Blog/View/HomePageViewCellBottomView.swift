//
//  HomePageViewCellBottomView.swift
//  BlogClient
//
//  Created by Long on 2020/5/20.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

@objc protocol HomePageViewCellBottomViewDelegate: NSObjectProtocol {
    @objc func faveAction()
    @objc func commentAction()
    @objc func lookAction()
}

class HomePageViewCellBottomView: UIBaseView {
    static let kBottomViewHeight: CGFloat = 20
    
    weak var delegate: HomePageViewCellBottomViewDelegate?
    var faveView: IconLabelView!  // 收藏
    var commentView: IconLabelView!   // 评论
    var lookView: IconLabelView!  // 浏览
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configBottomView(withFave faves: Int, comments: Int, views: Int) {
        faveView.configView(withIcon: R.image.fave(), text: "\(faves)")
        commentView.configView(withIcon: R.image.comment(), text: "\(comments)")
        lookView.configView(withIcon: R.image.views(), text: "\(views)")
    }
}

extension HomePageViewCellBottomView: InitViewProtocol {
    func initView() {
        faveView = IconLabelView(frame: CGRect.zero)
        faveView.lc.addTapGesture(target: self, action: #selector(faveAction))
        self.addSubview(faveView)
        
        commentView = IconLabelView(frame: CGRect.zero)
        commentView.lc.addTapGesture(target: self, action: #selector(commentAction))
        self.addSubview(commentView)
    
        lookView = IconLabelView(frame: CGRect.zero)
        lookView.lc.addTapGesture(target: self, action: #selector(lookAction))
        self.addSubview(lookView)
    }
    
    func autoLayoutView() {
        lookView.mas_makeConstraints { (make) in
            make?.leading.top().bottom().mas_equalTo()(self)?.offset()(0)
            make?.height.mas_equalTo()(Self.kBottomViewHeight)
        }
        
        commentView.mas_makeConstraints { (make) in
            make?.centerX.mas_equalTo()(self.mas_centerX)
            make?.centerY.mas_equalTo()(self.mas_centerY)?.offset()(0)
            make?.height.mas_equalTo()(Self.kBottomViewHeight)
        }
        
        faveView.mas_makeConstraints { (make) in
            make?.trailing.mas_equalTo()(self)?.offset()(0)
            make?.centerY.mas_equalTo()(self.mas_centerY)?.offset()(0)
            make?.height.mas_equalTo()(18)
        }
    }
}


extension HomePageViewCellBottomView {
    @objc func faveAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.faveAction)) {
            delegate?.faveAction()
        }
    }
    
    @objc func commentAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.commentAction)) {
            delegate?.commentAction()
        }
    }
    
    @objc func lookAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.lookAction)) {
            delegate?.lookAction()
        }
    }
}





