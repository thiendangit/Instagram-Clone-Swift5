//
//  Models.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/28/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation

public enum UserPostType{
    case photo,video
}
public enum Gender {
    case Male , female , other
}

public struct User {
    let username : String
    let bio : String
    let counts : UserCount
    let name : (first : String , last : String)
    let birthday : Date
    let gender : Gender
    let joinDate : Date
}

struct UserCount {
    let followers : Int
    let following : Int
    let posts : Int
}

public struct UserModal {
    let postType : UserPostType
    let thumbnailImage : URL
    let caption : String?
    let likeCout : [PostLike]
    let comments : [PostComment]
    let createDate : Date
    let targetUser : [User]
}

struct PostLike {
    let username : String
    let postIdentifier : String
}

struct CommentLike {
    let username : String
    let commentIdentifier : String
}

struct PostComment {
    let username : String
    let text : String
    let createDate : Date
    let likes = [CommentLike]()
}

public enum FollowState{
    case following , not_follwing
}


public struct UserFollowRelationShip {
    let usename : String
    let name : String
    let type : FollowState
    let avatar : URL
}

public struct UserNotification {
    let type : UserNotificationType
    let text : String
    let profilePicture : URL
}

enum UserNotificationType {
    case like
    case follow
}
