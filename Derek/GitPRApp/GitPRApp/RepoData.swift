//
//  RepoData.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/15.
//

import Foundation

struct RepoData: Codable {
    let id: String
    let node_id: String
    let name: String
    let fullName: String
    let owner: Owner
    let description: String?
    let repoURL: String
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id, node_id, name
        case fullName = "full_name"
        case owner, description
        case repoURL = "url"
        case language
    }
}

struct Owner: Codable {
    let login: String
    let id: Int
    let node_id: String
}
