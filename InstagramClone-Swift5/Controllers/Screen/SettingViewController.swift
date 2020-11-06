//
//  SettingViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import SafariServices

struct SettingCellModal {
    let title : String
    let Handler : (() -> Void)
}

class SettingViewController : UIViewController {
    
    private var data = [[SettingCellModal]]()
    
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    enum URLType {
        case Term,Privacy,Help
    }
    
    func handleUrl(type : URLType) {
        var urlString : URL?
        switch type {
        case .Term:
            urlString = URL(string:"https://help.instagram.com/581066165581870?%3F__hstc=20629287.2f3f33a24b44870ec4a577029c49e44b.1585353600091.1585353600092.1585353600093.1&__hssc=192971698.1.1585872000174&__hsfp=3071927421&_ga=2.67531538.2090819656.1556546632-504387059.1544696302")
        case .Privacy :
            urlString = URL(string:"https://help.instagram.com/325135857663734/?helpref=hc_fnav&bc[0]=Tr%E1%BB%A3%20gi%C3%BAp%20c%E1%BB%A7a%20Instagram&bc[1]=Trung%20t%C3%A2m%20an%20to%C3%A0n%20v%C3%A0%20quy%E1%BB%81n%20ri%C3%AAng%20t%C6%B0")
        case .Help:
            urlString = URL(string:"https://help.instagram.com/325135857663734/?helpref=hc_fnav&bc[0]=Tr%E1%BB%A3%20gi%C3%BAp%20c%E1%BB%A7a%20Instagram&bc[1]=Trung%20t%C3%A2m%20an%20to%C3%A0n%20v%C3%A0%20quy%E1%BB%81n%20ri%C3%AAng%20t%C6%B0")
        }
        
        guard let url = urlString else {return}
        present(SFSafariViewController(url: url),animated: true)
    }
    
    func onPressLogout() {
        AuthManager.shared.Logout(){ success , error in
            if(success){
                let vcLogin = LoginViewController()
                vcLogin.modalPresentationStyle = .fullScreen
                self.present(vcLogin, animated: true){
                    self.navigationController?.popToRootViewController(animated: false)
                    self.tabBarController?.selectedIndex = 0
                }
                print("is logout : \(success)")
            }else{
                print("can't logout : \(error!)")
            }
        }
    }
    
    func onPressEditProfile() {
        let vc = EditProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC,animated: true)
    }
    
    func onPressInviteFriend() { 
        
    }
    
    func onPressSaveOriginalPost() {
        
    }
    
    func onPressTermsOfServices() {
        handleUrl(type : .Term)
    }
    
    func onPressPrivacyPolicy() {
        handleUrl(type : .Privacy)
    }
    
    func onPressHelpFeedBack() {
        handleUrl(type : .Help)
    }
    
    private func configureModal() {
        
        data.append([
            SettingCellModal(title : "Edit Profile")  {
                [weak self] in
                self?.onPressEditProfile()
            },
            SettingCellModal(title : "Invite Friend")  {
                [weak self] in
                self?.onPressInviteFriend()
            },
            SettingCellModal(title : "Save Original Posts")  {
                [weak self] in
                self?.onPressSaveOriginalPost()
            }
        ])
        
        data.append([
            SettingCellModal(title : "Terms of Services")  {
                [weak self] in
                self?.onPressTermsOfServices()
            },
            SettingCellModal(title : "Privacy policy")  {
                [weak self] in
                self?.onPressPrivacyPolicy()
            },
            SettingCellModal(title : "Help / Feedback")  {
                [weak self] in
                self?.onPressHelpFeedBack()
            }
        ])
        
        data.append([SettingCellModal(title : "Log out")  {
            [weak self] in
            self?.onPressLogout()
            }])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureModal()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        print("\(data)")
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].Handler()
    }
}
