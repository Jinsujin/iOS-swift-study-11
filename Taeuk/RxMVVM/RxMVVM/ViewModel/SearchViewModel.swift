//
//  SearchViewModel.swift
//  RxMVVM
//
//  Created by taeuk on 2021/10/08.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchInputType {
    func requestSearchRepo(keyword: String)
    var loginState: Observable<Bool> { get set }
}

protocol SearchOutputType {
    var repoList: BehaviorRelay<RepositoryListModel> { get set }
}

class SearchViewModel: BaseViewModel, SearchInputType, SearchOutputType {
    
    let disposeBag = DisposeBag()
    
    var input: SearchInputType { return self }
    
    var output: SearchOutputType { return self }
    
    
    var searchService: SearchDependency
    
    // input
    var loginState: Observable<Bool> = Observable<Bool>.just(false)
    
    // output
    var repoList: BehaviorRelay<RepositoryListModel> = BehaviorRelay(value: RepositoryListModel(total: 0,
                                                                                                items: []))
    
    init(dependency: SearchDependency) {
        self.searchService = dependency
    }
    
    func requestSearchRepo(keyword: String) {
        searchService.fetchRepository(word: keyword) { [weak self] response in
            switch response {
            case .success(let data):
                self?.repoList.accept(data)
            case .failure(let err):
                print(err)
            }
        }
    }
}
