//
//  UserFollowTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/29/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation
import UIKit

protocol UserFollowTableCellDelegate : AnyObject {
    func UserFollowTableDidTapFollowingButton(_ model : UserFollowRelationShip)
}

class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"
    
    var model : UserFollowRelationShip?
    
    var delegate : UserFollowTableCellDelegate?
    
    private let profileImageView : UIImageView = {
        let imageView  = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        return imageView
    }()
    private let nameLabel : UILabel = {
        let label  = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "Joe"
        return label
    }()
    
    private let userLabel : UILabel = {
        let label  = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .gray
        label.text = "@Joe97"
        return label
    }()
    
    private let followButton : UIButton = {
        let button  = UIButton()
        button.setTitle("Followers", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubView()
        addTarget()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = height/1.2
        profileImageView.frame = CGRect(x: 3, y: 3, width: imageSize, height: imageSize)
        profileImageView.layer.cornerRadius = imageSize/2.0
        let labelHeight = contentView.height/2
        nameLabel.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - width/5 * 2.5 - 5, height: labelHeight)
        userLabel.frame = CGRect(x: profileImageView.right + 5, y: nameLabel.bottom + 1, width: contentView.width - width/5*2.5, height: labelHeight)
        let buttonWidth = width/5 * 1.5 - 5
        followButton.frame = CGRect(x: nameLabel.right + 5, y: 5, width: buttonWidth, height: labelHeight * 2 - 10)
    }
    
    func addTarget() {
        followButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowingButton() {
        guard let model = model else {
            print("error")
            return
        }
        delegate?.UserFollowTableDidTapFollowingButton(model)
    }
    
    func addSubView() {
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(userLabel)
        addSubview(followButton)
    }
    
    func configure(with model : UserFollowRelationShip) {
        self.model = model
        profileImageView.sd_setImage(with: model.avatar, completed: nil)
        nameLabel.text = model.name
        userLabel.text = model.usename
        var title = ""
        switch model.type {
        case .following:
            title = "unfollow"
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
            followButton.backgroundColor = UIColor.systemBackground
            followButton.setTitleColor(.label, for: .normal)
        default:
            title = "follow"
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
            followButton.backgroundColor = .link
            followButton.setTitleColor(.white, for: .normal)
        }
        followButton.setTitle(title, for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        userLabel.text = nil
        followButton.layer.borderWidth = 0
        followButton.layer.borderColor = nil
        followButton.backgroundColor = nil
        followButton.setTitleColor(.none, for: .normal)
        followButton.setTitle(nil, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
