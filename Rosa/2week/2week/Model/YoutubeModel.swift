struct YoutubeModel {
    var id: String
    var title: String?
    
    /// 이미지 URL path
//    var posterPath: String?
    
    /// 설명
    var overview: String?
    
    init(id: String, title: String? = nil, overview: String? = nil) {
        self.id = id
        self.title = title
        self.overview = overview
    }
}



extension YoutubeModel: MappingInterface {
    
    init(entityType: YoutubeEntity) {
        self.id = entityType.snippet.id
        self.title = entityType.snippet.title
        self.overview = entityType.snippet.description
        
    }
}
