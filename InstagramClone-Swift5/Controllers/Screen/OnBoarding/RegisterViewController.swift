//
//  RegisterViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private var userNameField : UITextField = {
        let field = UITextField()
        field.placeholder = "Your Username"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Utils.shared.textFileCornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private var emailField : UITextField = {
        let field = UITextField()
        field.placeholder = "Your Email"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Utils.shared.textFileCornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private var passwordField : UITextField = {
        let field = UITextField()
        field.placeholder = "Your password"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.returnKeyType = .go
        field.isSecureTextEntry = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Utils.shared.textFileCornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private var registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Utils.shared.textFileCornerRadius
        button.backgroundColor = .systemGray
        return button
    }()
    
    private var headerView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let imageBackgroundView = UIImageView(image: UIImage(named: "GradientInstagram"))
        view.addSubview(imageBackgroundView)
        return view
    }()
    
    func addSubView() -> Void {
        view.addSubview(userNameField)
        view.addSubview(passwordField)
        view.addSubview(emailField)
        view.addSubview(registerButton)
        view.addSubview(headerView)
    }
    
    func confiuerView () {
        headerView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: 200)
        userNameField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 20 ,
            width: view.width - 50,
            height: 56)
        emailField.frame = CGRect(
            x: 25,
            y: userNameField.bottom + 20 ,
            width: view.width - 50,
            height: 56)
        passwordField.frame = CGRect(
            x: 25,
            y: emailField.bottom + 10 ,
            width: view.width - 50,
            height: 56)
        registerButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 56)
    }
    
    func addTargets() -> Void {
        registerButton.addTarget(self, action: #selector(onPressRegisterButton), for: .touchUpInside)
    }
    
    @objc func onPressRegisterButton() -> Void {
        userNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        let userName = userNameField.text
        let email = emailField.text
        let passWord = passwordField.text
        if(userName == "" || email == "" || passWord == "" ){
            print("please enter!")
        }else {
            AuthManager.shared.registerNewUser(username: userName! , email: email!, password: passWord!){ success,error in
                if success {
                    //login success
                    self.dismiss(animated: true, completion: nil)
                    print("success \(success)")
                }else{
                    //login fail
                    Utils.shared.AlertCustom(title: "\(error!.localizedDescription)", message: "", arrayActions:
                        [UIAlertAction(title: "OK", style: .default, handler: nil),], target:self, preferredStyle: .alert)
                }
            }
        }
    }
    
    func confiuerHeader() -> Void {
        if headerView.subviews.count != 1 {
            return
        }
        guard let backgroudView = headerView.subviews.first else {
            return
        }
        backgroudView.frame = headerView.bounds
        let imageView = UIImageView(image: UIImage(named: "SplashIcon")!.withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.bottom, width: headerView.frame.width / 1.5, height: headerView.frame.width - headerView.safeAreaInsets.top )
        imageView.center = headerView.center
        imageView.tintColor = UIColor.white
        backgroudView.addSubview(imageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubView()
        confiuerView()
        addTargets()
        confiuerHeader()
        // Do any additional setup after loading the view.
    }
}

extension RegisterViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == userNameField || textField == emailField ){
            passwordField.becomeFirstResponder()
        } else{
            onPressRegisterButton()
        }
        return true
    }
}
