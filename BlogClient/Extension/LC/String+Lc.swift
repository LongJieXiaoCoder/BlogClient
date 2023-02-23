//
//  String+Lc.swift
//  BlogClient
//
//  Created by Long on 2020/4/29.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

extension String: LCCompatible {}
extension NSString: LCCompatible {}
extension LC where Base: ExpressibleByStringLiteral {
    var numberCount: Int {
        let string = base as! String
        var count = 0
        for n in string where ("0"..."9").contains(n) {
            count += 1
        }
        return count
    }
    
    func stringWidth(font: UIFont?, maxWidth: CGFloat) -> CGFloat {
        let string = base as! String
        let lable: UILabel = UILabel()
        lable.font = font ?? UIFont.systemFont(ofSize: 12)
        lable.text = string
        lable.numberOfLines = 0
        let size: CGSize = lable.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        return size.width
    }
    
    func stringHeight(font: UIFont?, maxWidth: CGFloat, lineSpace: CGFloat) -> CGFloat {
        let string = base as! String
        let lable: UILabel = UILabel()
        lable.font = font ?? UIFont.systemFont(ofSize: 12)
        let attributeStr = NSMutableAttributedString.init(string: string)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpace
        attributeStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSMakeRange(0, string.count))
        lable.attributedText = attributeStr
        lable.numberOfLines = 0
        let size: CGSize = lable.sizeThatFits(CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude))
        return size.height
    }
    
    func urlParameterValue(_ parameter: String) -> String? {
        let url = base as! NSString
        let paras = url.components(separatedBy: "&") as NSArray
        
        let target = paras.filter { (element) -> Bool in
            let ele = element as! NSString
            return ele.contains("\(parameter)=")
        }
        
        if target.count <= 0 {
            return nil
        }
        
        let str = target.first as! NSString
        let range = str.range(of: "\(parameter)=", options: .caseInsensitive)
        if range.location == NSNotFound {
            return nil
        }
        
        let value = str.substring(with: NSRange(location: range.location + range.length, length: str.length - (range.location + range.length)))
        return value
    }
    
    func stringToDate(withFormat format: String) -> Date? {
        let str = base as! String
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale.init(identifier: "zh_CN")
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 8*3600)
        let date = dateFormatter.date(from: str)
        return date
    }
    
}
