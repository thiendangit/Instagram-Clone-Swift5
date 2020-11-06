//
//  NotificationViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private var models : [[AnyObject]] = []
    
    private var tileLabel : [String] = ["Today", "This Week", "This Month", "Suggestion for you"]
    
    let headerHeight : CGFloat = 50
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        return tableView
    }()
    
    private let noNotificationView = NoNotificationView()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.style = .large
        spinner.tintColor = .black
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotification()
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.isHidden = true
        spinner.startAnimating()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        //        view.addSubview(noNotificationView)
        //        view.addSubview(spinner)
        tableView.register(NotificationNewTableViewCell.self, forCellReuseIdentifier: NotificationNewTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundView = nil
        tableView.backgroundColor = .white
        
        
    }
    
    private func fetchNotification(){
        let user = User(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://lh3.googleusercontent.com/proxy/VowhQs2NjLKuCp0u_EhKwlzS-YAH-NLX1jERqihl7Y92vdSYM4mBjdQTD4HhhgWZkSrGZCAgn8WXwITtXoT76-nP-A_AxTBbE8qE7wGejKHPCwFJ2Xk")!)
        let post = UserPostModel(postType: .photo, thumbnailImage: [URL(string: "https://banner2.cleanpng.com/20180713/tpv/kisspng-computer-icons-x-mark-clip-art-old-letters-5b4860c9c00b11.6777014015314700257866.jpg")!],postURL: URL(string: "https://www.youtube.com/")!, caption: "Have a good day !", likeCout: [], comments: [], createDate: Date(), targetUser: [], owner: user, bookmarked: false, liked: false)
        let userFriend = SuggestionFriend(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSifT5e7FEzF4wPsfG6Z8gKXLcAm2FfhCfdIw&usqp=CAU")!, relation: .not_follwing)
        var userNotificationFollow : [UserNotification] = []
        for x in 1...3 {
            let suggestionFriend = SuggestionFriend(username: x%2 == 0 ? "JackyLove" : x%3 == 0 ? "LuffySama" : "Thuan thu 2", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string:
                x%2 == 0 ? "https://i.pinimg.com/originals/fc/ef/1e/fcef1e0a2a7803d0f901251f116af525.jpg" : x%3 == 0 ? "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQnVJg8lvk9dHlKAG2A61N_vjrqasqPvEc7JQ&usqp=CAU" : "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ_SKyrWFt7XrfAr2eLPR-HIBDHFJ6nlu_wQw&usqp=CAU")!, relation: .not_follwing)
            userNotificationFollow.append(UserNotification(type: x%2 == 0 ? .follow(state : .not_follwing) : x%3 == 0 ? .like(post : post) : .suggestFollow(suggestionFriendList : [userFriend]), text: "test", user: [suggestionFriend,suggestionFriend,suggestionFriend,suggestionFriend,suggestionFriend]))
        }
        let today = userNotificationFollow
        let thisWeek = userNotificationFollow
        let thisMonth = userNotificationFollow
        let suggestionFriend = [userFriend,userFriend,userFriend,userFriend,userFriend,userFriend,userFriend]
        models.append(today as [AnyObject])
        models.append(thisWeek as [AnyObject])
        models.append(thisMonth as [AnyObject])
        models.append(suggestionFriend as [AnyObject])
    }
    
    override func viewDidLayoutSubviews() {
        tableView.backgroundView = nil
        super.viewDidLayoutSubviews()
        //        tableView.frame = view.bounds
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/2.8)
        noNotificationView.center = view.center
        spinner.frame = CGRect(x: 0,y: 0,width: 100,height: 100)
        spinner.center = view.center
        
        //Two Golden lines for resizing the table view cells
        tableView.estimatedRowHeight = 50;
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none;
        // Table View AutoLayout constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 12)
        self.view.addConstraint(topConstraint)
        
        let leftConstraint = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        self.view.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        self.view.addConstraint(rightConstraint)
        
        let bottoConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(bottoConstraint)
    }
}

extension NotificationViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: headerHeight))
        header.backgroundColor = .white
        let label = UILabel()
        label.text = tileLabel[section]
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.frame = CGRect(x: 5, y: 5, width: header.width-5, height: header.height-5)
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .white
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section as AnyObject !== 3 as AnyObject){
            return UITableView.automaticDimension
        }else{
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = (models[indexPath.section][indexPath.row])
        if(indexPath.section != 3){
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationNewTableViewCell.identifier, for: indexPath) as! NotificationNewTableViewCell
            cell.configure(model: model as! UserNotification)
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            cell.configure(model: model as! SuggestionFriend)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Call any function
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NotificationViewController : NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(_ model: UserNotification) {
        print(model)
        let vc  = UserFollowingController()
        vc.title = "Explorer Everyone"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NotificationViewController : NotificationFollowEventTableViewCellDelegate{
    func didTapFollowUnFollowButton(_ model: SuggestionFriend) {
        //call api confirm follow
        print(model)
    }
}
