//
//  EditProfileViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

public struct EditProfileFormModal {
    let lable : String
    let placeHolder : String
    var value : String? = ""
    
    init(lable : String , placeHolder : String , value : String) {
        self.lable = lable
        self.placeHolder = placeHolder
        self.value = value
    }
}

class EditProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var datas = [[EditProfileFormModal]]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = datas[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier , for: indexPath) as! FormTableViewCell
        cell.configure(formData: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //some code
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if(section == 2){
            return "Information private"
        }
        return nil
    }
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier )
        return tableView
    }()
    
    @objc func saveButtonTabbar() {
        //save info to Database
        dismiss(animated: true, completion: {
            
        })
    }
    
    @objc func cancelButtonTabbar() {
        //back
        dismiss(animated: true, completion: {
                  
              })
    }
    
    @objc func onPressEditProfile() {
        Utils.shared.AlertCustom(title: "Profile Picture", message: "Change profile picture", arrayActions: [
            UIAlertAction(title: "Take a Photo",style: .default , handler: {
                _ in
                
            }),
            UIAlertAction(title: "Choose from Library",style: .default, handler: {
                _ in
                
            }),
            UIAlertAction(title: "Cancel",style: .destructive , handler: {
                _ in
                
            })
        ], target: self, preferredStyle: .actionSheet)
    }
    
    func createHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4))
        let size = header.height/1.5
        let photoButton = UIButton(frame: CGRect(x: (view.width-size)/2, y: (header.height-size)/2, width: size, height: size))
        photoButton.layer.borderWidth = 1
        photoButton.layer.cornerRadius = size/2
        photoButton.layer.masksToBounds = true
        photoButton.addTarget(self, action: #selector(onPressEditProfile), for: .touchUpInside)
        photoButton.setBackgroundImage(UIImage(systemName: "person.circle", withConfiguration: .none), for: .normal)
        photoButton.layer.borderColor = UIColor.systemBlue.cgColor
        header.addSubview(photoButton)
        return header
    }
    
    func configureEditProfileFormModal(){
        //Name,username,Bio
        let lableUsers = ["Name", "UserName", "Bio"]
        for lableUser in lableUsers {
            datas.append([EditProfileFormModal(lable: lableUser, placeHolder: "Please Enter \(lableUser)...", value: "")])
        }
        //Email , Phone , Gender
        let lableUserInfos = ["Email", "Phone", "Gender"]
        for lableUserInfo in lableUserInfos {
            datas.append([EditProfileFormModal(lable: lableUserInfo, placeHolder: "Please Enter \(lableUserInfo)...", value: "")])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target:self, action: #selector(saveButtonTabbar))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target:self, action: #selector(cancelButtonTabbar))
        view.backgroundColor =  UIColor.white
        configureEditProfileFormModal()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createHeaderView()
        view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension EditProfileViewController : FormTableViewCellDelegate {
    func handleOnChangeValue(_ cell: FormTableViewCell, data: EditProfileFormModal){
        print("label : \(data.lable)")
    }
}
