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
    func fetchDataRx(with token: String) -> Observable<[RepoData]> {
        return Observable.create { emitter in
            let url = "https://api.github.com/user/repos"
            let headers: HTTPHeaders = ["Authorization" : "token \(token)"]
            
            AF.request(url, method: .get, headers: headers)   .responseDecodable(of: [RepoData].self) { response in
                switch response.result {
                case .success(let data):
                    let newData = data.filter { $0.fullName.contains("derek1119") }
                    emitter.onNext(newData)
                    emitter.onCompleted()
                case .failure(let error):
                    print("디코딩 오류")
                    emitter.onError(error)
                    print(error.localizedDescription)
                }
            }
            return Disposables.create {
                print("무엇을 해야할까요?")
            }
        }
    }
    
//    func fetchData(with token: String) {
//        let url = "https://api.github.com/user/repos"
//        let headers: HTTPHeaders = ["Authorization" : "token \(token)"]
//
//        AF.request(url, method: .get, headers: headers)   .responseDecodable(of: [RepoData].self) { response in
//            switch response.result {
//            case .success(let data):
//                print(data[0].fullName)
//            case .failure(let error):
//                print("디코딩 오류")
//                print(error.localizedDescription)
//            }
//        }
//    }
}
