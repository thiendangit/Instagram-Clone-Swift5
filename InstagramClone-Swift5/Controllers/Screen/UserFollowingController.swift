//
//  UserFollowingController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 11/6/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class UserFollowingController: UIViewController {
    
    private var models : [SuggestionFriend] = [SuggestionFriend]()
    
    let headerHeight : CGFloat = 50
    
    let tableView : UITableView = {
        let tableView = UITableView()
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
        view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = false
        //        view.addSubview(noNotificationView)
        //        view.addSubview(spinner)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundView = nil
        tableView.backgroundColor = .white
        
        
    }
    
    private func fetchNotification(){
        let user = User(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://lh3.googleusercontent.com/proxy/VowhQs2NjLKuCp0u_EhKwlzS-YAH-NLX1jERqihl7Y92vdSYM4mBjdQTD4HhhgWZkSrGZCAgn8WXwITtXoT76-nP-A_AxTBbE8qE7wGejKHPCwFJ2Xk")!)
        let userFriend = SuggestionFriend(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSifT5e7FEzF4wPsfG6Z8gKXLcAm2FfhCfdIw&usqp=CAU")!, relation: .not_follwing)
        for _ in 1...20 {
            models.append(userFriend)
        }
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
        let topConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: self.view.safeAreaInsets.top)
        self.view.addConstraint(topConstraint)
        
        let leftConstraint = NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        self.view.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        self.view.addConstraint(rightConstraint)
        
        let bottoConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraint(bottoConstraint)
    }
}

extension UserFollowingController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = (models[indexPath.row])
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
        cell.configure(model: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Call any function
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserFollowingController : NotificationFollowEventTableViewCellDelegate{
    func didTapFollowUnFollowButton(_ model: SuggestionFriend) {
        //call api confirm follow
        print(model)
    }
}
