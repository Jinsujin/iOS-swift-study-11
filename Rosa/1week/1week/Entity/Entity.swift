
/**
 Entity
    서버 혹은 디비에서 가져온 원본 데이터.
 */
import Foundation

struct Entity {
    let adult: Bool
    let id: Int
    let title: String?
    
    /// 이미지 URL path
    let posterPath: String?
    
    /// 설명
    let overview: String?
    let releaseDate: Date?
}
