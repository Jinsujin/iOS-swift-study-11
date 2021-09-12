import Foundation

class YoutubeViewModel: ListViewModelInterface {
    private let service = YoutubeService()
    
    var titlesString: String = "" {
        didSet {
            onUpdated()
        }
    }
    var onUpdated: (() -> Void) = {}
    
    func reload() {
        let fetchResults = service.fetch()
        self.titlesString = fetchResults.compactMap({ $0.title }).joined(separator: "\n")
    }
    
    func addMovie(_ title: String) {
        service.addMovie(title)
        self.titlesString = service.currentModel.compactMap({ $0.title }).joined(separator: ",")
    }
    
    func sortMovies() {
        service.sortMovies()
        self.titlesString = service.currentModel.compactMap({ $0.title }).joined(separator: ",")
    }
    
    
}
