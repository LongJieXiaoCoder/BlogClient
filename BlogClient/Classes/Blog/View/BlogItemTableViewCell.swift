//
//  BlogItemTableViewCell.swift
//  BlogClient
//
//  Created by Long on 2023/2/23.
//  Copyright © 2023 LongMac. All rights reserved.
//

import UIKit
import SnapKit


class BlogItemTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        return UILabel.lc.initLable(frame: CGRect.zero, title: "", textColor: R.color.black_444444(), font: R.font.stHeitiSCMedium(size: 16), numberOfLines: 0)
    }()
    
    lazy var userNameLable: UILabel = {
        return UILabel.lc.initLable(frame: CGRect.zero, title: "", textColor: R.color.black_757575(), font: R.font.hkGroteskRegular(size: 12), numberOfLines: 0)
    }()
    
    lazy var separateLineView: UIView = {
        separateLineView = UIView.init()
        separateLineView.backgroundColor = R.color.black_ECECEC()
        return separateLineView
    }()
    
    lazy var postTimeLabel: UILabel = {
        return UILabel.lc.initLable(frame: CGRect.zero, title: "", textColor: R.color.black_757575(), font: R.font.hkGroteskRegular(size: 12), numberOfLines: 0)
    }()
    
    lazy var desLabel: UILabel = {
        return UILabel.lc.initLable(frame: CGRect.zero, title: "", textColor: R.color.black_757575(), font: R.font.hkGroteskRegular(size: 14), numberOfLines: 0)
    }()
    
    
    lazy var likeItemView: IconLabelView = {
        likeItemView = IconLabelView.init(frame: CGRect.zero)
        likeItemView.textLabel.font = R.font.hkGroteskRegular(size: 10)
        likeItemView.textLabel.textColor = R.color.black_757575()
        return likeItemView
    }()
    
    lazy var commentItemView: IconLabelView = {
        commentItemView = IconLabelView.init(frame: CGRect.zero)
        commentItemView.textLabel.font = R.font.hkGroteskRegular(size: 10)
        commentItemView.textLabel.textColor = R.color.black_757575()
        return commentItemView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BlogItemTableViewCell: InitViewProtocol {
    func initView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(userNameLable)
        contentView.addSubview(separateLineView)
        contentView.addSubview(postTimeLabel)
        contentView.addSubview(desLabel)
        contentView.addSubview(likeItemView)
        contentView.addSubview(commentItemView)
    }
    
    func autoLayoutView() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(10)
            make.leading.equalTo(self.contentView).offset(16)
            make.trailing.equalTo(self.contentView).offset(-16)
        }
        
        userNameLable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(self.contentView).offset(16)
            make.height.equalTo(20)
        }
        
        separateLineView.snp.makeConstraints { make in
            make.centerY.equalTo(userNameLable).offset(0)
            make.leading.equalTo(userNameLable.snp.trailing).offset(8)
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
        
        postTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userNameLable).offset(0)
            make.leading.equalTo(separateLineView.snp.trailing).offset(8)
            make.height.equalTo(20)
        }
        
        desLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLable.snp.bottom).offset(5)
            make.leading.equalTo(self.contentView).offset(16)
            make.trailing.equalTo(self.contentView).offset(-16)
            make.height.equalTo(40);
        }
        
        likeItemView.snp.makeConstraints { make in
            make.top.equalTo(desLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.contentView).offset(16)
            make.width.equalTo(50)
            make.height.equalTo(15)
        }
        
        commentItemView.snp.makeConstraints { make in
            make.centerY.equalTo(likeItemView).offset(0)
            make.leading.equalTo(likeItemView.snp.trailing).offset(16)
            make.width.equalTo(50)
            make.height.equalTo(15)
        }
    }
}


// MARK: Public Method
extension BlogItemTableViewCell {
    func configCell(withItemModel model: BlogItem) {
        titleLabel.text = model.title
        userNameLable.text = model.blogName
        postTimeLabel.text = Date.lc.timeAgoWithDate(model.postDate)
        desLabel.text = model.description
        
        likeItemView.configView(withIcon: R.image.fave(), text: "\(model.diggCount)")
        commentItemView.configView(withIcon: R.image.comment(), text: "\(model.commentCount)")
        
        
//        lookView.configView(withIcon: R.image.views(), text: "\(views)")
//        headView.configHeadView(avatarUrl: model.avatar, blogName: model.blogName, postTime: Date.lc.timeAgoWithDate(model.postDate))
//        bottomView.configBottomView(withFave: model.diggCount, comments: model.commentCount, views: model.viewCount)
    }
    
    static func cellHeight(_ model: BlogItem) -> CGFloat {
        let titleHeight = model.title.lc.stringHeight(font: R.font.stHeitiSCMedium(size: 16), maxWidth: kScreenWidth - 32, lineSpace: 5)
        print("titleHeight: \(titleHeight)， title = \(model.title)")
        return 120 + titleHeight;
    }
}
