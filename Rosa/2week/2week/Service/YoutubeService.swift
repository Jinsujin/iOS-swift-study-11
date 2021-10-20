/**
 Service(어플리케이션의 핵심 비지니스 로직)
    1. Repository의 Entity 모델을 로직에서 사용하는 Model로 변경
    2. Model 을 이용해 로직 수행
 */
import Foundation

class YoutubeService {

    let repository = Repository()
    
    // state 상태값을 가짐.
    var currentModel: [YoutubeModel] = []
    var isSorted = false
    
    /// repository 를 통해서 데이터를 fetch
    func fetch() -> [YoutubeModel] {
        // Entity -> Model 변경
        let datas = repository.fetch(type: YoutubeModel.self,filename: "youtubeMock")
        let models = datas.compactMap({ YoutubeModel(entityType: $0) })
        self.currentModel = models
        return models
    }
    
    ///영화리스트에 새로운 데이터 추가
    func add(_ title: String) {
        let newData = YoutubeModel(id: "undefined", title: title, overview: nil)
        self.currentModel.append(newData)
    }
    
    /// 타이틀을 기준으로 영화리스트 정렬
    func sort() {
        isSorted = !isSorted
        isSorted
            ? currentModel.sort(by: {$0.title! > $1.title!}) // 내림
            : currentModel.sort(by: {$0.title! < $1.title!}) // 오름
    }
}
