//
//  Models.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/28/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation
import UIKit

public enum UserPostType : String {
    case photo = "Photo"
    case video = "Video"
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
    let thumbnailImage : URL
}

public struct SuggestionFriend {
    let username : String
    let bio : String
    let counts : UserCount
    let name : (first : String , last : String)
    let birthday : Date
    let gender : Gender
    let joinDate : Date
    let thumbnailImage : URL
    let relation : (FollowState)
}

struct UserCount {
    let followers : Int
    let following : Int
    let posts : Int
}

public struct UserPostModel {
    let postType : UserPostType
    let thumbnailImage : [URL]
    let postURL : URL
    let caption : String?
    let likeCout : [PostLike]
    let comments : [PostComment]
    let createDate : Date
    let targetUser : [User]
    let owner : User
    var bookmarked : Bool
    var liked : Bool
    var videoURL : String?
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
    let identifier : String
    let username : String
    let text : String
    let createDate : Date
    let likes : [CommentLike]
}

public struct Post {
    var postDetails : UserPostModel
    var comments: [PostComment]
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
    let user : [SuggestionFriend]
}

enum UserNotificationType {
    case like(post: UserPostModel)
    case follow(state : FollowState)
    case suggestFollow(suggestionFriendList : [SuggestionFriend])
}

struct ImagesModalForTabar {
    var title : String?
    var image : UIImage?
}

struct headerItemExploreModal {
    let image : String?
    let label : String
}
