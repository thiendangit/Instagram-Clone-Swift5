//
//  ExploreViewController..swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//


import UIKit
import AVKit
import AVFoundation

class ExploreViewController: UIViewController {
    var headerSearchCollectionDataSource : [headerItemExploreModal] = [headerItemExploreModal]()
    var imageSearchCollectionDataSource : [UserPostModel] = [UserPostModel]()
    @IBOutlet weak var headerSearchView: headerSearchView!
    @IBOutlet weak var collectionViewHeader: UICollectionView!{
        didSet{
            collectionViewHeader.delegate = self
            collectionViewHeader.dataSource = self
        }
    }
    
    @IBOutlet weak var collectionViewImage: UICollectionView!{
        didSet{
            collectionViewImage.delegate = self
            collectionViewImage.dataSource = self
        }
    }
    
    static func configureCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (index, env) -> NSCollectionLayoutSection? in
            
            //ITEM
            let widthHeightDefault : CGFloat = 1.0
            //configure image large = 2/3 screen
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3),
                                                  heightDimension: .fractionalHeight(widthHeightDefault))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //configure image sup of image large
            let verticalStackSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthHeightDefault),
                                                           heightDimension: .fractionalHeight(widthHeightDefault))
            let verticalStackItem = NSCollectionLayoutItem(layoutSize: verticalStackSize)
            verticalStackItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //configure 3 image footer = 0.3 width & height
            let tripletItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthHeightDefault),
                                                         heightDimension: .fractionalWidth(0.3))
            let tripletItem = NSCollectionLayoutItem(layoutSize: tripletItemSize)
            tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            //GROUP
            //configure group of image sup of image large = 1/3 screen
            let verticalStackGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                heightDimension: .fractionalHeight(widthHeightDefault))
            let verticalStackGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalStackGroupSize, subitem: verticalStackItem , count: 2)
            //configure group of 3 image footer = 0.3 width
            let tripletHorizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthHeightDefault),heightDimension: .fractionalWidth(0.3))
            let tripletHorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: tripletHorizontalGroupSize, subitem: tripletItem, count: 3)
            //configure group of image large & image sup of image large
            let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthHeightDefault),heightDimension: .fractionalWidth(0.7))
            let horizontalGroup_first = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [verticalStackGroup, item])
            let horizontalGroup_second = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [item, verticalStackGroup])
            // configure group of image large & image sup of image large & 3 image footer
            let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthHeightDefault), heightDimension: .fractionalWidth(2.6))
            let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                                 subitems: [horizontalGroup_first,tripletHorizontalGroup,tripletHorizontalGroup,horizontalGroup_second,tripletHorizontalGroup,tripletHorizontalGroup])
            
            //SECTIONS
            let section = NSCollectionLayoutSection(group: verticalGroup)
            //use this line if you want to horizontal list
            //section.orthogonalScrollingBehavior = .groupPagingCentered
            
            //RETURN
            return section
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibHeaderSearchCell = UINib(nibName: "headerSearchCollectionViewCell", bundle:nil)
        collectionViewHeader.register(nibHeaderSearchCell, forCellWithReuseIdentifier: headerSearchCollectionViewCell.identifier)
        let nibImageSearchCell = UINib(nibName: "imageSearchCollectionViewCell", bundle:nil)
        collectionViewImage.register(nibImageSearchCell, forCellWithReuseIdentifier: imageSearchCollectionViewCell.identifier)
        collectionViewImage.collectionViewLayout = ExploreViewController.configureCompositionalLayout()
        //        if let flowLayout = collectionViewImage?.collectionViewLayout as? UICollectionViewFlowLayout {
        //            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //        }
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "tv", label: " IGTV"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "music.house", label: " Store"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "Travel"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "Structure"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "Decor"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "art"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "cuisine"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "Structure"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "Decor"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "art"))
        headerSearchCollectionDataSource.append(headerItemExploreModal(image: "", label: "cuisine"))
        
        let user = User(username: "Đăng Tibbers", bio: "@ĐăngTibbers Love Swift Code", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://meohayaz.com/wp-content/uploads/2020/03/Tr%E1%BB%8Dn-b%E1%BB%99-nh%E1%BB%AFng-h%C3%ACnh-%E1%BA%A3nh-%C4%91%E1%BA%B9p-girl-xinh-cho-%C4%91i%E1%BB%87n-tho%E1%BA%A1i.jpg")!)
        
        let postLike = [PostLike(username: "thien dang", postIdentifier: "1233123"),PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123"),
                        PostLike(username: "thien dang", postIdentifier: "1233123")]
        let post = UserPostModel(postType: .video, thumbnailImage: [
            URL(string:"https://i.guim.co.uk/img/media/03caad21d019a429e66df852c31d57872b79ceb9/0_14_2603_1562/master/2603.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1de70e809602b3bc061b0536caa8c517")!,
            URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/09/d6/c2/ca/blue-wahle-mirissa.jpg")!,
            URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSfpLg2Rk6GE9xxK9VrExfap-dW5uy8EX-GSA&usqp=CAU")!
        ],postURL: URL(string: "https://www.youtube.com/")!, caption: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", likeCout: postLike , comments: [], createDate: Date(), targetUser: [], owner: user, bookmarked: false, liked: false , videoURL: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.mp4")
        let post1 = UserPostModel(postType: .video, thumbnailImage: [
            URL(string:"https://i.guim.co.uk/img/media/03caad21d019a429e66df852c31d57872b79ceb9/0_14_2603_1562/master/2603.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1de70e809602b3bc061b0536caa8c517")!,
            URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/09/d6/c2/ca/blue-wahle-mirissa.jpg")!,
            URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSfpLg2Rk6GE9xxK9VrExfap-dW5uy8EX-GSA&usqp=CAU")!
        ],postURL: URL(string: "https://www.youtube.com/")!, caption: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", likeCout: postLike , comments: [], createDate: Date(), targetUser: [], owner: user, bookmarked: false, liked: false , videoURL: "https://www.radiantmediaplayer.com/media/big-buck-bunny-360p.mp4")
        let post2 = UserPostModel(postType: .photo, thumbnailImage: [
            URL(string:"https://i.guim.co.uk/img/media/03caad21d019a429e66df852c31d57872b79ceb9/0_14_2603_1562/master/2603.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=1de70e809602b3bc061b0536caa8c517")!,
            URL(string: "https://media-cdn.tripadvisor.com/media/photo-s/09/d6/c2/ca/blue-wahle-mirissa.jpg")!,
            URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSfpLg2Rk6GE9xxK9VrExfap-dW5uy8EX-GSA&usqp=CAU")!
        ],postURL: URL(string: "https://www.youtube.com/")!, caption: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", likeCout: postLike , comments: [], createDate: Date(), targetUser: [], owner: user, bookmarked: false, liked: false , videoURL: "https://www.radiantmediaplayer.com/media/big-buck-bunny-360p.mp4")
        for x in 0..<40 {
            if(x == 2 || x == 20 || x == 38){
                imageSearchCollectionDataSource.append(post)
            }else if (x == 9 || x == 27){
                imageSearchCollectionDataSource.append(post1)
            }else{
                imageSearchCollectionDataSource.append(post2)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerSearchView.configure()
    }
    
}

extension ExploreViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.collectionViewHeader){
            return headerSearchCollectionDataSource.count
        }else{
            return imageSearchCollectionDataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.collectionViewHeader){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerSearchCollectionViewCell.identifier , for: indexPath) as! headerSearchCollectionViewCell
            cell.configure(model: headerSearchCollectionDataSource[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageSearchCollectionViewCell.identifier , for: indexPath) as! imageSearchCollectionViewCell
            cell.configure(model: imageSearchCollectionDataSource[indexPath.row])
            return cell
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(collectionView == self.collectionViewImage){
            let visibleCells = collectionView.visibleCells;
            for visibleCell in visibleCells {
                if(visibleCell.frame.size.width > view.width/2){
                    print("visibleCell : \(visibleCell)")
                    let visibleCell_temp = visibleCell as! imageSearchCollectionViewCell
                    visibleCell_temp.playerView.player?.play()
                }
            }
        }
    }
    
        func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let visibleCells = collectionView.visibleCells;
            for visibleCell in visibleCells {
                if(visibleCell.frame.size.width > view.width/2){
                    print("visibleCell : \(visibleCell)")
                    let visibleCell_temp = visibleCell as! imageSearchCollectionViewCell
                    visibleCell_temp.playerView.player?.pause();
//                    visibleCell_temp.playerView.player = nil;
                }
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(collectionView == self.collectionViewHeader){
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }else{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        collectionViewImage.visibleCells.forEach { cell in
            // TODO: write logic to start the video after it ends scrolling
            print("cell \(cell)")
        }
    }
}

