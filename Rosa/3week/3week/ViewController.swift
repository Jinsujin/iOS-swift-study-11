//
//  ViewController.swift
//  3week
//
//  Created by jsj on 2021/10/10.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    var data: [Item] = []

    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    let urlString = "https://api.github.com/search/repositories?sort=starts&order=desc&q=rx%20in:name+language:swift+followers:%3E%3D100"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func touchedFetchButton(_ sender: Any) {
        textView.text = "Fetch Start"
        
        fetchDataRx(from: self.urlString)
            .observe(on: MainScheduler.instance) // UI는 메인쓰레드에서 업데이트
            .subscribe(onNext: { [weak self] items in
                self?.data = items
                self?.textView.text = "\(items.count)"
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                print("onCompleted")
            }, onDisposed: {
                print("onDisposed")
            })
    }
    
    func fetchDataRx(from url: String) -> Observable<[Item]> {
        return Observable.create { emitter in
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            request.setValue("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", forHTTPHeaderField: "access_token")
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                
                guard let data = data,
                      let decodedResult = try? JSONDecoder().decode(Result.self, from: data) else {
                    emitter.onCompleted()
                    return
                }
                emitter.onNext(decodedResult.items)
                emitter.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

