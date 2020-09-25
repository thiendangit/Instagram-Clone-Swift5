//
//  DatabaseManager.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    let databaseRef = Database.database().reference()
    
    public func canRegisterNewUser(username: String , email: String, password: String?,completion: @escaping ((Bool) -> Void)) {
        completion(true)
    }
    
     public func insertUserToDatabase(username: String , email: String, password: String?,completion: @escaping ((Bool) -> Void)) {
        let key = email.safeDatabaseKey()
        databaseRef.child(key).setValue(["username" : username]){
            error , _ in
            if(error == nil){
                completion(true)
                return
            }else{
                completion(false)
                return
            }
        }
    }
}
