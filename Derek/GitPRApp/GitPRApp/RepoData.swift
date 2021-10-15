//
//  RepoData.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/15.
//

import Foundation

struct RepoData: Codable {
    let id: Int
    let nodeId: String
    let name: String
    let fullName: String
    let owner: Owner
    let description: String?
    let repoURL: String
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case owner, description
        case repoURL = "url"
        case language
    }
}

struct Owner: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeId = "node_id"
        case avatarURL = "avatar_url"
    }
}
