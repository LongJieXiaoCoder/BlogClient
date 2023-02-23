//
//  UIScrollView+Lc.swift
//  BlogClient
//
//  Created by LongMac on 2020/4/30.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

extension LC where Base: UIScrollView {
  // MARK: 生成一个UIScrollView
   static func initScrollView(frame: CGRect, delegate: UIScrollViewDelegate, showIndicator: Bool) -> UIScrollView {
        let scrollView = UIScrollView(frame: frame)
        scrollView.showsVerticalScrollIndicator = showIndicator
        scrollView.showsHorizontalScrollIndicator = showIndicator
        scrollView.delegate = delegate
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView;
    }
    
    // MARK: 生成一个UIScrollView
    static func initScrollView(frame: CGRect, delegate: UIScrollViewDelegate, showIndicator: Bool, pageEnable: Bool, bounces: Bool) -> UIScrollView {
        let scrollView = UIScrollView(frame: frame)
        scrollView.showsVerticalScrollIndicator = showIndicator
        scrollView.showsHorizontalScrollIndicator = showIndicator
        scrollView.isPagingEnabled = pageEnable
        scrollView.delegate = delegate
        scrollView.bounces = bounces
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        return scrollView;
    }
}
