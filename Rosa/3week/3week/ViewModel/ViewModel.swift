import Foundation
import RxSwift

class ViewModel {
    let urlString = "https://api.github.com/search/repositories?sort=starts&order=desc&q=rx%20in:name+language:swift+followers:%3E%3D100"
    
    let service = Service()
    let disposeBag = DisposeBag()
    
    let subject = BehaviorSubject<[Item]>(value: [])
    
    init() {
        
    }
    
    func fetchData() {
        service.fetchDataRx(from: urlString)
            .subscribe(subject)
            .disposed(by: disposeBag)
    }
}
