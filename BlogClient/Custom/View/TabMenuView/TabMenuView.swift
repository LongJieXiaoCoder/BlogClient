//
//  TabMenuView.swift
//  BlogClient
//
//  Created by LongMac on 2020/5/17.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit
import SnapKit

@objc protocol TabMenuViewDelegate: NSObjectProtocol {
    @objc func selectMenuTitleIndex(_ index: Int, itemModel: TabMenuItemProtocol?) -> Void
}

@objc protocol TabMenuItemProtocol {
    var title: String { get }
}

class TabMenuView: UIBaseView {
    static let kItemPadding: CGFloat = 20
    
    weak var delegate: TabMenuViewDelegate?
    
    var scrollView: UIScrollView!
    var containerView: UIView!
    var associateScrollView: UIScrollView?    //外部的scrollView, 用来控制联动的
    var selectedIndex: Int = 0
    var buttonItems = [UIButton]()
    var itemModels = [TabMenuItemProtocol]()
    
    lazy var markView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.red_F15A43()
        view.lc.addCorner(1.5)
        return view
    }()
    
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
    
    deinit {
        // 移除监听
        associateScrollView?.removeObserver(self, forKeyPath: US.keyPath.contentOffset, context: nil)
    }
}

// MARK: - InitViewProtocol
extension TabMenuView: InitViewProtocol {
    func initView() {
        scrollView = UIScrollView.lc.initScrollView(frame: CGRect.zero, delegate: self, showIndicator: false)
        self.addSubview(scrollView)
        
        containerView = UIView()
        containerView.backgroundColor = R.color.white_FFFFFF()
        scrollView.addSubview(containerView)
    }
    
    func autoLayoutView() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(self).offset(0)
        }
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView).offset(0)
            make.height.equalTo(scrollView)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension TabMenuView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

// MARK: - Public Method
extension TabMenuView {
    func loadTabMenu(datas: [TabMenuItemProtocol], selectedIndex: Int) {
        if datas.count <= 0  { return }
        self.selectedIndex = selectedIndex
        self.itemModels = datas
        
        var previous: UIView?
        for index: Int in 0..<datas.count {
            let itemModel = datas.lc.objectAtIndex(index) as! TabMenuItemProtocol
            let itemButton = UIButton.lc.initButton(frame: CGRect.zero, title: itemModel.title, font: R.font.stHeitiSCMedium(size: 16), titleColor: R.color.black_444444())
            itemButton.addTarget(self, action: #selector(selectItemAction(_:)), for: .touchUpInside)
            containerView.addSubview(itemButton)
            buttonItems.append(itemButton)
            
            let width = itemModel.title.lc.stringWidth(font: R.font.stHeitiSCMedium(size: 16), maxWidth: self.lc.width)
            itemButton.mas_makeConstraints { (make) in
                if let preView = previous {
                    make?.leading.mas_equalTo()(preView.mas_trailing)?.offset()(Self.kItemPadding)
                } else {
                    make?.leading.mas_equalTo()(containerView)?.offset()(Self.kItemPadding)
                }
                make?.centerY.mas_equalTo()(containerView)
                make?.width.mas_equalTo()(width)
            }
            previous = itemButton
            
            if index == selectedIndex {
                addBottomLineMark(itemButton: itemButton)
            }
        }
        
        if let preView = previous {
            containerView.mas_updateConstraints { (make) in
                make?.trailing.mas_equalTo()(preView.mas_trailing)?.offset()(Self.kItemPadding)
            }
        }
    }
    
    func setAssociateScrollView(_ scrollView: UIScrollView) {
        if associateScrollView != nil {
            associateScrollView?.removeObserver(self, forKeyPath: US.keyPath.contentOffset, context: nil)
        }
        associateScrollView = scrollView
        associateScrollView?.addObserver(self, forKeyPath: US.keyPath.contentOffset, options: .new, context: nil)
    }
}

// MARK: - Private Method
extension TabMenuView {
    @objc func selectItemAction(_ itemButton: UIButton) {
        scrollToItem(itemButton, needScoll: true)
    }
    
