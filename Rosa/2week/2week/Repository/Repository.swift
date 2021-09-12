
/**
 - Repository: Entity 를 fetch 하는 역할
 - Entity : Server API 또는 DB 에서 fetch 한 데이터
 */

import Foundation

class Repository {
    
    /**
     json 을 가져와 Entity 로 디코딩하여 반환
     - type : YoutubeModel
     - T.EntityType.self : YoutubeEntity
     */
    func fetch<T: MappingInterface>(type: T.Type, filename: String) -> [T.EntityType] {
        
//        print(type, T.EntityType.self)
        guard let path = Bundle.main.path(forResource: filename, ofType: "json"),
              let jsonString = try? String(contentsOfFile: path) else {
            return []
        }

        let decoder = JSONDecoder()
        guard let data = jsonString.data(using: .utf8),
              let decodedDatas = try? decoder.decode([T.EntityType].self, from: data) else {
            return []
        }
        
        return decodedDatas
    }
}


