//
//  UILabel+Lc.swift
//  BlogClient
//
//  Created by LongMac on 2020/5/19.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

//extension UILabel: LCCompatible {}
extension LC: LCCompatible where Base: UILabel {
    static func initLable(frame: CGRect, title: String = "", textColor: UIColor?, font: UIFont?, numberOfLines: Int = 1) -> UILabel {
        let label: UILabel = UILabel(frame: frame)
        label.text = title
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byTruncatingTail
        return label
    }
    
    // 改变行高
    func changeLineSpace(_ lineSpace: CGFloat) {
        let text = base.text ?? ""
        let attributedString: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, text.count))
        base.attributedText = attributedString
        base.sizeToFit()
    }
    
    // 改变单词间距
    func changeWordSpace(_ wordSpace: CGFloat) {
        let text = base.text ?? ""
        let attributeString: NSMutableAttributedString = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.kern: wordSpace])
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributeString.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSMakeRange(0, text.count))
        base.attributedText = attributeString
        base.sizeToFit()
    }
    
    // 改变行高和单词间距
    func changeLineSpace(_ lineSpace: CGFloat, wordSpace: CGFloat) {
        let text = base.text ?? ""
        let attributedString: NSMutableAttributedString = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.kern: wordSpace])
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = .byTruncatingTail
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, text.count))
        base.attributedText = attributedString
        base.sizeToFit()
    }
}
