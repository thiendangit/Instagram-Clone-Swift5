//
//  NotificationFollowEventTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/29/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate : AnyObject {
    func didTapFollowUnFollowButton(_ model : UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate : NotificationFollowEventTableViewCellDelegate?
    
    var model : UserNotification?
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "bell")
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "@Tibb is followed you.!"
        return label
    }()
    
    private let followButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubview(profileImageView)
        addSubview(label)
        addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowUnFollowButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowUnFollowButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model)
    }
    
    func configure(model : UserNotification) {
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            switch state {
            case .following:
                followButton.setTitle("Unfollow", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
            case .not_follwing:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.gray, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.layer.borderColor = UIColor.link.cgColor
            }
        }
        label.text = "@Tibb is followed you.!"
        profileImageView.sd_setImage(with: model.user.thumbnailImage , completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profileSize = contentView.height - 6
        profileImageView.frame = CGRect(x: 3, y: 3, width: profileSize, height: profileSize)
        profileImageView.layer.cornerRadius = profileSize/2.0
        let followButtonHeight = contentView.height - 4
        label.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - followButtonHeight*1.5 + 10 - profileImageView.width, height: contentView.height)
        followButton.frame = CGRect(x: label.right + 3, y: 70/2-(followButtonHeight/2-4)/2, width: followButtonHeight, height: followButtonHeight/2 - 4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.sd_setImage(with: nil, completed: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
