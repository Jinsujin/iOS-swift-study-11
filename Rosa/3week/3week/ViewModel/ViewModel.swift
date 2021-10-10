import Foundation
import RxSwift

class ViewModel {
    let urlString = "https://api.github.com/search/repositories?sort=starts&order=desc&q=rx%20in:name+language:swift+followers:%3E%3D100"
    
    let service = Service()
    let disposeBag = DisposeBag()
    
    let subject = BehaviorSubject<[Item]>(value: [])
    
    init() {
        
    }
    
    // 데이터 불러오기 성공일때 : onNext -> onCompleted -> onDisposed
    func fetchData() {
        service.fetchDataRx(from: urlString)
            .subscribe(subject)
            .disposed(by: disposeBag)
    }
}
