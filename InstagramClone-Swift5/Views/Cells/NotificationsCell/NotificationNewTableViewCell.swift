//
//  NotificationNewTableViewCell.swift
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

class NotificationNewTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    weak var delegate : NotificationLikeEventTableViewCellDelegate?
    var profileSize: CGFloat = 0
    var model : UserNotification?
    var boxView = UIView()
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    func configureImageWithText(_ model : UserNotification, _ isShow2UserImage : Bool) -> Bool {
        let imageFollowSize = (profileSize/1.3)
        if(model.user.count > 1){
            if(isShow2UserImage == true){
                let imageView = UIImageView()
                imageView.clipsToBounds = true
                imageView.sd_setImage(with: model.user[0].thumbnailImage, completed: nil)
                let imageView1 = UIImageView()
                imageView1.clipsToBounds = true
                imageView1.sd_setImage(with: model.user[1].thumbnailImage, completed: nil)
                profileImageView.addSubview(imageView)
                profileImageView.addSubview(imageView1)
                imageView.snp.makeConstraints { (make) -> Void in
                    make.width.height.equalTo(imageFollowSize)
                    make.left.top.equalTo(0)
                }
                imageView.layer.cornerRadius = imageFollowSize/2
                imageView1.snp.makeConstraints { (make) -> Void in
                    make.width.height.equalTo(imageFollowSize)
                    make.left.top.equalTo(profileSize - imageFollowSize)
                }
                imageView1.layer.cornerRadius = imageFollowSize/2
            }else{
                profileImageView.sd_setImage(with: model.user[0].thumbnailImage, completed: nil)
            }
            return true
        }else{
            profileImageView.sd_setImage(with: model.user[0].thumbnailImage, completed: nil)
            return false
        }
    }
    
    func configure(model : UserNotification) {
        let localizedLabel = NSLocalizedString("notification_request_follow", comment: "")
        let localizedFollow = NSLocalizedString("follow", comment: "")
        let localizedNotiLike = NSLocalizedString("notification_like", comment: "")
        let localizedNotiFollow = NSLocalizedString("has_started_following_you", comment: "")
        
        self.model = model
        switch model.type {
        case .like(_):
            let flag = configureImageWithText(model, false)
            if(flag == true){
                textNoti.attributedText =  NSMutableAttributedString()
                    .bold(model.user[0].username + ", " + model.user[1].username + " ")
                    .normal(localizedNotiLike)
            }else{
                textNoti.attributedText =  NSMutableAttributedString()
                    .bold(model.user[0].username + " ")
                    .normal(localizedNotiLike + "photo")
            }
            return
        case .follow(_):
            let flag = configureImageWithText(model, true)
            if(flag == true){
                textNoti.attributedText =  NSMutableAttributedString()
                    .bold(model.user[0].username + ", " + model.user[1].username + " ")
                    .normal(localizedNotiFollow)
            }else{
                textNoti.attributedText =  NSMutableAttributedString()
                    .bold(model.user[0].username + " ")
                    .normal(localizedNotiFollow)
            }
            return
        case .suggestFollow(_):
            let flag = configureImageWithText(model, false)
            if(flag == true){
                textNoti.attributedText =  NSMutableAttributedString()
                    .normal(localizedFollow + " ")
                    .bold(model.user[0].username + ", " + model.user[1].username + " ")
                    .normal(localizedLabel)
            }else{
                textNoti.attributedText =  NSMutableAttributedString()
                    .normal(localizedFollow + " ")
                    .bold(model.user[0].username + " ")
                    .normal(localizedLabel)
            }
            return
        }
    }
    
    var textNoti = UILabel()
    
    @objc func boxDidTap(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("tap Box")
        delegate?.didTapRelatedPostButton(model!)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        boxView = UIView()
        boxView.backgroundColor = .brown
        self.contentView.backgroundColor = UIColor.clear
        boxView.backgroundColor = UIColor.white
        self.contentView.addSubview(boxView)
        boxView.layer.cornerRadius = 2.0;
        boxView.backgroundColor = UIColor.white;
        
        // BoxView created using autolayout constraints.
        boxView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: boxView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 2)
        self.contentView.addConstraint(topConstraint)
        
        let leftConstraint = NSLayoutConstraint(item: boxView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 2)
        self.contentView.addConstraint(leftConstraint)
        
        
        let rightConstraint = NSLayoutConstraint(item: boxView, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -2)
        self.contentView.addConstraint(rightConstraint)
        
        let bottoConstraint = NSLayoutConstraint(item: boxView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -2)
        self.contentView.addConstraint(bottoConstraint)
        profileSize = contentView.height
        
        //Here label added to boxView
        textNoti = UILabel()
        boxView.addSubview(profileImageView)
        boxView.addSubview(textNoti)
        textNoti.backgroundColor = .white
        textNoti.textColor = UIColor.black
        textNoti.numberOfLines = 0;
        textNoti.lineBreakMode = NSLineBreakMode.byWordWrapping;
        
        //profileImageView constraints
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let topProfileImageViewConstraint = NSLayoutConstraint(item: profileImageView, attribute: .top, relatedBy: .equal, toItem: boxView, attribute: .top, multiplier: 1, constant: 5)
        boxView.addConstraint(topProfileImageViewConstraint)
        
        let leftProfileImageViewConstraint = NSLayoutConstraint(item: profileImageView, attribute: .left, relatedBy: .equal, toItem: boxView, attribute: .left, multiplier: 1, constant: 2)
        boxView.addConstraint(leftProfileImageViewConstraint)
        
        
        let rightProfileImageViewConstraint = NSLayoutConstraint(item: profileImageView, attribute: .right, relatedBy: .equal, toItem: textNoti, attribute: .left, multiplier: 1, constant: -10)
        boxView.addConstraint(rightProfileImageViewConstraint)
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: contentView.height),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1.0)
        ])
        
        profileImageView.backgroundColor = .white
        profileImageView.layer.cornerRadius =  contentView.height/2
        
        // namelabel constraints
        textNoti.translatesAutoresizingMaskIntoConstraints = false
        
        let topLabelConstraint = NSLayoutConstraint(item: textNoti, attribute: .top, relatedBy: .equal, toItem: boxView, attribute: .top, multiplier: 1, constant: 2)
        boxView.addConstraint(topLabelConstraint)
        
        let leftLabelConstraint = NSLayoutConstraint(item: textNoti, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 0)
        boxView.addConstraint(leftLabelConstraint)
        
        
        let rightLabelConstraint = NSLayoutConstraint(item: textNoti, attribute: .right, relatedBy: .equal, toItem: boxView, attribute: .right, multiplier: 1, constant: -2)
        boxView.addConstraint(rightLabelConstraint)
        
        // Golden line which do all the resizing of cell stuff
        let bottomSeparatorCosntraint = NSLayoutConstraint(item: textNoti, attribute: .bottom, relatedBy: .equal, toItem: boxView, attribute: .bottom, multiplier: 1, constant: -2)
        boxView.addConstraint(bottomSeparatorCosntraint)
        
        NSLayoutConstraint.activate([textNoti.heightAnchor.constraint(greaterThanOrEqualToConstant: contentView.height)])
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boxDidTap(tapGestureRecognizer:)))
        boxView.isUserInteractionEnabled = true
        boxView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textNoti.text = ""
        profileImageView.sd_setImage(with: nil, completed: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
