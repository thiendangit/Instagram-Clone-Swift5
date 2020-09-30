//
//  NotificationLikeEventTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/29/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

protocol NotificationLikeEventTableViewCellDelegate : AnyObject {
    func didTapFollowUnFollowButton(_ model : UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate : NotificationLikeEventTableViewCellDelegate?
    
    var model : UserNotification?
    
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
    
    private let followButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubview(profileImageView)
        addSubview(label)
        followButton.addTarget(self, action: #selector(didTapFollowUnFollowButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowUnFollowButton(){
        delegate?.didTapFollowUnFollowButton(model!)
    }
    
    func configure(with model : UserNotification) {
        self.model = model
        switch model.type {
        case .like:
            break
        default:
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
