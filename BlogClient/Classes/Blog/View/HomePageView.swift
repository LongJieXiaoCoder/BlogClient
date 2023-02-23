//
//  HomePageView.swift
//  BlogClient
//
//  Created by Long on 2020/5/19.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit
import SnapKit

enum HomePageType: Int {
    case home     // 首页
    case essence  // 精选
}

class HomePageView: PageView {
    lazy var tableView: UITableView = {
        tableView = UITableView.lc.initTableView(frame: CGRect.zero, style: .grouped, delegate: self, dataSource: self, separatorStyle: .none, showIndicator: true)
        tableView.refreshDelegate = self
//        tableView.register(HomePageViewCell.self, forCellReuseIdentifier: NSStringFromClass(HomePageViewCell.self))
        tableView.register(BlogItemTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(BlogItemTableViewCell.self))
        return tableView
    }()
    
    var dataSource: [BlogItem] = [BlogItem]()
    var isRequesting: Bool = false
    var curIndex: Int = 1
    var pageType: HomePageType = .home
    
    init(frame: CGRect, type: HomePageType) {
        super.init(frame: frame)
        self.pageType = type
        self.setupUI()
        tableView.lc.enableRefreshHeader()
        tableView.lc.enableRefreshFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - InitViewProtocol
extension HomePageView: InitViewProtocol {
    func initView() {
        self.addSubview(tableView)
    }
    
    func autoLayoutView() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self).offset(0)
        }
    }
}


// MARK: - Public Method
extension HomePageView {
    // load data
    func loadPageData() {
        if dataSource.count == 0  {
            requestData(isLoadMore: false) { _ in }
        }
    }
}

// MARK: - Request
extension HomePageView {
    // request
    func requestData(isLoadMore: Bool, callBack: @escaping CallBack) {
        if (isRequesting) {
            return callBack(false)
        }
        isRequesting = true
        let pageIndex = isLoadMore ? curIndex : 1
        HomeService.getHomeBlogListInfo(with: self.pageType, pageSize: 20, pageIndex: pageIndex) { [weak self] (result, status) in
            switch status {
            case .success:
                guard let items = result as? [BlogItem] else { return callBack(false) }
                if isLoadMore {
                    self?.dataSource.append(contentsOf: items)
                } else {
                    self?.dataSource.removeAll()
                    self?.dataSource = items
                }
                self?.curIndex += 1
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                callBack(true)
            case .failure:
                callBack(false)
            }
            
            self?.isRequesting = false
        }
    }
}


// MARK: - RefreshDelegate
extension HomePageView: RefreshDelegate {
    // 下拉加载
    func refreshRequest(callBack: @escaping CallBack) {
        requestData(isLoadMore: false, callBack: callBack)
    }
    
    // 上拉加载
    func loadMoreRequest(callBack: @escaping CallBack) {
        requestData(isLoadMore: true, callBack: callBack)
    }
}

// MARK: - UITableViewDelegate
extension HomePageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let itemModel = dataSource.lc.objectAtIndex(indexPath.section) as? BlogItem else { return 0 }
        return BlogItemTableViewCell.cellHeight(itemModel)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemModel = dataSource.lc.objectAtIndex(indexPath.row) as? BlogItem else { return }
        let url = API.url.blogpostsBody(blogId: "\(itemModel.id)")
        
        HomeService.getHomeBlogInfo(url: url) { [weak self] (responseObject, status) in
            switch status {
            case .success:
                if let body = responseObject as? String {
                    let HTMLString = ContentHTMLTemplateWithArgs(titleFontSize: 24.0, titleFontColor: "#000000", timeFontSize: 16.0, timeFontColor: "#5F5F5F", bodyFontSize: 16.0, bodyFontColor: "#3F3F3F", title: itemModel.title, time: Date.lc.timeAgoWithDate(itemModel.postDate), body: body)
                    self?.openArtical(HTMLString: HTMLString)
                }
            case .failure:
                log("失败了")
            }
        }
    }
    
    func openArtical(HTMLString: String) {
        let displayContentVc = DisplayContentViewController(HTMLString: HTMLString)
        displayContentVc.hidesBottomBarWhenPushed = true
        NavigationViewController.pushViewController(displayContentVc, animation: true)
    }
}

// MARK: - UITableViewDataSource
extension HomePageView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.001))
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 8))
        footerView.backgroundColor = R.color.black_ECECEC()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemModel = dataSource.lc.objectAtIndex(indexPath.section) as? BlogItem else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(BlogItemTableViewCell.self), for: indexPath) as? BlogItemTableViewCell else { return UITableViewCell() }
        cell.configCell(withItemModel: itemModel)
//        cell.delegate = self
        return cell
    }
}

// MARK: - HomePageViewCellDelegate
extension HomePageView: HomePageViewCellDelegate {
    func faveAction() {
        log("faveAction")
    }
    
    func commentAction() {
        log("commentAction")
    }
    
    func lookAction() {
        log("lookAction")
    }
    
    func avatarAction() {
        log("avatarAction")
    }
}
