//
//  IGFeedPostHeaderTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/24/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class IGFeedPostHeaderTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.backgroundColor = UIColor.systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
}
