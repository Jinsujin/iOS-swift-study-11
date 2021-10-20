import Foundation


struct YoutubeEntity: Codable {
    let snippet: YoutubeSnippet
    
    enum CodingKeys: String, CodingKey {
        case snippet
    }
}


struct YoutubeSnippet: Codable {
    let publishedAt: String
    let id: String
    let title: String
    let description: String
    let channelTitle: String
    let liveBroadcastContent: String
    let publishTime: String
    
    enum CodingKeys: String, CodingKey {
        case publishedAt
        case id = "channelId"
        case title
        case description
        case channelTitle
        case liveBroadcastContent
        case publishTime
    }
}
