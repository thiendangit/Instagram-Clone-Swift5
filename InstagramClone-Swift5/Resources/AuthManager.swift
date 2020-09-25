//
//  AuthManager.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(username: String , email: String, password: String? , completion: @escaping ((Bool , _ error : Error?) -> Void)) {
        DatabaseManager.shared.canRegisterNewUser(username: username, email: email, password: password, completion: {
            canRegister in
            if(canRegister){
                Auth.auth().createUser(withEmail: email, password: password!, completion: {
                    result, error in
                    guard error == nil, result != nil else {
                        completion(false, error)
                        return
                    }
                    DatabaseManager.shared.insertUserToDatabase(username: username, email: email, password: password!, completion: {
                        inserted in
                        if(inserted){
                            completion(true,error)
                        }else{
                            completion(false,error)
                        }
                    })
                })
            }else{
                completion(false, nil)
            }
        })
    }
    
    public func login (username: String? , email: String? , password: String, completion: @escaping ((Bool,_ error : Error?) -> Void)) {
        if let emailNew = email {
            Auth.auth().signIn(withEmail: emailNew, password: password) { authResult, error in
                guard let user = authResult?.user, error == nil else {
                    completion(false,error!)
                    return
                }
                completion(true, error)
                print("user, \(user)")
            }
        }
        if let userName = username {
            Auth.auth().signIn(withEmail: userName, password: password) { authResult, error in
                guard let user = authResult?.user, error == nil else {
                    completion(false,error!)
                    return
                }
                completion(true, error)
                print("user, \(user)")
            }
        }
    }
    
    public func Logout(completion: @escaping ((Bool,_ error : Error?) -> Void)) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
            return
        }catch {
            completion(false,error)
            print("can't logout \(error)")
            return
        }
    }
}
