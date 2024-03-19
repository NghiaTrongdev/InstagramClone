//
//  PostUser.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 12/03/2024.
//

import Foundation
public enum UserPostType : String {
    case photo = "Photo"
    case video = "Video"
}
enum Gender {
    case male , famale, other
}

//public struct UserPost {
//    let posttype : UserPostType
//}
public struct User {
    let username : String
    let bio : String
    let name : (first : String,last : String)
    let profileImage : URL
    let gender : Gender
    let birthDate : Date
    let joinDate : Date
    let counts : UserCount
    
}
public struct UserCount {
    let flowing : Int
    let flowers : Int
    let posts : Int
}
public struct UserPost {
    let identifier : String
    let posttype : UserPostType
    let thumnailImage : URL
    let postUrl : URL
    let caption : String?
    let likeCount : [PostLikes]
    let comments : [PostComment]
    let taggedUser : [User]
    let owner : User
}
public struct PostLikes{
    let username : String
    let postIdentifier : String
}
public struct CommentLikes{
    let username : String
    let commentIdentifier : String
}
public struct PostComment{
    let identifier : String
    let username : String
    let text : String
    let createDate : Date
    let likes : [CommentLikes]
}
enum UserNotificationType{
    case like(post : UserPost)
    case follow(state : FlowState)
}
enum FlowState {
    case following
    case not_follow
}
struct UserRelations{
    let name : String
    let username : String
    let type : FlowState
}
struct UserNotification {
    let type : UserNotificationType
    let text : String
    let user : User
}
