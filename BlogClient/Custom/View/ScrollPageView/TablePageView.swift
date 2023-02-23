//
//  TablePageView.swift
//  BlogClient
//
//  Created by Long on 2020/5/21.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

class TablePageView: PageView {
    var tableView: UITableView!
    var dataSource: [Any] = [Any]()
    
    convenience init(frame: CGRect, tableView: UITableView) {
        self.init(frame: frame)
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func enableRefreshHeader() {
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(headRefreshingAction))
        self.tableView.mj_header?.isAutomaticallyChangeAlpha = true
        self.tableView.mj_header?.beginRefreshing()
    }
    
    func enableRefreshFooter() {
        self.tableView.mj_footer = MJRefreshFooter.init(refreshingTarget: self, refreshingAction: #selector(footerRefreshAction))
    }
    
    @objc func headRefreshingAction() {
        self.refreshRequest { (result) in
            self.tableView.mj_header?.endRefreshing()
        }
    }
    
    @objc func footerRefreshAction() {
        self.loadMoreRequest { (result) in
            self.tableView.mj_footer?.endRefreshing()
        }
    }
    
    func refreshRequest(callBack: (Bool) -> ()) {
        //rewrite subclass
    }
    
    func loadMoreRequest(callBack: (Bool) -> ()) {
        //rewrite subclass
    }
}

// MARK: - UITableViewDelegate
extension TablePageView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section == lastSectionIndex, indexPath.row == lastRowIndex {
            self.tableView.mj_footer?.beginRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource
extension TablePageView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    }
}
