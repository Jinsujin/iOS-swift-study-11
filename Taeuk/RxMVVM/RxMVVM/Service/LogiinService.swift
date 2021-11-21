//
//  LogiinService.swift
//  RxMVVM
//
//  Created by taeuk on 2021/10/31.
//

import UIKit
import Moya
import Alamofire

struct LoginService {
    
    // MARK: - Properties
    
    private static let clientID = "7b810a93c51afafcafe8"
    private static let clientScretID = "109d4628a1249eaa1697b2f4a83faa44b9dcd65c"
    
    enum GithubLogin: TargetType {
        
        case login(code: String)
        
        var baseURL: URL {
            return URL(string: "https://github.com/")!
        }
        
        var path: String {
            switch self {
            case .login(_):
                return "login/oauth/access_token"
            }
        }
        
        var method: Moya.Method {
            .post
        }
        
        var task: Task {
            switch self {
            case let .login(code):
                return .requestParameters(parameters: ["client_id": LoginService.clientID,
                                                       "client_secret": LoginService.clientScretID,
                                                       "code": code], encoding: JSONEncoding())
            }
        }
        
        var headers: [String : String]? {
            return [
                "Accept": "application/vnd.github.v3+json"
            ]
        }
    }
    
    let service = MoyaProvider<GithubLogin>()
    
    func openGithub() {
        
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(LoginService.clientID)&scope=repo,user"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            print(url)
            UIApplication.shared.open(url)
        }
    }
    
    func fetchRepository(code: String) {

        let url = "https://github.com/login/oauth/access_token"
        
        let parameters = ["client_id": LoginService.clientID,
                          "client_secret": LoginService.clientScretID,
                          "code": code]
        
        let headers: HTTPHeaders = [
            "Accept": "application/vnd.github.v3+json"
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            switch response.result {
            case let .success(json):
                print(json)
                if let dic = json as? [String: String], let token = dic["access_token"] {
                    print(token)
                }
            case let .failure(error):
                print(error)
            }
        }
        
//        service.request(.login(code: code)) { response in
//            switch response {
//            case let .success(json):
//                print(json.data)
//                if let decodingData = Data(base64Encoded: json.data), let decoding = String(data: decodingData, encoding: .utf8) {
//                    print(decoding)
//                }
//
//                let decoco = String(data: json.data, encoding: .utf8)
//                print(decoco)
//
//                if let decode = try? JSONDecoder().decode(RepositoryListModel.self, from: json.data) {
//                    print(decode)
//                }
//            case let .failure(error):
//                print(error)
//            }
//        }
    }
}
