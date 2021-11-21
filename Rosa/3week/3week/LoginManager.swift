import UIKit

class LoginManager {
    static let shared = LoginManager()
    private init() {}
    
    private let scope = "repo,user"
    private let client_id = "1f52387fd9daa6e73269"
    private let client_secret = "28ffe1c900cda22ddba82c73242d72351b5d147c"
    
    private var accessToken: String?
    private var tokenType: String?
    
    func login() {
        let urlString = "https://github.com/login/oauth/authorize?client_id=\(client_id)&scope=\(scope)"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            // redirect to scene(_:openURLContexts:) if user authorized
        }
    }
    
    
    func requestAccessToken(with code: String, completionHandler: @escaping(Bool, [String: Any]) -> Void ) {
        let urlString = "https://github.com/login/oauth/access_token"
        let parameters = ["client_id": client_id,
                          "client_secret": client_secret,
                          "code": code]
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]  {
                print(json)
                self.accessToken = json["access_token"] as? String
                self.tokenType = json["token_type"] as? String
                
                completionHandler(true, json)
            }
        }.resume()

      }
}
