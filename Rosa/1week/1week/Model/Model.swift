import Foundation
/**
 Model
    로직(Service) 에서 다루어질 실질적 데이터
 */
struct Model {
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
