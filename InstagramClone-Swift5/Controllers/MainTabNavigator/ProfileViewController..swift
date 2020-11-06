//
//  ProfileViewController..swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import ParallaxHeader

class ProfileViewController: UIViewController {
    var collectionView : UICollectionView?
    var userPosts : [UserPostModel] = [UserPostModel]()
    var user : User?
    var bioTextHeight : CGFloat? = nil
    var defaultHeaderHeight : CGFloat = 0
    var headerHeight : CGFloat = 0
    var myPost : [UserPostModel] = [UserPostModel]()
    var prefPost : [UserPostModel] = [UserPostModel]()
    var buttonBarHeight : CGFloat? = 60
    
    var goingUp: Bool?
    var childScrollingDownDueToParent = false
    let headerView = ProfileInfoHeaderViewController(isCurrentUser : true)
    let tabView : ProfileTabsHeaderViewController = {
        let t = ProfileTabsHeaderViewController()
        return t
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor.white
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ConfigureNavigationTabBar()
        configure()
        tabView.delegateTab = self
        headerView.view.frame = CGRect(x: 0, y: 0, width: view.width, height: headerHeight)
        headerView.delegate = self
        self.scrollView.backgroundColor  = UIColor.green
        self.scrollView.delegate = self
        self.scrollView.parallaxHeader.view = headerView.view // You can set the parallax header view from a nib.
        self.scrollView.parallaxHeader.height = headerHeight // desired hieght or hight of the xib file
        self.scrollView.parallaxHeader.mode = .centerFill
        self.scrollView.parallaxHeader.minimumHeight = view.safeAreaInsets.top
        self.scrollView.delegate = self
        self.scrollView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            print("progress : \(parallaxHeader.progress)")
        }
        view.addGestureRecognizer(scrollView.panGestureRecognizer)
        view.addSubview(scrollView)
    }
    
    func configure() {
        let currentUser = User(username: "Tibb", bio: "Singer/Actress 🇻🇳\nFounder of @gom.entertainment\n📸 @filmbychipu\nDreams Don't Work Unless You Do. \nhttps://www.instagram.com/chipupu/", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Tibb", last: "K"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://i.pinimg.com/originals/0b/8f/b1/0b8fb17b3bb7caba4b30123a74bd21fb.jpg")!)
        user = currentUser
        defaultHeaderHeight = view.width / 3.8 + 50
        bioTextHeight = String(currentUser.bio).height(withConstrainedWidth: view.width, font: UIFont.systemFont(ofSize: config.fontSizeDefault))
        headerHeight = defaultHeaderHeight + bioTextHeight!
        headerView.configure(user: currentUser, bioTextHeight: bioTextHeight ?? 20)
        
        let user = User(username: "Đăng Tibbers", bio: "@ĐăngTibbers Love Swift Code", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://meohayaz.com/wp-content/uploads/2020/03/Tr%E1%BB%8Dn-b%E1%BB%99-nh%E1%BB%AFng-h%C3%ACnh-%E1%BA%A3nh-%C4%91%E1%BA%B9p-girl-xinh-cho-%C4%91i%E1%BB%87n-tho%E1%BA%A1i.jpg")!)
        
        let postLike = [PostLike(username: "thien dang", postIdentifier: "1233123"),PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123")]
        let post = UserPostModel(postType: .photo, thumbnailImage: [
            URL(string:"https://i.guim.co.uk/img/media/03caad21d019a429e66df852c31d57872b79ceb9/0_14_2603_1562/master/2603.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1de70e809602b3bc061b0536caa8c517")!,
            URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/09/d6/c2/ca/blue-wahle-mirissa.jpg")!,
            URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSfpLg2Rk6GE9xxK9VrExfap-dW5uy8EX-GSA&usqp=CAU")!
        ],postURL: URL(string: "https://www.youtube.com/")!, caption: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", likeCout: postLike , comments: [], createDate: Date(), targetUser: [], owner: user, bookmarked: false, liked: false)
        
        for _ in 0..<20 {
            myPost.append(post)
        }
        for _ in 0..<10 {
            prefPost.append(post)
        }
        buttonBarHeight = 60
        tabView.configure(myPost: myPost, prefPost: prefPost , buttonBarHeight : buttonBarHeight!)
    }
    
    override func viewDidLayoutSubviews() {
        //        scrollView.frame = view.bounds
        //        let itemForRow = CGFloat(CGFloat(myPost.count)/3).rounded(.up)
        //        //        let myPostHeight = itemForRow * photoCollectionViewController.itemSize + (buttonBarHeight ?? 60) + photoCollectionViewController.footerHeight
        //        //        let myPrefHeight = itemForRow * photoCollectionViewController.itemSize + (buttonBarHeight ?? 60) + photoCollectionViewController.footerHeight
        //        tabView.view.frame = CGRect(x: 0, y: headerView.view.bottom + 2, width: view.width, height: itemForRow * photoCollectionViewController.itemSize + photoCollectionViewController.footerHeight + tabView.heightHeaderTabbar)
        //        scrollView.contentSize = CGSize(width: view.width, height: headerView.view.height + tabView.view.height + 10)
        //        tabView.view.frame = view.bounds
        
        let newFrame = CGRect(x: 0,y: view.safeAreaInsets.top, width: self.view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom) // scrollview's frame calculation
        let newFrameTabView = CGRect(x: 0,y: 0, width: newFrame.width, height: newFrame.height) // scrollview's frame calculation
        scrollView.frame = newFrame
        tabView.view.frame = newFrameTabView
        scrollView.contentSize = CGSize(width: newFrame.width, height: newFrame.height)
        scrollView.panGestureRecognizer.delaysTouchesBegan = true
        self.scrollView.addSubview(tabView.view)
        
    }
    
    func ConfigureNavigationTabBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left.square"), style: .done, target: self, action: #selector(onPressLogout))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func onPressLogout() -> Void {
        let vcSetting = SettingViewController()
        vcSetting.modalPresentationStyle = .fullScreen
        vcSetting.title = "Settings"
        self.navigationController?.pushViewController(vcSetting, animated: true)
    }
}

