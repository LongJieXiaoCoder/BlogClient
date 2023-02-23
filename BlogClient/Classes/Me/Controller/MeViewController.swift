//
//  MeViewController.swift
//  BlogClient
//
//  Created by Long on 2020/4/27.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

class MeViewController: UIBaseViewController {
    let bgImageHeight: CGFloat = 230

    var tableView: UITableView!
    var tableHeadView: MeTableHeadView!
    var tableFooterView: MeTableFooterView!
    var backgroundImage: UIImageView!
    let dataSource = [
        [R.image.accountSetting() as Any, R.string.localizable.setting(preferredLanguages: kAppLanguage), R.image.rightArrow() as Any],
        [R.image.accountFeedback() as Any, R.string.localizable.feedback(preferredLanguages: kAppLanguage), R.image.rightArrow() as Any],
        [R.image.accountAbout() as Any, R.string.localizable.about(preferredLanguages: kAppLanguage), R.image.rightArrow() as Any]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = R.color.white_FFFFFF()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if !User.exist() {
            // 如果没有个人信息，则进行请求
            UserService.getUserInfo { (result, status) in
                switch status {
                case .success :
                    guard let user: User = result as? User else { return log("转换个人信息失败") }
                    StoreHelper.write(user, to: FilePath.userPath)
                    self.tableHeadView.updateHeadView(avatarUrl: user.avatarUrl, userName: user.displayName, sign: "加油~")
                    self.tableFooterView.isHidden = false
                    log("获取个人信息成功")
                case .failure :
                    log("获取个人信息失败\(result)")
                }
            }
//        }
    }
}

// MARK: - InitViewProtocol
extension MeViewController: InitViewProtocol {
    func initView() {
        backgroundImage = UIImageView.lc.initImageView(frame: CGRect.init(x: 0, y: 0, width:self.view.lc.width , height: bgImageHeight), image: R.image.accountBackgroundImage(), contentModel: .scaleAspectFill)
        self.view.addSubview(backgroundImage)
        
        tableView = UITableView.lc.initTableView(frame: .zero, style: .plain, delegate: self, dataSource: self, separatorStyle: .none, showIndicator: false)
        tableView.backgroundColor = UIColor.clear
        tableView.register(R.nib.meTableViewCell)
        
        tableFooterView = MeTableFooterView(frame: CGRect.init(x: 0, y: 0, width: self.view.lc.width, height: 80))
        tableFooterView.delegate = self
        tableFooterView.isHidden = true
        tableView.tableFooterView = tableFooterView
        
        tableHeadView = MeTableHeadView(frame: CGRect.init(x: 0, y: 0, width: self.view.lc.width, height: isIPhoneXSeries() ? 290 : 270))
        tableHeadView.delegate = self
        tableView.tableHeaderView = tableHeadView
        if User.exist() {
            if let user: User = StoreHelper.read(User.self, from: FilePath.userPath) {
                tableHeadView.updateHeadView(avatarUrl: user.avatarUrl, userName: user.displayName, sign: "加油~")
                tableFooterView.isHidden = false
            }
        }
        
        self.view.addSubview(tableView)
    }
    
    func autoLayoutView() {
        tableView.mas_makeConstraints { (make) in
            make?.edges.mas_equalTo()(self.view)?.offset()(0)
        }
    }
}

// MARK: - MeTableFooterViewDelegate
extension MeViewController: MeTableFooterViewDelegate {
    func logout() {
        StoreHelper.write("", to: FilePath.userPath)
        tableHeadView.updateHeadView(avatarUrl: "", userName: "", sign: "加油~")
        tableFooterView.isHidden = true
    }
}

// MARK: - MeTableHeadViewDelegate
extension MeViewController: MeTableHeadViewDelegate {
    func selectAvatar() {
        let parameter = "\(API.rpk.client_id)=\(API.rpv.client_id)&\(API.rpk.scope)=\(API.rpv.scope)&\(API.rpk.response_type)=\(API.rpv.response_type)&\(API.rpk.redirect_uri)=\(API.rpv.redirect_uri)&\(API.rpk.state)=\(API.rpv.state)&\(API.rpk.nonce)=\(API.rpv.nonce)"
        let url = API.url.connectAuthorize + "?\(parameter)"
        let loginViewController = LoginViewController(url: url)
        loginViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func selectMyBlog() {
        log("selectMyBlog")
        
        let webVC = WKWebViewController(url: "http://www.cnblogs.com/haoyunlaile/p/12960441.html")
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func selectEssay() {
        log("selectEssay")
    }
    
    func selectFave() {
        log("selectFave")
    }
    
    func selectSetting() {
        log("selectSetting")
    }

    func selectFeedback() {
        log("selectFeedback")
    }

    func selectAbout() {
        log("selectAbout")
    }
}

// MARK: - UITableViewDelegate
extension MeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.selectSetting()
        } else if indexPath.row == 1 {
            self.selectFeedback()
        } else if indexPath.row == 2 {
            self.selectAbout()
        }
    }
}

// MARK: - UITableViewDataSource
extension MeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.meTableViewCell, for: indexPath)
        let objInfo = dataSource.lc.objectAtIndex(indexPath.row) as? [Any]
        
        cell?.configCell(icon: objInfo?.lc.objectAtIndex(0) as? UIImage, content: objInfo?.lc.objectAtIndex(1) as? String ?? "", arrowIcon: objInfo?.lc.objectAtIndex(2) as? UIImage)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UIScrollViewDelegate
extension MeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetSetY: CGFloat = scrollView.contentOffset.y
        
        if (offsetSetY > 0) {
            backgroundImage.frame = CGRect.init(x: 0, y: -offsetSetY, width: self.view.lc.width, height: bgImageHeight)
        } else {
            let curBgImgHeight = bgImageHeight - offsetSetY
            let curBgImgWidth = (self.view.lc.width / bgImageHeight) * curBgImgHeight
            backgroundImage.frame = CGRect.init(x: -(curBgImgWidth - self.view.lc.width)/2, y: 0, width: curBgImgWidth, height: curBgImgHeight)
        }
    }
}


