import RxSwift
import Foundation

let disposeBag = DisposeBag()

enum TraitsError: Error {
    case single
    case maybe
    case completable
}

print("-----single-----")
Single<String>.just("😀")
    .subscribe {
        print($0)
    } onFailure: { err in
        print(err.localizedDescription)
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disposeBag)

print("-----single2-----")

Observable.just("😀")
    .asSingle()
    .subscribe {
        print($0)
    } onFailure: { err in
        print(err.localizedDescription)
    } onDisposed: {
        print("disposed")
    }
    .disposed(by: disposeBag)

print("-----single3-----")

Observable<String>.create { observer -> Disposable in
    observer.onError(TraitsError.single)
    return Disposables.create()
}
.asSingle()
.subscribe {
    print($0)
} onFailure: { err in
    print(err.localizedDescription)
} onDisposed: {
    print("disposed")
}
.disposed(by: disposeBag)

struct SomeJSON: Decodable {
    let name: String
}

enum JSONError: Error {
    case decodingError
}

let json1 = """
{"name":"Hong"}
"""
let json2 = """
{"my_name":"Seok"}
"""

func decode(json: String) -> Single<SomeJSON> {
    Single<SomeJSON>.create { ob -> Disposable in
        guard let data = json.data(using: .utf8),
                let json = try? JSONDecoder().decode(SomeJSON.self, from: data) else {
                    ob(.failure(JSONError.decodingError))
                    return Disposables.create()}
        ob(.success(json))
        return Disposables.create()
    }
}

decode(json: json1)
    .subscribe { json in
        print(json.name)
    } onFailure: { err in
        print(err.localizedDescription)
    }
    .disposed(by: disposeBag)

decode(json: json2)
    .subscribe { json in
        print(json.name)
    } onFailure: { err in
        print(err)
    }
    .disposed(by: disposeBag)

print("-----Maybe-----")
Maybe<String>.just("😀")
    .subscribe(onSuccess: {print($0)}, onError: {print($0)}, onCompleted: {print("completed")}, onDisposed: {print("disposed")})

print("-----Maybe2-----")
Observable<String>.create({ observer -> Disposable in
    observer.onError(TraitsError.maybe)
    return Disposables.create()
}).asMaybe()
    .subscribe {
        print("성공 : \($0)")
    } onError: {
        print("에러 : \($0)")
    } onCompleted: {
        print("completed")
    } onDisposed: {
        print("disposed")
    }

print("-----Completable1-----")
Completable.create { observer -> Disposable in
    observer(.error(TraitsError.completable))
    return Disposables.create()
}
.subscribe {
    print("complted")
} onError: { err in
    print(err)
} onDisposed: {
    print("disposed")
}.disposed(by: disposeBag)

print("-----Completable2-----")
Completable.create { observer -> Disposable in
    observer(.completed)
    return Disposables.create()
}
.subscribe {
    print($0)
} .disposed(by: disposeBag)
