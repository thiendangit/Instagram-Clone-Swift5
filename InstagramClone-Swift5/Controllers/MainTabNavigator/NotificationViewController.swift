//
//  NotificationViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private var models = [UserNotification]()
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        title = "Notification"
        view.addSubview(tableView)
        //        view.addSubview(noNotificationView)
        //        view.addSubview(spinner)
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
    }
    
    private func fetchNotification(){
        for x in 1..<100 {
             let user = User(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://lh3.googleusercontent.com/proxy/VowhQs2NjLKuCp0u_EhKwlzS-YAH-NLX1jERqihl7Y92vdSYM4mBjdQTD4HhhgWZkSrGZCAgn8WXwITtXoT76-nP-A_AxTBbE8qE7wGejKHPCwFJ2Xk")!)
            let post = UserPostModel(postType: .photo, thumbnailImage: [URL(string: "https://banner2.cleanpng.com/20180713/tpv/kisspng-computer-icons-x-mark-clip-art-old-letters-5b4860c9c00b11.6777014015314700257866.jpg")!],postURL: URL(string: "https://www.youtube.com/")!, caption: "Have a good day !", likeCout: [], comments: [], createDate: Date(), targetUser: [], owner: user, bookmarked: false, liked: false)
            let model = UserNotification(type: x%2 != 0 ? .like(post : post) : .follow(state : .not_follwing), text: "test", user: User(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://lh3.googleusercontent.com/proxy/VowhQs2NjLKuCp0u_EhKwlzS-YAH-NLX1jERqihl7Y92vdSYM4mBjdQTD4HhhgWZkSrGZCAgn8WXwITtXoT76-nP-A_AxTBbE8qE7wGejKHPCwFJ2Xk")!))
            models.append(model)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/2.8)
        noNotificationView.center = view.center
        spinner.frame = CGRect(x: 0,y: 0,width: 100,height: 100)
        spinner.center = view.center
    }
}

extension NotificationViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(model : model)
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            cell.configure(model: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Call any function
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension NotificationViewController : NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(_ model: UserNotification) {
        print(model)
        switch model.type {
        case .like(let post):
            let vcPost = PostViewController(model:post)
            vcPost.title = post.postType.rawValue
            vcPost.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vcPost, animated: true)
        default:
            break
        }
    }
}

extension NotificationViewController : NotificationFollowEventTableViewCellDelegate{
    func didTapFollowUnFollowButton(_ model: UserNotification) {
        print(model)
    }
}
