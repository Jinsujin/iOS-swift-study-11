import Foundation
import RxSwift

class Service {
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
