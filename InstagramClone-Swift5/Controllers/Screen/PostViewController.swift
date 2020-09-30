//
//  PostViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

enum PostRenderType{
    case header(provider : User)
    case primaryContent(provider : UserModal)
    case actions(provider : String)
    case comments(provider : [PostComment])
}

public struct PostRenderViewModel {
    let renderType : PostRenderType
    
}

class PostViewController: UIViewController {
    
    private var model : UserModal?
    
    private var renderModel = [PostRenderViewModel]()
    
    init(model : UserModal?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        guard let model = model else {
            return
        }
        // case .header(_):
        renderModel.append(PostRenderViewModel(renderType: .header(provider: model.owner)))
        //case .comments(_):
        var comments : [PostComment] = model.comments
        for i in 0..<4 {
            comments.append(PostComment(identifier: "test\(i)", username: "Jacky Love", text: "Dịch văn bản: Dịch giữa 103 ngôn ngữ bằng cách nhập dữ liệu", createDate: Date(), likes: []))
        }
        renderModel.append(PostRenderViewModel(renderType: .comments(provider: comments)))
        //case .actions(_):
        renderModel.append(PostRenderViewModel(renderType: .actions(provider: "")))
        // case .primaryContent(_):
        renderModel.append(PostRenderViewModel(renderType: .primaryContent(provider: model)))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        view.addSubview(tableView)
        configure()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension PostViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModel[section].renderType {
        case .header(_):
            return 1
        case .comments(let comment):
            return comment.count > 4 ? comment.count : comment.count
        case .actions(_):
            return 1
        case .primaryContent(_):
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModel[indexPath.section]
        switch model.renderType {
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            
            return cell
        case .primaryContent(let content):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            
            return cell
        case .actions(let comment):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
            
            return cell
        case .comments(let comment):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch renderModel[indexPath.section].renderType {
        case .header(_):
            return 60
        case .comments(_):
            return 50
        case .actions(_):
            return 70
        case .primaryContent(_):
            return tableView.width
        }
    }
    
    
}
