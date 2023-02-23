//
//  MeTableViewCell.swift
//  BlogClient
//
//  Created by Long on 2020/4/30.
//  Copyright © 2020 LongMac. All rights reserved.
//

import UIKit

class MeTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var arrowIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(icon: UIImage?, content: String, arrowIcon: UIImage?) {
        self.contentView.backgroundColor = R.color.white_FFFFFF()
        contentLabel.font = R.font.stHeitiSCLight(size: 15)
        contentLabel.textColor = R.color.black_444444()
        
        iconImage.image = icon
        contentLabel.text = content
        self.arrowIcon.image = arrowIcon
    }
}
