/**
    앱 상에서 로직을 수행하기 위한 데이터 모델
 */
struct MovieModel {
    var id: Int
    var title: String?
    
    /// 이미지 URL path
    var posterPath: String?
    
    /// 설명
    var overview: String?
    
    init(id: Int = 0, title: String? = nil, posterPath: String? = nil, overview: String? = nil) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
    }
}


extension MovieModel: MappingInterface {
    
    init(entityType: MovieEntity) {
        self.id = entityType.id
        self.title = entityType.title
        self.overview = entityType.overview
        self.posterPath = entityType.posterPath
        
    }
}
