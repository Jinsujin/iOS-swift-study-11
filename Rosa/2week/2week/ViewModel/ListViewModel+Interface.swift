protocol ListViewModelInterface {
    var titlesString: String { get set }
    var onUpdated: (() -> Void) { get set }
    
    func reload()
    func addMovie(_ title: String)
    func sortMovies()
}

// 기본 구현
extension ListViewModelInterface {

}