    func scrollToItem(_ itemButton: UIButton, needScoll: Bool) {
        guard let index = buttonItems.firstIndex(of: itemButton) else { return }
        if index == self.selectedIndex { return }
        
        // 更新标记的位置
        updateBottomLineMark(itemButton)
        
        // 回调
        if let _ = delegate?.responds(to: #selector(delegate?.selectMenuTitleIndex(_:itemModel:))) {
            delegate?.selectMenuTitleIndex(index, itemModel: itemModels.lc.objectAtIndex(index) as? TabMenuItemProtocol)
        }
        
        // 设置contentOffset
        if needScoll {
            if let associateView = associateScrollView  {
                associateView.setContentOffset(CGPoint(x: associateView.lc.width * CGFloat(index), y: 0), animated: true)
            }
        }
        
        // 内容的滚动到合适的位置
        scrollItemToSuitablePlace(index)
        self.selectedIndex = index
    }
    
    func scrollItemToSuitablePlace(_ index: Int) {
        if !buttonItems.lc.isValidIndex(index) { return }
        if self.scrollView.contentSize.width < self.scrollView.lc.width { return }
        
        // 往后
        if index > selectedIndex {
            let nextIndex = index + 1
            guard let nextItemButton = buttonItems.lc.objectAtIndex(nextIndex) as? UIButton else { return }
            let maxX = buttonItems.last?.lc.right ?? 0 + Self.kItemPadding
            if nextItemButton.lc.right > self.scrollView.lc.width {
                let targetX = nextItemButton.lc.right + Self.kItemPadding
                let offsetX = min(targetX, maxX) - self.scrollView.lc.width
                self.scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            }
            //            guard let targetButton = buttonItems.lc.objectAtIndex(index) as? UIButton else { return }
            //            let targetX = targetButton.lc.right + Self.kItemPadding + 10
            
        } else {
            // 往前
            if self.scrollView.contentOffset.x <= 0 { return }
            
            let preIndex = index - 1 >= 0 ? index - 1 : 0
            guard let preItemButton = buttonItems.lc.objectAtIndex(preIndex) as? UIButton else { return }
            let targetX = preItemButton.lc.left - Self.kItemPadding
            if targetX < self.scrollView.contentOffset.x {
                let offsetX = max(0, targetX)
                scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
            }
        }
    }
    
    func addBottomLineMark(itemButton: UIButton) {
        self.addSubview(markView)
        markView.mas_makeConstraints { (make) in
            make?.centerX.mas_equalTo()(itemButton.mas_centerX)?.offset()(0)
            make?.top.mas_equalTo()(itemButton.mas_bottom)?.offset()(-5)
            make?.width.mas_equalTo()(12)
            make?.height.mas_equalTo()(3)
        }
    }
    
    func updateBottomLineMark(_ itemButton: UIButton) {
        markView.mas_remakeConstraints { (make) in
            make?.centerX.mas_equalTo()(itemButton.mas_centerX)?.offset()(0)
            make?.top.mas_equalTo()(itemButton.mas_bottom)?.offset()(-5)
            make?.width.mas_equalTo()(12)
            make?.height.mas_equalTo()(3)
        }
        UIView.animate(withDuration: 0.15) {
            self.layoutIfNeeded()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let associateView = associateScrollView else { return }
        
        if keyPath == US.keyPath.contentOffset, (associateView.isTracking || associateView.isDecelerating) {
            if let contentOffset = change?[.newKey] as? CGPoint {
                var ratio: CGFloat  = contentOffset.x / associateView.lc.width + 0.5
                ratio = max(0, min(CGFloat(buttonItems.count - 1), ratio))
                let baseIndex = Int(floorf(Float(ratio)))
                guard let itemButton = buttonItems.lc.objectAtIndex(baseIndex) as? UIButton else { return }
                self.scrollToItem(itemButton, needScoll: false)
            }
        }
    }
}

