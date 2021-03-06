//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/25/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//
import Foundation
import UIKit

protocol ProfileInfoHeaderCollectionReusableDelegate : AnyObject {
    func profileHeaderDidTapPostsButton(_ header : ProfileInfoHeaderViewController)
    func profileHeaderDidTapFollowersButton(_ header : ProfileInfoHeaderViewController)
    func profileHeaderDidTapFollwingButton(_ header : ProfileInfoHeaderViewController)
    func profileHeaderDidTapEditProfileButton(_ header : ProfileInfoHeaderViewController)
}

class ProfileInfoHeaderViewController: UIViewController {
    static let identifier = "ProfileInfoHeaderCView"
    var isCurrentUser : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.clipsToBounds = true
        addSubview()
        addActionTarget()
    }
    
    init(isCurrentUser : Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isCurrentUser = isCurrentUser
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate : ProfileInfoHeaderCollectionReusableDelegate?
    
    private func addSubview(){
        view.addSubview(profilePhotoImageView)
        view.addSubview(postsButtonView)
        view.addSubview(followingButtonView)
        view.addSubview(followersButtonView)
        view.addSubview(editProfileButton)
        view.addSubview(nameLabel)
        view.addSubview(bioLabel)
    }
    
    private func addActionTarget(){
        postsButtonView.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        followingButtonView.addTarget(self, action: #selector(didTapFollwingButton), for: .touchUpInside)
        followersButtonView.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.width
        let photoImageSize = width / 3.8
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: photoImageSize, height: photoImageSize).integral
        profilePhotoImageView.layer.cornerRadius = photoImageSize/2
        let buttonHeight = photoImageSize / 2
        let buttonWidth = photoImageSize - 12
        let labelHeight = 20
        //posts
        postsButtonView.frame = CGRect(x: profilePhotoImageView.right , y: 5, width: buttonWidth, height: buttonHeight).integral
        postsButtonView.addSubview(postNumber)
        postsButtonView.addSubview(postLabel)
        postNumber.frame = CGRect(x: 2, y: 2, width: buttonWidth, height: buttonHeight/2).integral
        postLabel.frame = CGRect(x: 2, y: postNumber.bottom, width: buttonWidth, height: buttonHeight/2).integral
        //followings
        followingButtonView.frame = CGRect(x: postsButtonView.right , y: 5, width: buttonWidth, height: buttonHeight).integral
        followingButtonView.addSubview(followingNumber)
        followingButtonView.addSubview(followingLabel)
        followingNumber.frame = CGRect(x: 2, y: 2, width: buttonWidth, height: buttonHeight/2).integral
        followingLabel.frame = CGRect(x: 2, y: followingNumber.bottom, width: buttonWidth, height: buttonHeight/2).integral
        //followers
        followersButtonView.frame = CGRect(x: followingButtonView.right , y: 5, width: buttonWidth, height: buttonHeight).integral
        followersButtonView.addSubview(followersNumber)
        followersButtonView.addSubview(followersLabel)
        followersNumber.frame = CGRect(x: 2, y: 2, width: buttonWidth, height: buttonHeight/2).integral
        followersLabel.frame = CGRect(x: 2, y: followersNumber.bottom, width: buttonWidth, height: buttonHeight/2).integral
        
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right + (photoImageSize * 0.2) , y: postsButtonView.bottom + 5, width: width - photoImageSize * 1.4, height: buttonHeight/1.5).integral
        nameLabel.frame = CGRect(x: 5, y: 10 + profilePhotoImageView.bottom , width: width - 10, height: CGFloat(labelHeight)).integral
        let newHeightBioLabel = String(bioLabel.text!).height(withConstrainedWidth: UIScreen.main.bounds.width, font: UIFont.systemFont(ofSize: config.fontSizeBoldDefault))
        bioLabel.frame = CGRect(x: 5, y: nameLabel.bottom , width: width - 10, height: CGFloat(newHeightBioLabel)).integral
    }
    
    private let profilePhotoImageView  : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor  = UIColor.red
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.purple.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //posts
    
    private let postsButtonView  : UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let postNumber  : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: config.fontSizeBoldDefault)
        label.text = "0"
        return label
    }()
    
    private let postLabel  : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "Posts"
        return label
    }()
    
    //followings
    private let followingButtonView  : UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let followingNumber  : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: config.fontSizeBoldDefault)
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    private let followingLabel  : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "Followings"
        return label
    }()
    
    //followers
    private let followersButtonView  : UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private let followersNumber  : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: config.fontSizeBoldDefault)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    private let followersLabel  : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = "Followers"
        return label
    }()
    
    private let editProfileButton  : UIButton = {
        let button = UIButton()
        button.layer.borderWidth  = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitle("Edit you profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font =  UIFont.boldSystemFont(ofSize: config.fontSizeBoldDefault)
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let nameLabel  : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Đăng Tibbers"
        return label
    }()
    
    private let bioLabel  : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        label.text = "􀊶 Thành công là kết quả của sự cố gắng 􀊶"
        return label
    }()
    
    func configure(user : User , bioTextHeight : CGFloat) {
        //        profilePhotoImageView
        profilePhotoImageView.sd_setImage(with: user.thumbnailImage, completed: nil)
        //        postsButton
        postNumber.text = "\(user.counts.posts)"
        //        followingButton
        followingNumber.text = "\(user.counts.following)"
        //        followersButton
        followersNumber.text = "\(user.counts.followers)"
        //        nameLabel]
        nameLabel.text = user.username
        //        bioLabel
        bioLabel.text = user.bio
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        //        profilePhotoImageView
//        profilePhotoImageView.sd_setImage(with: nil, completed: nil)
//        //        postsButton
//        postNumber.text = nil
//        //        followingButton
//        followingNumber.text = nil
//        //        followersButton
//        followersNumber.text = nil
//        //        nameLabel]
//        nameLabel.text = nil
//        //        bioLabel
//        bioLabel.text = nil
//    }
//
    @objc func didTapPostsButton(){
        print("TAP Posts")
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc func didTapFollowersButton(){
        print("TAP Followers")
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc func didTapFollwingButton(){
        print("TAP Follwing")
        delegate?.profileHeaderDidTapFollwingButton(self)
    }
    @objc func didTapEditProfileButton(){
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
