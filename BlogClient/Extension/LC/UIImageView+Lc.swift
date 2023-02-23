//
//  UIImageView+Lc.swift
//  BlogClient
//
//  Created by LongMac on 2020/4/30.
//  Copyright © 2020 LongMac. All rights reserved.
//

import Foundation

extension LC where Base: UIImageView {
    static func initImageView(frame: CGRect, image: UIImage?, contentModel: UIView.ContentMode = .scaleAspectFit) -> UIImageView {
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        imageView.contentMode = contentModel
        return imageView
    }
}
