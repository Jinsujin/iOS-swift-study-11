//
//  SearchService.swift
//  RxMVVM
//
//  Created by taeuk on 2021/10/08.
//

import Foundation
import Moya

typealias resultModel<T> = (Result<T, Error>) -> Void

protocol SearchDependency {
    func fetchRepository(word: String, page: Int, completion: @escaping resultModel<RepositoryListModel>)
}

extension SearchDependency {
    func fetchRepository(word: String, page: Int = 1, completion: @escaping resultModel<RepositoryListModel>) {
        fetchRepository(word: word, page: page, completion: completion)
    }
}

struct SearchService: SearchDependency {
    
    enum GithubSearch: TargetType {
        
        case search(query: String)
        
        var baseURL: URL {
            return URL(string: "https://api.github.com/")!
        }
        
        var path: String {
            switch self {
            case .search(_):
                return "search/repositories"
            }
        }
        
        var method: Moya.Method {
            .get
        }
        
        var task: Task {
            switch self {
            case let .search(query):
                return .requestParameters(parameters: ["q": query], encoding: URLEncoding())
            }
        }
        
        var headers: [String : String]? {
            nil
        }
    }
    
    let service = MoyaProvider<GithubSearch>()
    
    func fetchRepository(word: String, page: Int, completion: @escaping resultModel<RepositoryListModel>) {
        
        service.request(.search(query: word)) { response in
            switch response {
            case .success(let data):
                if let decode = try? JSONDecoder().decode(RepositoryListModel.self, from: data.data) {
                    completion(.success(decode))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
