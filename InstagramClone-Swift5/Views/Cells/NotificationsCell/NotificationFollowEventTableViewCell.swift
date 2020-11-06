//
//  NotificationFollowEventTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/29/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import SnapKit

protocol NotificationFollowEventTableViewCellDelegate : AnyObject {
    func didTapFollowUnFollowButton(_ model : SuggestionFriend)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate : NotificationFollowEventTableViewCellDelegate?
    
    var model : SuggestionFriend?
    
    var isFollow : Bool = false
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "bell")
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.text = "thuytienofficial"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let sortName : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Tibbers"
        return label
    }()
    
    private let labelMore : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.text = "Gợi ý cho bạn"
        return label
    }()
    
    private let followButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        return button
    }()
    
    private let deleteButton : UIButton = {
        let originalImage = UIImage(systemName: "xmark")
        let tintedImage = originalImage?.withRenderingMode(.alwaysTemplate)
        
        let button = UIButton()
        button.clipsToBounds = true
        button.setImage(tintedImage, for: .normal)
        button.tintColor = UIColor.lightGray //change color of icon
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(sortName)
        addSubview(labelMore)
        addSubview(followButton)
        addSubview(deleteButton)
        configureInit()
        followButton.addTarget(self, action: #selector(didTapFollowUnFollowButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowUnFollowButton(){
        
        guard let model = model else {
            return
        }
        animate(followButton)
        delegate?.didTapFollowUnFollowButton(model)
    }
    
    func animate(_ sender: UIButton) {
        let deleteButtonWidth = UIScreen.main.bounds.size.width*0.3/6 + 5
        let buttonSize: CGRect = sender.frame
        let originXbutton = buttonSize.origin.x
        let originYbutton = buttonSize.origin.y
        
        let originWidthbutton = buttonSize.size.width
        let originHeightbutton = buttonSize.size.height
        
        if(isFollow == false){
            UIView.animate(withDuration: 0.2,  animations: {
                sender.frame = CGRect(x: originXbutton, y: originYbutton, width: originWidthbutton + deleteButtonWidth, height: originHeightbutton - 3)
            }, completion:{ finished in
                sender.setTitle("Unfollow", for: .normal)
                sender.setTitleColor(.black, for: .normal)
                sender.layer.borderWidth = 1
                sender.layer.borderColor = UIColor.black.cgColor
                sender.backgroundColor  = .white
                self.deleteButton.isHidden = true
                self.isFollow = true
            })
        }else{
            UIView.animate(withDuration: 0.2,  animations: {
                sender.frame = CGRect(x: originXbutton, y: originYbutton, width: originWidthbutton - deleteButtonWidth, height: originHeightbutton + 3)
            }, completion:{ finished in
                sender.setTitle("Follow", for: .normal)
                sender.setTitleColor(.white, for: .normal)
                sender.layer.borderWidth = 1
                sender.layer.borderColor = UIColor.link.cgColor
                sender.backgroundColor = .systemBlue
                self.deleteButton.isHidden = false
                self.isFollow = false
                
            })
        }
    }
    
    func reUseButtonFollow(_ sender: UIButton) {
        isFollow = false
        self.deleteButton.isHidden = false
        let followButtonWidth = UIScreen.main.bounds.size.width*1.5/6
        let followButtonHeight = contentView.height/3
        sender.frame = CGRect(x: nameLabel.right + 2, y: contentView.height/4-(followButtonHeight/2-4), width: followButtonWidth, height: followButtonHeight)
        sender.setTitle("Follow", for: .normal)
        sender.setTitleColor(.white, for: .normal)
        sender.layer.borderWidth = 1
        sender.layer.borderColor = UIColor.link.cgColor
        sender.backgroundColor = .systemBlue
    }
    
    func configure(model : SuggestionFriend) {
        self.model = model
        switch model.relation {
        case .following:
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        case .not_follwing:
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.link.cgColor
            followButton.backgroundColor = .systemBlue
        }
        
        nameLabel.text = model.username
        sortName.text = model.name.first + " " + model.name.last
        labelMore.text = "Suggest for you"
        profileImageView.sd_setImage(with: model.thumbnailImage, completed: nil)
        //        profileImageView.sd_setImage(with: model.user[0].thumbnailImage , completed: nil)
    }
    
    func configureInit(){
        print("contentView.height \(contentView.height)")
        let profileSize = UIScreen.main.bounds.size.width/6
        let labelSize = UIScreen.main.bounds.size.width*2.7/6
        let followButtonWidth = UIScreen.main.bounds.size.width*1.5/6
        let deleteButtonWidth = UIScreen.main.bounds.size.width*0.3/6
        profileImageView.frame = CGRect(x: (UIScreen.main.bounds.size.width*0.5/6)/5, y: 3, width: profileSize, height: profileSize)
        profileImageView.layer.cornerRadius = profileSize/2.0
        let followButtonHeight = contentView.height/1.5
        nameLabel.frame = CGRect(x: profileImageView.right + (UIScreen.main.bounds.size.width*0.5/6)/5, y: 5, width: labelSize, height: profileSize/3)
        sortName.frame = CGRect(x: profileImageView.right + (UIScreen.main.bounds.size.width*0.5/6)/5, y: nameLabel.bottom, width: labelSize, height: profileSize/3)
        labelMore.frame = CGRect(x: profileImageView.right + (UIScreen.main.bounds.size.width*0.5/6)/5, y: sortName.bottom, width: labelSize, height: profileSize/3)
        followButton.frame = CGRect(x: nameLabel.right + 2, y: contentView.height/2-(followButtonHeight/2-4), width: followButtonWidth, height: followButtonHeight * 1.2)
        followButton.layer.cornerRadius = 5
        deleteButton.frame = CGRect(x: followButton.right + (UIScreen.main.bounds.size.width*0.5/6)/9, y: contentView.height/2+2, width: deleteButtonWidth, height: followButtonHeight/2 - 4)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        nameLabel.text = nil
        sortName.text = nil
        labelMore.text = nil
        profileImageView.sd_setImage(with: nil, completed: nil)
        reUseButtonFollow(followButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
