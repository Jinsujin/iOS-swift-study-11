//
//  LoginManager.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/06.
//

import UIKit
import Alamofire

class LoginManager {
    static let shared = LoginManager()
    
    private init() {
        
    }
    
    private var CLIENT_ID : String {
        get {
            // 생성한 .plist 파일 경로 불러오기
            guard let filePath = Bundle.main.path(forResource: "KeyList", ofType: "plist") else {
                fatalError("Couldn't find file 'KeyList.plist'.")
            }
            
            // .plist를 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 값 찾기
            guard let value = plist?.object(forKey: "CLIENT_ID") as? String else {
                fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'KeyList.plist'.")
            }
            return value
        }
    }
    
    private var CLIENT_SECRET: String {
        get {
            // 생성한 .plist 파일 경로 불러오기
            guard let filePath = Bundle.main.path(forResource: "KeyList", ofType: "plist") else {
                fatalError("Couldn't find file 'KeyList.plist'.")
            }
            
            // .plist를 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 값 찾기
            guard let value = plist?.object(forKey: "CLIENT_SECRET") as? String else {
                fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'KeyList.plist'.")
            }
            return value
        }
    }
    
    func requestCode() {
        let scope = "repo,user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(CLIENT_ID)&scope=\(scope)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            // redirect to scene(_:openURLContexts:) if user authorized
        }
    }
    
    func requestAccessToken(with code: String) {
        let url = "https://github.com/login/oauth/access_token"
        let param = ["client_id" : CLIENT_ID,
                     "client_secret" : CLIENT_SECRET,
                     "code" : code]
        let headers: HTTPHeaders = ["Accept" : "application/json"]
        
        AF.request(url, method: .post, parameters: param, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let json):
                if let dic = json as? [String: String] {
                    print(dic["access_token"] ?? "")
                    print(dic["scope"]  ?? "")
                    print(dic["token_type"]  ?? "")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
       
    
}
