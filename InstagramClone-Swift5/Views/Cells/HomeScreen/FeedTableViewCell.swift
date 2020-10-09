//
//  FeedTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/7/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import ReadMoreTextView
import Lottie
import SnapKit

protocol FeedTableViewCellDelegate {
    func didTapImageAndUserName()
    func didTapMoreButton()
    func didTapHeartButton()
    func didTapMessageButton()
    func didTapSendButton()
    func didTapTagButton()
    func didSeeMoreMessage()
    func didTapImageAndUserNameFooter()
    func didTapHeartFooterButton()
    func didTapHandFooterButton()
    func didTapAddFooterButton()
    func didTapSeeMoreMessage()
}

class FeedTableViewCell: UITableViewCell {
    
    var delegate : FeedTableViewCellDelegate?
    var post : Post?
    var animationView = AnimationView(name: "heart")
    //headerPost
    @IBOutlet weak var profileSectionView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    //ImageView
    @IBOutlet weak var imageCollectionView: UICollectionView!{
        didSet{
            imageCollectionView.delegate = self
            imageCollectionView.dataSource = self
        }
    }
    //Actions View
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!{
        didSet{
            pageControl.numberOfPages = post?.postDetails.thumbnailImage.count ?? 0
            pageControl.pageIndicatorTintColor = .systemGray
            pageControl.currentPageIndicatorTintColor = .systemBlue
        }
    }
    //detais Post View
    @IBOutlet weak var numberOfLikeLbl: UILabel!
    @IBOutlet weak var readMoreTextView: ReadMoreTextView!
    @IBOutlet weak var seeMoreMessageLbl: UILabel!{
        didSet{
            //            let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapFunction))
            seeMoreMessageLbl.isUserInteractionEnabled = true
            //            seeMoreMessageLbl.addGestureRecognizer(tap)
        }
    }
    
    //footer Post View
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var imageFooterView: UIImageView!
    @IBOutlet weak var heartFooterButton: UIImageView!
    @IBOutlet weak var handFooterButton: UIImageView!
    @IBOutlet weak var moreCommentFooterButton: UIButton!
    @IBOutlet weak var plusFooterButton: UIImageView!
    @IBOutlet weak var timePostLbl: UILabel!
    
    //configure cell
    func configure(post : Post){
        print("post : \(post)")
        self.post = post
        let post = post.postDetails
        profileImageView.sd_setImage(with: post.owner.thumbnailImage, completed: nil)
        imageFooterView.sd_setImage(with: post.owner.thumbnailImage, completed: nil)
        userNameLbl.text = post.owner.username
        checkLike()
        pageControl.numberOfPages = post.thumbnailImage.count
        numberOfLikeLbl.text = "\(post.likeCout.count) lượt thích"
        setUpReadMoreText(text : "\(String(describing: post.caption))")
    }
    
    func checkLike(){
        if post!.postDetails.liked == true {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .systemRed
        }else{
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = UIColor.black
            
        }
    }
    
