//
//  RepositoryModel.swift
//  RxMVVM
//
//  Created by taeuk on 2021/10/09.
//

import Foundation

// 검색 시 repo 모델
struct RepositoryListModel: Codable {
    let total: Int
    let items: [RepositoryItemModel]
    
    enum CodingKeys: String, CodingKey {
        case total = "total_count"
        case items
    }
}

// repo item 모델
struct RepositoryItemModel: Codable {
    let fullName: String
    let id: Int
    let stargazersCount: Int
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case description, id
    }
}
