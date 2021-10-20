//
//  RepoListViewModel.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/15.
//

import Foundation
import RxSwift

class RepoListViewModel {
    let service = Service()
    let disposeBag = DisposeBag()
    
    let subject = BehaviorSubject<[RepoData]>(value: [])
    
    init () {
        
    }
    
    func fetchData(with token: String) {
        service.fetchDataRx(with: token)
            .subscribe(subject)
            .disposed(by: disposeBag)
    }
}