extension ProfileViewController : ProfileInfoHeaderCollectionReusableDelegate{
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderViewController) {
        collectionView?.scrollToItem(at: IndexPath(row : 0 , section : 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderViewController) {
        var data : [UserFollowRelationShip] = []
        for i in 0..<40 {
            data.append(UserFollowRelationShip(usename: "@Joe97", name: "Joe", type: i%2 == 0 ? .following : .not_follwing , avatar: URL(fileURLWithPath: "https://static.scientificamerican.com/sciam/cache/file/6D504A2A-D962-4A89-85AE348894386FAA_source.jpg")))
        }
        let vc  = ListViewController(data : data)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollwingButton(_ header: ProfileInfoHeaderViewController) {
        var data : [UserFollowRelationShip] = []
        for i in 0..<40 {
            data.append(UserFollowRelationShip(usename: "@Joe97", name: "Joe", type: i%2 == 0 ? .following : .not_follwing, avatar: URL(fileURLWithPath: "https://static.scientificamerican.com/sciam/cache/file/6D504A2A-D962-4A89-85AE348894386FAA_source.jpg")))
        }
        let vc  = ListViewController(data:data)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderViewController) {
        print("TAP EditProfile")
        let vc  = EditProfileViewController()
        vc.title = "Edit Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController : ProfileTabsHeaderDelegate, UIScrollViewDelegate {
    
    //onChangeTabBar
    func onChangeTab(collectionView: UICollectionView) {
        self.collectionView = collectionView
        if(scrollView.contentOffset.y >= 0.0){
            collectionView.isScrollEnabled = true
        }else{
            collectionView.isScrollEnabled = false
        }
    }
    
    func scrollViewDidInit(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func didTapImage(_ model: UserPostModel) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "PostViewController") as! PostViewController
        newViewController.initConfigure(model)
        self.present(newViewController, animated: true, completion: nil)
    }
    
    //scrollView child
    func scrollViewDidScroll(scrollView: UIScrollView, collectionView: UICollectionView) {
        //          print("scrollView child \(scrollView.contentOffset.y)")
        if(collectionView.contentOffset.y <= 0.0){
            collectionView.isScrollEnabled = false
        }else{
            collectionView.isScrollEnabled = true
        }
    }
    
    //scrollView parent
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print("scrollView parent \(scrollView.contentOffset.y)")
        if(scrollView.contentOffset.y >= 0.0){
            self.collectionView?.isScrollEnabled = true
        }else{
            self.collectionView?.isScrollEnabled = false
        }
    }
    
    func profileTabsHeaderDidTapGriButtonTab(_ header: ProfileTabsHeaderViewController) {
        //reload data
    }
    
    func profileTabsHeaderDidTapTaggedButtonTab(_ header: ProfileTabsHeaderViewController) {
        //reload data
        
    }
}
