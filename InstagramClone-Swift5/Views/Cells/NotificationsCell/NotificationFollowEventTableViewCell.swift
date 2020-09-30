//
//  NotificationFollowEventTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/29/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate : AnyObject {
    func didTapRelatedPostButton(_ model : UserFollowRelationShip)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
      weak var delegate : NotificationFollowEventTableViewCellDelegate?
        
        private let profileImageView : UIImageView = {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        private let label : UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.numberOfLines = 1
            return label
        }()
        
        private let postButton : UIButton = {
            let button = UIButton()
            return button
        }()
        
        
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.clipsToBounds = true
            addSubview(profileImageView)
            addSubview(label)
        }
        
        func configure() {
            
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            postButton.setTitle(nil, for: .normal)
            postButton.backgroundColor = nil
            postButton.layer.borderWidth = 0
            label.text = nil
            profileImageView.image = nil
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
