//
//  NotificationLikeEventTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/29/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate : AnyObject {
    func didTapRelatedPostButton(_ model : UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate : NotificationLikeEventTableViewCellDelegate?
    
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
        label.text = "@Joe like your photo.!"
        return label
    }()
    
    private let postButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .red
        button.tintColor = .black
        button.setBackgroundImage(UIImage(systemName: "rectangle.split.3x3"), for: .normal)
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubview(profileImageView)
        addSubview(label)
        addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapFollowUnFollowButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowUnFollowButton(){
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model)
    }
    
    func configure(model : UserNotification) {
        self.model = model
        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            print(thumbnail)
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
        default:
            
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.thumbnailImage , completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profileSize = contentView.height - 6
        profileImageView.frame = CGRect(x: 3, y: 3, width: profileSize, height: profileSize)
        profileImageView.layer.cornerRadius = profileSize/2.0
        let postSize = contentView.height - 4
        label.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - postSize - profileImageView.width-6, height: contentView.height)
        postButton.frame = CGRect(x: profileImageView.width + label.width + 15, y: 70/2-(postSize/2-4)/2, width: postSize/2, height: postSize/2 - 4)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //        postButton.setTitle(nil, for: .normal)
        //        postButton.setBackgroundImage(nil, for: .normal)
        //        postButton.backgroundColor = nil
        //        postButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
        profileImageView.backgroundColor = nil
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
