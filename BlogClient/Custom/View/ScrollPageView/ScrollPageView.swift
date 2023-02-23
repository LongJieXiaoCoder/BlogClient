//
//  ScrollPageView.swift
//  BlogClient
//
//  Created by Long on 2020/5/19.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol ScrollPageViewDelegate: NSObjectProtocol {
    // 获取pageView
    @objc func pageScrollView(_ scrollView: ScrollPageView, pageViewForIndex index: Int) -> PageView
    // 加载pageView的数据
    @objc func pageScrollview(_ scrollView: ScrollPageView, loadDataForPageView pageView: PageView, index: Int) -> Void
}

class ScrollPageView: UIBaseView {
    weak var delegate: ScrollPageViewDelegate?
    
    var scrollView: UIScrollView!
    var containerView: UIView!
    var currentPageIndex: Int = 0
    var totalPage: Int = 0
    var pageViewArray = [PageView]()

    init() {
        super.init(frame: CGRect.zero)
        self.setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - InitViewProtocol
extension ScrollPageView: InitViewProtocol {
    func initView() {
        scrollView = UIScrollView.lc.initScrollView(frame: CGRect.zero, delegate: self, showIndicator: false, pageEnable: true, bounces: false)
        self.addSubview(scrollView)
        
        containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        scrollView.addSubview(containerView)
    }
    
    func autoLayoutView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self).offset(0)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView).offset(0)
            make.height.equalTo(scrollView)
        }
    }
}

// MARK: - Public Method
extension ScrollPageView {
    // 设置当前的pageIndex
    func setCurrentPageIndex(_ index: Int) {
        self.currentPageIndex = index
    }
    
    // 加载page
    func loadPage(_ datas: [Any]) {
        if datas.count <= 0 || delegate == nil { return }
        
        totalPage = datas.count
        var previous: UIView? = nil
        for index in 0..<datas.count {
            guard let _ = delegate?.responds(to: #selector(delegate?.pageScrollView(_:pageViewForIndex:))) else { return }
            guard let pageView: PageView = delegate?.pageScrollView(self, pageViewForIndex: index) else { return }
            pageView.pageIndex = index
            containerView.addSubview(pageView)
//            pageView.mas_makeConstraints { (make) in
//                if let preView = previous {
//                    make?.leading.mas_equalTo()(preView.mas_trailing)?.offset()(0)
//                } else {
//                    make?.leading.mas_equalTo()(containerView)?.offset()(0)
//                }
//                make?.top.bottom()?.mas_equalTo()(containerView)?.offset()(0)
//                make?.width.mas_equalTo()(kScreenWidth)
//            }
            pageView.snp.makeConstraints { make in
                if let previous = previous {
                    make.leading.equalTo(previous.snp.trailing).offset(0)
                } else {
                    make.leading.equalTo(containerView).offset(0)
                }
                make.top.bottom.equalTo(containerView).offset(0)
                make.width.equalTo(kScreenWidth)
            }
            
            if index == datas.count - 1 {
//                containerView.mas_makeConstraints { (make) in
//                    make?.trailing.mas_equalTo()(pageView)
//                }
                containerView.snp.makeConstraints { make in
                    make.trailing.equalTo(pageView).offset(0)
                }
            }
            previous = pageView
            pageViewArray.append(pageView)
            
            if index == currentPageIndex {
                scrollToPageIndex(index)
            }
        }
    }
    
    // 跳转到指定的index
    func scrollToPageIndex(_ index: Int) {
        if index < 0 { return }
        // contentSize
        
        // contentOffset
        scrollView.setContentOffset(CGPoint(x: scrollView.lc.width * CGFloat(index), y: 0), animated: true)
    
        // 加载page
        guard let _ = delegate?.responds(to: #selector(delegate?.pageScrollview(_:loadDataForPageView:index:))) else { return }
        guard let pageView = pageViewArray.lc.objectAtIndex(index) as? PageView else { return }
        delegate?.pageScrollview(self, loadDataForPageView: pageView, index: index)
    }
}

// MARK: - Private Method
extension ScrollPageView {
//    func kScrollPageViewTag(_ tag: Int) -> Int {
//        1000 + tag
//    }
}



// MARK: - UIScrollViewDelegate
extension ScrollPageView: UIScrollViewDelegate {
    
}

