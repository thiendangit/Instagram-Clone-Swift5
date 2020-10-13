//
//  ProfileViewController..swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var CollectionView : UICollectionView?
    var userPosts : [UserModal] = [UserModal]()
    var user : User?
    var bioTextHeight : CGFloat? = nil
    var defaultHeaderHeight : CGFloat = 0
    var headerHeight : CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ConfigureNavigationTabBar()
        let sizeItem  = (view.width - 4) / 3
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: sizeItem , height: sizeItem)
        CollectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        CollectionView?.contentInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        guard let collectionView = CollectionView else {
            return
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.register(ProfileTabsHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsHeaderCollectionReusableView.identifier)
        collectionView.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        view.addSubview(collectionView)
        configure()
    }
    
    func configure() {
        let currentUser = User(username: "Tibb", bio: "Singer/Actress 🇻🇳\nFounder of @gom.entertainment\n📸 @filmbychipu\nDreams Don't Work Unless You Do. \nhttps://www.instagram.com/chipupu/", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Tibb", last: "K"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://i.pinimg.com/originals/0b/8f/b1/0b8fb17b3bb7caba4b30123a74bd21fb.jpg")!)
        user = currentUser
        defaultHeaderHeight = view.height/5.5
        bioTextHeight = String(currentUser.bio).height(withConstrainedWidth: view.width, font: UIFont.systemFont(ofSize: config.fontSizeDefault))
        headerHeight = defaultHeaderHeight + bioTextHeight!
        
    }
    override func viewDidLayoutSubviews() {
        CollectionView?.frame = view.bounds
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

extension ProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 0
        }
        //        return userPosts.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(debug: "whaleShark")
        //        cell.configure(with: model)
        cell.contentView.backgroundColor = .systemBlue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemDidSellected = userPosts[indexPath.row]
        let vcPostView = PostViewController(model: itemDidSellected)
        vcPostView.modalPresentationStyle = .fullScreen
        vcPostView.title = "Post"
        vcPostView.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vcPostView, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            //footer
            return  UICollectionReusableView()
        }
        //tabs
        if(indexPath.section == 1 ){
            let tabCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileTabsHeaderCollectionReusableView
            tabCell.delegate = self
            return tabCell
        }
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        headerCell.delegate = self
        guard let user = user else {
            return UICollectionReusableView()
        }
        bioTextHeight = String(user.bio).height(withConstrainedWidth: view.width, font: UIFont.systemFont(ofSize: config.fontSizeDefault))
        headerCell.configure(user: user, bioTextHeight : bioTextHeight ?? 20)
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if(section == 0){
            return CGSize(width: view.width, height: headerHeight)
        }
        //size of tabs
        return CGSize(width: view.width, height : 50)
    }
    
}

extension ProfileViewController : nameProfileInfoHeaderCollectionReusableDelegate{
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        CollectionView?.scrollToItem(at: IndexPath(row : 0 , section : 1), at: .top, animated: true)
    }
    
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var data : [UserFollowRelationShip] = []
        for i in 0..<40 {
            data.append(UserFollowRelationShip(usename: "@Joe97", name: "Joe", type: i%2 == 0 ? .following : .not_follwing , avatar: URL(fileURLWithPath: "https://static.scientificamerican.com/sciam/cache/file/6D504A2A-D962-4A89-85AE348894386FAA_source.jpg")))
        }
        let vc  = ListViewController(data : data)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapFollwingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var data : [UserFollowRelationShip] = []
        for i in 0..<40 {
            data.append(UserFollowRelationShip(usename: "@Joe97", name: "Joe", type: i%2 == 0 ? .following : .not_follwing, avatar: URL(fileURLWithPath: "https://static.scientificamerican.com/sciam/cache/file/6D504A2A-D962-4A89-85AE348894386FAA_source.jpg")))
        }
        let vc  = ListViewController(data:data)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc  = EditProfileViewController()
        vc.title = "Edit Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileViewController : ProfileTabsHeaderCollectionReusableDelegate {
    func profileTabsHeaderDidTapGriButtonTab(_ header: ProfileTabsHeaderCollectionReusableView) {
        //reload data
        
    }
    
    func profileTabsHeaderDidTapTaggedButtonTab(_ header: ProfileTabsHeaderCollectionReusableView) {
        //reload data
        
    }
    
    
}
