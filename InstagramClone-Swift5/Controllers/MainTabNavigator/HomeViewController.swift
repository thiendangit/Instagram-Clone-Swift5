//
//  HomeViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import FirebaseAuth
import ReadMoreTextView

class HomeViewController: UIViewController {
    
    var feedRenderModels = [Post]()
    
    var storyRenderModels = [User]()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var expandedCells = Set<Int>()
    
    @objc func didTapLeftButton(){
        print("didTapLeftButton")
    }
    
    @objc func didTapRightButton(){
        print("didTapRightButton")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        configure()
        setUpNavigationBarItem()
    }
    
    func setUpNavigationBarItem() {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SplashIcon")
        imageView.contentMode = .scaleAspectFill
        self.navigationItem.titleView = imageView
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .done, target: self, action: #selector(didTapLeftButton))
        leftItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "paperplane"), style: .done, target: self, action: #selector(didTapRightButton))
        rightItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightItem
    }
    
    private func configure(){
        //        let x = 1
        var comments = [PostComment]()
        
        let currentUser = User(username: "Tibb", bio: "@Tibb Love Swift Code", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Tibb", last: "K"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://i.pinimg.com/originals/0b/8f/b1/0b8fb17b3bb7caba4b30123a74bd21fb.jpg")!)
        
        
        let user = User(username: "Đăng Tibbers", bio: "@ĐăngTibbers Love Swift Code", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://meohayaz.com/wp-content/uploads/2020/03/Tr%E1%BB%8Dn-b%E1%BB%99-nh%E1%BB%AFng-h%C3%ACnh-%E1%BA%A3nh-%C4%91%E1%BA%B9p-girl-xinh-cho-%C4%91i%E1%BB%87n-tho%E1%BA%A1i.jpg")!)
        
        let postLike = [PostLike(username: "thien dang", postIdentifier: "1233123"),PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123")]
        
        let post = UserModal(postType: .photo, thumbnailImage: [
            URL(string:"https://i.guim.co.uk/img/media/03caad21d019a429e66df852c31d57872b79ceb9/0_14_2603_1562/master/2603.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1de70e809602b3bc061b0536caa8c517")!,
            URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/09/d6/c2/ca/blue-wahle-mirissa.jpg")!,
            URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSfpLg2Rk6GE9xxK9VrExfap-dW5uy8EX-GSA&usqp=CAU")!
        ],postURL: URL(string: "https://www.youtube.com/")!, caption: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", likeCout: postLike , comments: [], createDate: Date(), targetUser: [], owner: user, bookmarked: false, liked: false)
        
        for i in 0..<1 {
            comments.append(PostComment(identifier: "test\(i)", username: "Jacky Love", text: "Dịch văn bản: Dịch giữa 103 ngôn ngữ bằng cách nhập dữ liệu", createDate: Date(), likes: []))
        }
        for _ in 0...5{
            feedRenderModels.append(Post(postDetails: post, comments: comments))
        }
        
        storyRenderModels.append(currentUser)
        
        for _ in 0...10{
            storyRenderModels.append(user)
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkIsLoggined()
    }
    
    func checkIsLoggined(){
        if(Auth.auth().currentUser == nil){
            //neu chua dang nhap thi chuyen sang man hinh dang nhap
            print("Move to Login")
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            present(loginVc, animated: false, completion: nil)
        }
    }
}

extension HomeViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedRenderModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.row)
        readMoreTextView.setNeedsUpdateTrim()
        readMoreTextView.layoutIfNeeded()
        cell.configure(post: feedRenderModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        print(cell as Any)
        readMoreTextView.onSizeChange = { [unowned tableView, unowned self] r in
            print("r : \(r)")
            let point = tableView.convert(r.bounds.origin, from: r)
            print("point : \(point)")
            guard let indexPath = tableView.indexPathForRow(at: point) else { return }
            if r.shouldTrim {
                self.expandedCells.remove(indexPath.row)
            } else {
                self.expandedCells.insert(indexPath.row)
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.selectionStyle = .none
        //        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        //        readMoreTextView.shouldTrim = !readMoreTextView.shouldTrim
    }
}

extension HomeViewController : FeedTableViewCellDelegate{
    func didTapImageAndUserName() {
        
    }
    
    func didTapMoreButton() {
        
    }
    
    func didTapHeartButton() {
        
    }
    
    func didTapMessageButton() {
        
    }
    
    func didTapSendButton() {
        
    }
    
    func didTapTagButton() {
        
    }
    
    func didSeeMoreMessage() {
        
    }
    
    func didTapImageAndUserNameFooter() {
        
    }
    
    func didTapHeartFooterButton() {
        
    }
    
    func didTapHandFooterButton() {
        
    }
    
    func didTapAddFooterButton() {
        
    }
    
    func didTapSeeMoreMessage(){
        
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! StoryCollectionViewCell
        if(indexPath.row == 0){
            cell.configurecCurrentUser(user: storyRenderModels[indexPath.row])
        }else{
            cell.configure(user: storyRenderModels[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 7, bottom: 0, right: 5)
    }
    
    
    
}


