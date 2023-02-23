//
//  MeTableHeadView.swift
//  BlogClient
//
//  Created by Long on 2020/4/30.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

@objc protocol MeTableHeadViewDelegate: NSObjectProtocol {
    @objc func selectAvatar()
    @objc func selectMyBlog()
    @objc func selectEssay()
    @objc func selectFave()
}

class MeTableHeadView: UIBaseView {
    weak var delegate: MeTableHeadViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var signLable: UILabel!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var blogItemIcon: UIImageView!
    @IBOutlet weak var blogItemLablel: UILabel!
    @IBOutlet weak var essayItemIcon: UIImageView!
    @IBOutlet weak var essayItemLabel: UILabel!
    @IBOutlet weak var faveItemIcon: UIImageView!
    @IBOutlet weak var faveItemLabel: UILabel!
    @IBOutlet weak var headViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var blogItem: UIView!
    @IBOutlet weak var essayItem: UIView!
    @IBOutlet weak var faveItem: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = Bundle.main.loadNibNamed(R.nib.meTableHeadView.name, owner: self, options: nil)?.last as? UIView
        contentView.frame = frame
        contentView.backgroundColor = UIColor.clear
        addSubview(contentView)
        
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configUI() {
        headViewTopConstraint.constant = isIPhoneXSeries() ? 100 : 80
        middleView.backgroundColor = R.color.white_FFFFFF()
        middleView.lc.addShadow(shadowColor:R.color.black_000000_14(), shadowOffset: CGSize.zero, shadowOpacity: 1, shadowRadius: 5, viewCornerRadius: 10)
        
        // 用户信息
        avatarImage.lc.addTapGesture(target: self, action: #selector(avatarImageClick))
        avatarImage.lc.addBorderAndCorner(borderWidth: 2.0, borderColor: R.color.white_FFFFFF() ?? UIColor.white, radius: 30)
        avatarImage.image = R.image.accountAvatar()
        avatarImage.backgroundColor = R.color.white_FFFFFF()
        userNameLable.font = R.font.hkGroteskBold(size: 14)
        userNameLable.textColor = R.color.white_FFFFFF()
        signLable.font = R.font.hkGroteskMedium(size: 12)
        signLable.textColor = R.color.white_FFFFFF()
        
        // 博客
        blogItem.lc.addTapGesture(target: self, action: #selector(blogItemClick))
        blogItemIcon.image = R.image.accountBlog()
        blogItemLablel.text = R.string.localizable.myBlogs(preferredLanguages: kAppLanguage)
        blogItemLablel.textColor = R.color.black_444444()
        blogItemLablel.font = R.font.stHeitiSCLight(size: 15)
        
        // 随笔
        essayItem.lc.addTapGesture(target: self, action: #selector(essayItemClick))
        essayItemIcon.image = R.image.accountEssay()
        essayItemLabel.text = R.string.localizable.essay(preferredLanguages: kAppLanguage)
        essayItemLabel.font = R.font.stHeitiSCLight(size: 15)
        essayItemLabel.textColor = R.color.black_444444()
        
        // 收藏
        faveItem.lc.addTapGesture(target: self, action: #selector(faveItemClick))
        faveItemIcon.image = R.image.accountFave()
        faveItemLabel.text =  R.string.localizable.fave(preferredLanguages: kAppLanguage)
        faveItemLabel.font = R.font.stHeitiSCLight(size: 15)
        faveItemLabel.textColor = R.color.black_444444()
    }
    
    func updateHeadView(avatarUrl: String, userName: String, sign: String) {
        if avatarUrl.hasSuffix("simple_avatar.gif") {
            //modify by longchi
        } else {
            avatarImage.kf.setImage(with: URL(string: avatarUrl), placeholder: R.image.accountAvatar())
        }
        
        userNameLable.text = userName
        signLable.text = sign
    }
    
    @objc func avatarImageClick() {
        if let _ = delegate?.responds(to: #selector(delegate?.selectAvatar)) {
            delegate?.selectAvatar()
        }
    }
    
    @objc func blogItemClick() {
        if let _ = delegate?.responds(to: #selector(delegate?.selectMyBlog)) {
            delegate?.selectMyBlog()
        }
    }
    
    @objc func essayItemClick() {
        if let _ = delegate?.responds(to: #selector(delegate?.selectEssay)) {
            delegate?.selectEssay()
        }
    }
    
    @objc func faveItemClick() {
        if let _ = delegate?.responds(to: #selector(delegate?.selectFave)) {
            delegate?.selectFave()
        }
    }
}


