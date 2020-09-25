//
//  StorageManager.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation
import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucketRef = Storage.storage().reference()
    
    public enum IGStorageManagerError : Error {
        case failureToDownload
    }
    
    public func uploadPostUser(model : UserModal , completion : @escaping (Result<URL,Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference : String, completion: @escaping (Result<URL,IGStorageManagerError>) -> Void ){
        bucketRef.child(reference).downloadURL(completion: { url , error in
            guard let url = url, error == nil else {
            completion(.failure(.failureToDownload))
            return
            }
            completion(.success(url))
        })
    }
    
    
    public enum UserPostType{
        case photo,video
    }
    
    public struct UserModal {
        let postType : UserPostType
    }
    
}
