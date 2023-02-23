//
//  UITableView+Lc.swift
//  BlogClient
//
//  Created by Long on 2020/4/30.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

typealias CallBack = (Bool) -> ()

protocol RefreshDelegate {
    // 下拉加载
    func refreshRequest(callBack: @escaping CallBack)
    
    // 上拉加载
    func loadMoreRequest(callBack: @escaping CallBack)
}

extension LC where Base: UITableView {
    static func initTableView(frame: CGRect, style: UITableView.Style, delegate: UITableViewDelegate?, dataSource: UITableViewDataSource?, separatorStyle: UITableViewCell.SeparatorStyle, showIndicator: Bool) -> UITableView {
        let tableView = UITableView(frame: frame, style: style)
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = separatorStyle
        tableView.showsHorizontalScrollIndicator = showIndicator
        tableView.showsVerticalScrollIndicator = showIndicator
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }
    
    func enableRefreshHeader() {
        base.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            if let _ = self.base.refreshDelegate  {
                self.base.refreshDelegate?.refreshRequest(callBack: { (result) in
                    self.base.mj_header?.endRefreshing()
                })
            } else {
                self.base.mj_header?.endRefreshing()
            }
        })
        base.mj_header?.isAutomaticallyChangeAlpha = true
        base.mj_header?.beginRefreshing()
    }
    
    func enableRefreshFooter() {
        base.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            if let _ = self.base.refreshDelegate {
                self.base.refreshDelegate?.loadMoreRequest(callBack: { (result) in
                    self.base.mj_footer?.endRefreshing()
                })
            } else {
                self.base.mj_footer?.endRefreshing()
            }
        })
    }
}

extension UITableView {
    private static var kRefreshDelegateKey: Void?
    var refreshDelegate: RefreshDelegate? {
        set {
            objc_setAssociatedObject(self, &Self.kRefreshDelegateKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        
        get {
            objc_getAssociatedObject(self, &Self.kRefreshDelegateKey) as? RefreshDelegate
        }
    }
}
