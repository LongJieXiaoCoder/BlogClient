//
//  HomePageViewCell.swift
//  BlogClient
//
//  Created by LongMac on 2020/5/19.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

@objc protocol HomePageViewCellDelegate: NSObjectProtocol {
    @objc func faveAction()
    @objc func commentAction()
    @objc func lookAction()
    @objc func avatarAction()
}

class HomePageViewCell: UITableViewCell {
    weak var delegate: HomePageViewCellDelegate?
    
    static let kHeadViewTopConstraint: CGFloat = 10
    static let kTitleLabelTopConstraint: CGFloat = 10
    static let kDesLabelTopConstraint: CGFloat = 5
    static let kBottomViewTopConstraint: CGFloat = 15
    static let kBottomLineViewTopConstraint: CGFloat = 15
    
    var headView: HomePageViewCellHeadView!
    var titleLabel: UILabel!
    var desLabel: UILabel!
    var bottomView: HomePageViewCellBottomView!
    var bottomLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.selectionStyle = .none
    }
}

// MARK: Public Method
extension HomePageViewCell {
    func configCell(withItemModel model: BlogItem) {
        headView.configHeadView(avatarUrl: model.avatar, blogName: model.blogName, postTime: Date.lc.timeAgoWithDate(model.postDate))
        titleLabel.text = model.title
        titleLabel.lc.changeLineSpace(5)
        desLabel.text = model.description
        desLabel.lc.changeLineSpace(5)
        
        bottomView.configBottomView(withFave: model.diggCount, comments: model.commentCount, views: model.viewCount)
    }
    
    static func cellHeight(_ model: BlogItem) -> CGFloat {
        let headViewHeight: CGFloat = HomePageViewCellHeadView.kHeadViewHeight;
        let titleHeight = model.title.lc.stringHeight(font: R.font.stHeitiSCMedium(size: 16), maxWidth: kScreenWidth - 30, lineSpace: 5)
        let descHeight = model.description.lc.stringHeight(font: R.font.hkGroteskRegular(size: 12), maxWidth: kScreenWidth - 30, lineSpace: 5)
        let bottomViewHeight: CGFloat = HomePageViewCellBottomView.kBottomViewHeight;
        let bottomLineViewHeight: CGFloat = 0.5
        
        let totalHeight: CGFloat = headViewHeight + Self.kHeadViewTopConstraint + titleHeight + Self.kTitleLabelTopConstraint + descHeight + Self.kDesLabelTopConstraint + bottomViewHeight + Self.kBottomViewTopConstraint + bottomLineViewHeight + Self.kBottomLineViewTopConstraint
        return totalHeight
    }
}

extension HomePageViewCell: InitViewProtocol {
    func initView() {
        headView = HomePageViewCellHeadView(frame: CGRect.zero)
        headView.delegate = self
        contentView.addSubview(headView)
        
        titleLabel = UILabel.lc.initLable(frame: CGRect.zero, title: "", textColor: R.color.black_444444(), font: R.font.stHeitiSCMedium(size: 16), numberOfLines: 0)
        contentView.addSubview(titleLabel)
        desLabel = UILabel.lc.initLable(frame: CGRect.zero, title: "", textColor: R.color.black_444444(), font: R.font.hkGroteskRegular(size: 14), numberOfLines: 0)
        contentView.addSubview(desLabel)
        
        bottomView = HomePageViewCellBottomView(frame: CGRect.zero)
        bottomView.delegate = self
        contentView.addSubview(bottomView)
        
        bottomLineView = UIView()
        bottomLineView.backgroundColor = R.color.gray_F1F3F2()
        contentView.addSubview(bottomLineView)
    }
    
    func autoLayoutView() {
        headView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(contentView)?.offset()(Self.kHeadViewTopConstraint)
            make?.leading.trailing().mas_equalTo()(contentView)?.offset()(0)
        }
        
        titleLabel.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(headView.mas_bottom)?.offset()(Self.kTitleLabelTopConstraint)
            make?.trailing.mas_equalTo()(contentView)?.offset()(-15)
            make?.leading.mas_equalTo()(contentView)?.offset()(15)
        }
        
        desLabel.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(titleLabel.mas_bottom)?.offset()(Self.kDesLabelTopConstraint)
            make?.trailing.mas_equalTo()(contentView)?.offset()(-15)
            make?.leading.mas_equalTo()(contentView)?.offset()(15)
        }
        
        bottomView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(desLabel.mas_bottom)?.offset()(Self.kBottomViewTopConstraint)
            make?.leading.mas_equalTo()(contentView)?.offset()(15)
            make?.trailing.mas_equalTo()(contentView)?.offset()(-15)
        }
        
        bottomLineView.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(bottomView.mas_bottom)?.offset()(Self.kBottomLineViewTopConstraint)
            make?.leading.trailing()?.bottom()?.mas_equalTo()(contentView)?.offset()(0)
            make?.height.mas_equalTo()(0.5)
        }
    }
}

extension HomePageViewCell: HomePageViewCellBottomViewDelegate {
    func faveAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.faveAction)) {
            delegate?.faveAction()
        }
    }
    
    func commentAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.commentAction)) {
            delegate?.commentAction()
        }
    }
    
    func lookAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.lookAction)) {
            delegate?.lookAction()
        }
    }
}

extension HomePageViewCell: HomePageViewCellHeadViewDelegate {
    func avatarAction() {
        if let _ = delegate?.responds(to: #selector(delegate?.avatarAction)) {
            delegate?.avatarAction()
        }
    }
}

