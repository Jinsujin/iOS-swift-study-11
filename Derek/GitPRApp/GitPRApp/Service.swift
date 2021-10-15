//
//  Service.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/15.
//

import Foundation
import Alamofire

class Service {
    func fetchData(with token: String) {
        let url = "https://api.github.com/user/repos"
        let headers: HTTPHeaders = ["Authorization" : "token \(token)"]
        
        AF.request(url, method: .get, headers: headers).responseData { response in
            
            switch response.result {
            case .success(let data):
                guard let decodedData = try? JSONDecoder().decode(RepoData.self, from: data) else {
                    print("디코딩 실패")
                    return }
                print(decodedData)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
        
        
//        { response in
//            switch response.result {
//            case .success(let json):
//                 let jsonDecoder = JSONDecoder()
//                jsonDecoder.decode(RepoData.self, from: json)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
