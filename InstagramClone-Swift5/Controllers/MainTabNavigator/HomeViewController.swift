//
//  HomeViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import FirebaseAuth

struct HomeRenderViewModel {
    let header : PostRenderViewModel
    let primaryContent : PostRenderViewModel
    let actions : PostRenderViewModel
    let comments : PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    var feedRenderModels = [HomeRenderViewModel]()
    
    var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configure()
    }
    
    private func configure(){
        let x = 1
        var comments = [PostComment]()
        let user = User(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://lh3.googleusercontent.com/proxy/VowhQs2NjLKuCp0u_EhKwlzS-YAH-NLX1jERqihl7Y92vdSYM4mBjdQTD4HhhgWZkSrGZCAgn8WXwITtXoT76-nP-A_AxTBbE8qE7wGejKHPCwFJ2Xk")!)
        
        let post = UserModal(postType: .photo, thumbnailImage: URL(string: "https://banner2.cleanpng.com/20180713/tpv/kisspng-computer-icons-x-mark-clip-art-old-letters-5b4860c9c00b11.6777014015314700257866.jpg")!,postURL: URL(string: "https://www.youtube.com/")!, caption: "Have a good day !", likeCout: [], comments: [], createDate: Date(), targetUser: [], owner: user)
        let model = UserNotification(type: x%2 != 0 ? .like(post : post) : .follow(state : .not_follwing), text: "test", user: User(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://lh3.googleusercontent.com/proxy/VowhQs2NjLKuCp0u_EhKwlzS-YAH-NLX1jERqihl7Y92vdSYM4mBjdQTD4HhhgWZkSrGZCAgn8WXwITtXoT76-nP-A_AxTBbE8qE7wGejKHPCwFJ2Xk")!))
        for i in 0..<1 {
            comments.append(PostComment(identifier: "test\(i)", username: "Jacky Love", text: "Dịch văn bản: Dịch giữa 103 ngôn ngữ bằng cách nhập dữ liệu", createDate: Date(), likes: []))
        }
        for _ in 0...1{
            feedRenderModels.append(HomeRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)), primaryContent: PostRenderViewModel(renderType: .primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(provider: comments))))
        }
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = section
        var model : HomeRenderViewModel
        if(sec == 0 ){
            model = feedRenderModels[0]
        }else{
            let position1 = sec % 4 == 0 ? sec/4 : ((sec - (sec % 4))/4)
            print("position \(position1)")
            let position = sec/4
            model = feedRenderModels[position]
        }
        let subsection = sec%4
        if(subsection == 0){
            //header
            return 1
        }else if (subsection == 1){
            //post
            return 1
        }else if (subsection == 2){
            //actions
            return 1
        }else if (subsection == 3){
            //commnet
            let commentModels = model.comments
            switch commentModels.renderType {
            case .comments(let comment):
                return comment.count > 2 ? 2 : comment.count
            default :
                break
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sec = indexPath.section
        var model : HomeRenderViewModel
        if(sec == 0 ){
            model = feedRenderModels[0]
        }else{
            //let position = sec % 4 == 0 ? sec/4 : ((sec - (sec % 4))/4)
            let position = sec/4
            model = feedRenderModels[position]
        }
        
        let subsection = sec%4
        if(subsection == 0){
            //header
            let headerMode = model.header
            switch headerMode.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            default:  return UITableViewCell()
            }
        }else if (subsection == 1){
            //post
            let headerMode = model.primaryContent
            switch headerMode.renderType {
            case .primaryContent(let post) :
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            default:  return UITableViewCell()
            }
        }else if (subsection == 2){
            //actions
            let headerMode = model.actions
            switch headerMode.renderType {
            case .actions(let action) :
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
                
                return cell
            default:  return UITableViewCell()
            }
        }else if (subsection == 3){
            //commnet
            let commentModels = model.comments
            switch commentModels.renderType {
            case .comments(let comment):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                
                return cell
            case .actions(_) , .header(_) , .primaryContent(_) : return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subsection	= indexPath.section % 4
        if(subsection == 0){
            //header
            return 70
        }else if (subsection == 1){
            //post
            return tableView.width
        }else if (subsection == 2){
            //actions
            return 60
        }else if (subsection == 3){
            //commnet
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subsection = section % 4
        return subsection == 3 ? 70 : 0
    }
}
