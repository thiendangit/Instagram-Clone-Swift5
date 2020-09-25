//
//  EditProfileViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    @objc func saveButtonTabbar() {
        //save info to Database
    }
    
    @objc func cancelButtonTabbar() {
        //back
    }
    
    func onPressEditProfile() {
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
        ], target: EditProfileViewController(), preferredStyle: .actionSheet)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target:self, action: #selector(saveButtonTabbar))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target:self, action: #selector(cancelButtonTabbar))
        view.backgroundColor =  UIColor.white
        // Do any additional setup after loading the view.
    }
}
