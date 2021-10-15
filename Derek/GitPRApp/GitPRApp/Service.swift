//
//  Service.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/15.
//

import Foundation
import Alamofire
import RxSwift

class Service {
    func fetchData(with token: String) -> Observable<[RepoData]> {
        return Observable.create { emitter in
            let url = "https://api.github.com/user/repos"
            let headers: HTTPHeaders = ["Authorization" : "token \(token)"]
            
            AF.request(url, method: .get, headers: headers)   .responseDecodable(of: [RepoData].self) { response in
                switch response.result {
                case .success(let data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case .failure(let error):
                    emitter.onError(error)
                    print(error.localizedDescription)
                }
            }
            return Disposables.create {
                print("무엇을 해야할까요?")
            }
        }
    }
}
