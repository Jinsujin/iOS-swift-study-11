/**
 ViewModel
    1. 화면에 보여질 데이터 Model 을 다룬다.
    2. Model -> ViewModel 로 변환
 */
import Foundation



class MovieViewModel: ListViewModelInterface {
    
    private let service = MovieService()
    public var onUpdated: () -> Void = {}
    
    // 화면에 보여지는 값
    var titlesString: String = "" {
        didSet {
            // 값이 변경되었을때 호출
            onUpdated()
        }
    }
    
    /// fetch Data
    /// Service 에 데이터 달라고 요청하여 얻은 Model 을 ViewModel로 변환
    func reload() {
        let fetchResults = service.fetch()
        
        // Model -> ViewModel 변환
        self.titlesString = fetchResults.compactMap({ $0.title }).joined(separator: "\n")
    }
    
    /// 정렬
    func updateMovieTitles(titles: [String]) -> String {
        return titles.joined(separator: ",")
    }
    
    func addMovie(_ title: String) {
        service.add(title)
        self.titlesString = service.currentModel.compactMap({ $0.title }).joined(separator: ",")
    }
    
    func sortMovies() {
        service.sort()
        self.titlesString = service.currentModel.compactMap({ $0.title }).joined(separator: ",")
    }
}
