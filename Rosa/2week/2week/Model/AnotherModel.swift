struct AnotherModel {
    var id: Int
    var title: String?
    
    /// 이미지 URL path
//    var posterPath: String?
    
    /// 설명
    var overview: String?
    
    init(id: Int = 0, title: String? = nil, overview: String? = nil) {
        self.id = id
        self.title = title
        self.overview = overview
    }
}
