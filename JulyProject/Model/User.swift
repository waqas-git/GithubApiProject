//
//  User.swift
//  JulyProject
//
//  Created by waqas ahmed on 24/07/2024.
//

import Foundation
struct User: Codable, Hashable{
    let login: String
    let avatarUrl : String
    var name : String?
    var location : String?
    var bio : String?
    let publicRepos : Int
    let publicGists : Int
    let followers : Int
    let following : Int
    let createdAt : Date
    let htmlUrl : String
}
