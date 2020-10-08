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

struct HomeRenderViewModel {
    let header : PostRenderViewModel
    let primaryContent : PostRenderViewModel
    let actions : PostRenderViewModel
    let comments : PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    var feedRenderModels = [HomeRenderViewModel]()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
        }
    }
    var expandedCells = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configure(){
        //        let x = 1
        var comments = [PostComment]()
        let user = User(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://lh3.googleusercontent.com/proxy/VowhQs2NjLKuCp0u_EhKwlzS-YAH-NLX1jERqihl7Y92vdSYM4mBjdQTD4HhhgWZkSrGZCAgn8WXwITtXoT76-nP-A_AxTBbE8qE7wGejKHPCwFJ2Xk")!)
        
        let post = UserModal(postType: .photo, thumbnailImage: URL(string: "https://banner2.cleanpng.com/20180713/tpv/kisspng-computer-icons-x-mark-clip-art-old-letters-5b4860c9c00b11.6777014015314700257866.jpg")!,postURL: URL(string: "https://www.youtube.com/")!, caption: "Have a good day !", likeCout: [], comments: [], createDate: Date(), targetUser: [], owner: user)
        //        let model = UserNotification(type: x%2 != 0 ? .like(post : post) : .follow(state : .not_follwing), text: "test", user: User(username: "Jacky", bio: "@Jack Love The Game", counts: UserCount(followers: 300, following: 399, posts: 100), name: (first: "Jacky", last: "Love"), birthday: Date(), gender: .Male, joinDate:  Date(), thumbnailImage: URL(string: "https://lh3.googleusercontent.com/proxy/VowhQs2NjLKuCp0u_EhKwlzS-YAH-NLX1jERqihl7Y92vdSYM4mBjdQTD4HhhgWZkSrGZCAgn8WXwITtXoT76-nP-A_AxTBbE8qE7wGejKHPCwFJ2Xk")!))
        for i in 0..<1 {
            comments.append(PostComment(identifier: "test\(i)", username: "Jacky Love", text: "Dịch văn bản: Dịch giữa 103 ngôn ngữ bằng cách nhập dữ liệu", createDate: Date(), likes: []))
        }
        for _ in 0...1{
            feedRenderModels.append(HomeRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)), primaryContent: PostRenderViewModel(renderType: .primaryContent(provider: post)), actions: PostRenderViewModel(renderType: .actions(provider: "")), comments: PostRenderViewModel(renderType: .comments(provider: comments))))
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
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.row)
        readMoreTextView.setNeedsUpdateTrim()
        readMoreTextView.layoutIfNeeded()
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // Swift 4.2 onwards
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.selectionStyle = .none
        let readMoreTextView = cell.contentView.viewWithTag(1) as! ReadMoreTextView
        readMoreTextView.shouldTrim = !readMoreTextView.shouldTrim
    }
}
