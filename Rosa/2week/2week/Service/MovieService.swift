/**
 Service(어플리케이션의 핵심 비지니스 로직)
    1. Repository의 Entity 모델을 로직에서 사용하는 Model로 변경
    2. Model 을 이용해 로직 수행
 */
import Foundation

class MovieService {
    let repository = Repository()
    
    // state 상태값을 가짐.
    var currentModel: [MovieModel] = []
    var isSorted = false
    
    /// repository 를 통해서 데이터를 fetch
    func fetch() -> [MovieModel] {
        // Entity -> Model 변경
        let datas = repository.fetch(type: MovieModel.self, filename: "mock")
        let models = datas.compactMap({ MovieModel(id: $0.id, title: $0.title, posterPath: $0.posterPath, overview: $0.overview) })
        self.currentModel = models
        return models
    }
    
    ///영화리스트에 새로운 데이터 추가
    func addMovie(_ title: String) {
        let newData = MovieModel(id: Int.random(in: 1...10), title: title, posterPath: nil, overview: "상세정보")
        self.currentModel.append(newData)
    }
    
    /// 타이틀을 기준으로 영화리스트 정렬
    func sortMovies() {
        isSorted = !isSorted
        isSorted
            ? currentModel.sort(by: {$0.title! > $1.title!}) // 내림
            : currentModel.sort(by: {$0.title! < $1.title!}) // 오름
    }
}