    func setUpReadMoreText(text : String){
        let textAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        let readMoreTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)
        ]
        let readLessTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)
        ]
        readMoreTextView.attributedText = NSAttributedString(string: text, attributes: textAttributes)
        readMoreTextView.attributedReadMoreText = NSAttributedString(string: "... Read more", attributes: readMoreTextAttributes)
        readMoreTextView.attributedReadLessText = NSAttributedString(string: " Read less", attributes: readLessTextAttributes)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpImageAndUserNameLbl()
        setUpActionsView()
        setUpDetailsPost()
        setUpFooterPost()
        setUpImagePost()
        readMoreTextView.shouldTrim = true
    }
    
    func setUpImagePost(){
        animationView.animationSpeed = 1.2
        animationView.loopMode = .playOnce
        self.contentView.addSubview(animationView)
        animationView.snp.makeConstraints({ make in
            make.height.width.equalTo(110)
            make.center.equalTo(imageCollectionView)
        })
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(animateHeart))
        let doubleTapAnimationView = UITapGestureRecognizer(target: self, action: #selector(animateHeart))
        doubleTap.numberOfTapsRequired = 2
        doubleTapAnimationView.numberOfTapsRequired = 2
        imageCollectionView.isUserInteractionEnabled = true
        imageCollectionView.addGestureRecognizer(doubleTap)
        animationView.isUserInteractionEnabled = true
        animationView.addGestureRecognizer(doubleTapAnimationView)
    }
    
    @objc func animateHeart(){
        UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
        animationView.play()
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        heartButton.tintColor = .systemRed
        post!.postDetails.liked = true
    }
    
    func setUpImageAndUserNameLbl(){
        let tapProfileGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageAndUserName))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageAndUserName))
        //profileImage
        profileImageView.layer.cornerRadius = profileSectionView.frame.height / 2
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapProfileGestureRecognizer)
        //userNameLbl
        userNameLbl.isUserInteractionEnabled = true
        userNameLbl.addGestureRecognizer(tapGestureRecognizer)
        //moreButton
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    func setUpActionsView() {
        heartButton.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(didTapMessageButton), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(didTapTagButton), for: .touchUpInside)
    }
    
    func setUpDetailsPost(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSeeMoreMessage))
        //seeMoreMessageLbl
        seeMoreMessageLbl.isUserInteractionEnabled = true
        seeMoreMessageLbl.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setUpFooterPost(){
        imageFooterView.layer.cornerRadius = 30 / 2
        let tapImageFooterGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageAndUserNameFooter))
        let tapMoreCommentGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageAndUserNameFooter))
        //imageFooterView
        imageFooterView.isUserInteractionEnabled = true
        imageFooterView.addGestureRecognizer(tapImageFooterGestureRecognizer)
        //moreCommentFooterButton
        moreCommentFooterButton.isUserInteractionEnabled = true
        moreCommentFooterButton.addGestureRecognizer(tapMoreCommentGestureRecognizer)
        //heartFooterButton
        let tapHeartGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHeartFooterButton))
        heartFooterButton.isUserInteractionEnabled = true
        heartFooterButton.addGestureRecognizer(tapHeartGestureRecognizer)
        //HandFooterButton
        let tapHandGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapHandFooterButton))
        handFooterButton.isUserInteractionEnabled = true
        handFooterButton.addGestureRecognizer(tapHandGestureRecognizer)
        //AddFooterButton
        let tapAddGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAddFooterButton))
        plusFooterButton.isUserInteractionEnabled = true
        plusFooterButton.addGestureRecognizer(tapAddGestureRecognizer)
    }
    
    @objc func didTapImageAndUserName(){
        print("didTapImageAndUserName")
        delegate?.didTapImageAndUserName()
    }
    
    @objc func didTapMoreButton(){
        print("didTapMoreButton")
        delegate?.didTapMoreButton()
    }
    
    @objc func didTapHeartButton(){
        print("didTapHeartButton")
        likePost()
        delegate?.didTapHeartButton()
    }
    
    @objc func didTapMessageButton(){
        print("didTapMessageButton")
        delegate?.didTapMessageButton()
    }
    
    @objc func didTapSendButton(){
        print("didTapSendButton")
        delegate?.didTapSendButton()
    }
    
    @objc func didTapTagButton(){
        print("didTapTagButton")
        delegate?.didTapTagButton()
    }
    
    @objc func didTapImageAndUserNameFooter(){
        print("didTapImageAndUserNameFooter")
        delegate?.didTapImageAndUserNameFooter()
    }
    
    @objc func didTapHeartFooterButton(){
        print("didTapHeartFooterButton")
        delegate?.didTapHeartFooterButton()
    }
    
    @objc func didTapHandFooterButton(){
        print("didTapHandFooterButton")
        delegate?.didTapHandFooterButton()
    }
    
    @objc func didTapAddFooterButton(){
        print("didTapAddFooterButton")
        delegate?.didTapAddFooterButton()
    }
    
    @objc func didTapSeeMoreMessage(){
        print("didTapSeeMoreMessage")
        delegate?.didTapSeeMoreMessage()
    }
    
    
    @objc func likePost(){
        if !post!.postDetails.liked {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .systemRed
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = UIColor.black
        }
        post!.postDetails.liked = !post!.postDetails.liked
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        readMoreTextView.onSizeChange = {_ in }
        readMoreTextView.shouldTrim = true
        imageView?.sd_setImage(with: nil, completed: nil)
        profileImageView.isUserInteractionEnabled = false
        //userNameLbl
        userNameLbl.isUserInteractionEnabled = false
        //imageFooterView
        imageFooterView.isUserInteractionEnabled = false
        //moreCommentFooterButton
        moreCommentFooterButton.isUserInteractionEnabled = false
        //heartFooterButton
        heartFooterButton.isUserInteractionEnabled = false
        //HandFooterButton
        handFooterButton.isUserInteractionEnabled = false
        //AddFooterButton
        plusFooterButton.isUserInteractionEnabled = false
        profileImageView.sd_setImage(with: nil, completed: nil)
        imageFooterView.sd_setImage(with: nil, completed: nil)
        userNameLbl.text = nil
        numberOfLikeLbl.text = nil
        readMoreTextView.attributedText = nil
    }
}

extension FeedTableViewCell:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (post?.postDetails.thumbnailImage.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionView", for: indexPath) as! FeedImageCollectionViewCell
        cell.configure(url : (post?.postDetails.thumbnailImage[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.width, height: 388)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView : UICollectionView, layout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt: Int) -> CGFloat{
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = (scrollView.contentOffset.x) / self.frame.width
        self.pageControl.currentPage = Int(page + 0.2)
    }
}
