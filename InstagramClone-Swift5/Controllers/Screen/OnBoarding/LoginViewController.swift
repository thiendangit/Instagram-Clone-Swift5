//
//  LoginViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    private var userNameField : UITextField = {
        let field = UITextField()
        field.placeholder = "Your Username or Email"
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
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Utils.shared.textFileCornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private var loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Utils.shared.textFileCornerRadius
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private var termButton : UIButton = {
        let button = UIButton()
        button.setTitle("Term of Service", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Utils.shared.textFileCornerRadius
        return button
    }()
    
    private var privacyButton : UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Utils.shared.textFileCornerRadius
        return button
    }()
    
    private var headerView : UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let imageBackgroundView = UIImageView(image: UIImage(named: "GradientInstagram"))
        view.addSubview(imageBackgroundView)
        return view
    }()
    
    private var registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("You have an account?", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Utils.shared.textFileCornerRadius
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    func confiuerView () {
        headerView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.height/3.0)
        userNameField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 10 ,
            width: view.width - 50,
            height: 56)
        passwordField.frame = CGRect(
            x: 25,
            y: userNameField.bottom + 10 ,
            width: view.width - 50,
            height: 56)
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 56)
        registerButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: 30)
        termButton.frame = CGRect(
            x: 25,
            y: view.height - 85,
            width: view.width - 50,
            height: 30)
        privacyButton.frame = CGRect(
            x: 25,
            y: view.height - 50,
            width: view.width - 50,
            height: 30)
    }
    
    func configuerHeaderView() -> Void {
        if headerView.subviews.count != 1 {
            return
        }
        guard let backgroudView = headerView.subviews.first else {
            return
        }
        backgroudView.frame = headerView.bounds
        let imageView = UIImageView(image: UIImage(named: "SplashIcon")!.withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: headerView.frame.width / 1.5, height: headerView.frame.width - headerView.safeAreaInsets.top )
        imageView.center = headerView.center
        imageView.tintColor = UIColor.white
        backgroudView.addSubview(imageView)
    }
    
    func addTargets() -> Void {
        loginButton.addTarget(self, action: #selector(onPressLoginButton), for: .touchUpInside)
        termButton.addTarget(self, action: #selector(onPressTermButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(onPressPrivacyButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(onPressRegisterButton), for: .touchUpInside)
    }
    
    func addSubView() -> Void {
        view.addSubview(userNameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
        view.addSubview(registerButton)
    }
    
    @objc func onPressLoginButton() {
        userNameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        var userName : String? = nil
        var email: String? = nil
        let passWord = passwordField.text
        if(userNameField.text == "" || passwordField.text == "" ){
            print("please enter!")
        }else {
            if userNameField.text!.contains("@"),userNameField.text!.contains(".") {
                userName = userNameField.text!
            }else{
                email = userNameField.text!
            }
            AuthManager.shared.login(username: userName , email: email, password: passWord!){ success,error in
                print("success \(success)")
                if success {
                    //login success
                    self.dismiss(animated: true, completion: nil)
                }else{
                    //login fail
                    Utils.shared.AlertCustom(title: "\(error!.localizedDescription)", message: "", arrayActions:
                        [UIAlertAction(title: "OK", style: .default, handler: nil),], target:self, preferredStyle: .alert)
                }
            }
        }
    }
    
    @objc func onPressTermButton() {
        if let url = URL(string: "https://help.instagram.com/581066165581870?%3F__hstc=20629287.2f3f33a24b44870ec4a577029c49e44b.1585353600091.1585353600092.1585353600093.1&__hssc=192971698.1.1585872000174&__hsfp=3071927421&_ga=2.67531538.2090819656.1556546632-504387059.1544696302"){
            let vcURL = SFSafariViewController(url: url)
            present(vcURL,animated: true)
        } else{
            return
        }
    }
    
    @objc func onPressPrivacyButton() {
        if let url = URL(string: "https://help.instagram.com/325135857663734/?helpref=hc_fnav&bc[0]=Tr%E1%BB%A3%20gi%C3%BAp%20c%E1%BB%A7a%20Instagram&bc[1]=Trung%20t%C3%A2m%20an%20to%C3%A0n%20v%C3%A0%20quy%E1%BB%81n%20ri%C3%AAng%20t%C6%B0"){
            let vcURL = SFSafariViewController(url: url)
            present(vcURL,animated: true)
        } else{
            return
        }
    }
    
    @objc func onPressRegisterButton() {
        let vcRegister = RegisterViewController()
        vcRegister.modalPresentationStyle = .fullScreen
        vcRegister.title = "Sign Up"
        present(vcRegister,animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSubView()
        view.backgroundColor = .white
        confiuerView()
        configuerHeaderView()
        addTargets()
    }
}


extension LoginViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == userNameField){
            passwordField.becomeFirstResponder()
        }else{
            onPressLoginButton()
        }
        return true
    }
}
