//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/25/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

protocol nameProfileInfoHeaderCollectionReusableDelegate : AnyObject {
    func profileHeaderDidTapPostsButton(_ header : ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header : ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollwingButton(_ header : ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header : ProfileInfoHeaderCollectionReusableView)
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        backgroundColor = .systemYellow
        clipsToBounds = true
        addSubview()
        addActionTarget()
    }
    
    var delegate : nameProfileInfoHeaderCollectionReusableDelegate?
    
    private func addSubview(){
        addSubview(profilePhotoImageView)
        addSubview(postsButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    
    private func addActionTarget(){
        postsButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollwingButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let photoImageSize = width / 4
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: photoImageSize, height: photoImageSize).integral
        profilePhotoImageView.layer.cornerRadius = photoImageSize/2
        let buttonHeight = photoImageSize / 2
        let buttonWidth = photoImageSize - 5
        let labelHeight = 40.0
        postsButton.frame = CGRect(x: profilePhotoImageView.right , y: 5, width: buttonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: postsButton.right , y: 5, width: buttonWidth, height: buttonHeight).integral
        followersButton.frame = CGRect(x: followingButton.right , y: 5, width: buttonWidth, height: buttonHeight).integral
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right , y: postsButton.bottom, width: width - width/4 - 10, height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5, y: 5 + profilePhotoImageView.bottom , width: width - 10, height: CGFloat(labelHeight)).integral
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom , width: width - 10, height: CGFloat(labelHeight)).integral
    }
    
    private let profilePhotoImageView  : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor  = UIColor.red
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let postsButton  : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.yellow
        button.setTitle("posts", for: .normal)
        return button
    }()
    
    private let followingButton  : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.purple
        button.setTitle("following", for: .normal)
        return button
    }()
    
    private let followersButton  : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.green
        button.setTitle("follower", for: .normal)
        return button
    }()
    
    private let editProfileButton  : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("Edit you profile", for: .normal)
        return button
    }()
    
    private let nameLabel  : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.cyan
        label.numberOfLines = 1
        label.text = "Đăng Tibbers"
        return label
    }()
    
    private let bioLabel  : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.systemPink
        label.numberOfLines = 1
        label.text = "Thành công là kết quả của sự cố gắng 􀊶"
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
    
    @objc func didTapPostsButton(){
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc func didTapFollowersButton(){
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc func didTapFollwingButton(){
        delegate?.profileHeaderDidTapFollwingButton(self)
    }
    @objc func didTapEditProfileButton(){
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
