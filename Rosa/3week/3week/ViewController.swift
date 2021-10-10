//
//  ViewController.swift
//  3week
//
//  Created by jsj on 2021/10/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    let urlString = "https://api.github.com/search/repositories?sort=starts&order=desc&q=rx%20in:name+language:swift+followers:%3E%3D100"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func touchedFetchButton(_ sender: Any) {
        textView.text = "Fetch Start"
        
        fetchData(urlString: self.urlString) { (result) in
            DispatchQueue.main.async {
                self.textView.text = result
            }
        }
    }
    
    
    func fetchData(urlString: String, completion: @escaping(String) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("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", forHTTPHeaderField: "access_token")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("URLSession start")
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            
            guard let data = data,
                  let json = String(data: data, encoding: .utf8) else {
                completion("Fail convert data")
                return
            }
            
            completion(json)
        }.resume()
        
        completion("function End")
    }
}

