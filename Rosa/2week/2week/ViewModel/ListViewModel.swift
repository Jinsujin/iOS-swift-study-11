import Foundation

//class ListViewModel: ListViewModelInterface {
//    private let service: ServiceInterface
//    
//    init(service: ServiceInterface) {
//        self.service = service
//    }
//    
//    var titlesString: String = "" {
//        didSet {
//            onUpdated()
//        }
//    }
//    var onUpdated: (() -> Void) = {}
//    
//    func reload() {
//        let fetchResults = service.fetch()
//        self.titlesString = fetchResults.compactMap({ $0.title }).joined(separator: "\n")
//    }
//    
//    func add(_ title: String) {
//        service.add(title)
//        self.titlesString = service.currentModel.compactMap({ $0.title }).joined(separator: ",")
//    }
//    
//    func sort() {
//        service.sort()
//        self.titlesString = service.currentModel.compactMap({ $0.title }).joined(separator: ",")
//    }
//}
