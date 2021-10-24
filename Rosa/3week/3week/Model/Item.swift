import Foundation


// MARK: - Result
struct Result: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let nodeID, name, fullName: String
    let itemPrivate: Bool
    let owner: Owner
    let htmlURL: String
    let itemDescription: String
    let score: Int
    let languagesURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case itemPrivate = "private"
        case owner
        case score
        case htmlURL = "html_url"
       case itemDescription = "description"
        case languagesURL = "languages_url"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
    }
}
