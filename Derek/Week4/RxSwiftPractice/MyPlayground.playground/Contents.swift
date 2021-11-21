import Foundation
import RxSwift






print("----Just-----")
let justObservable = Observable<Int>.just(3)
justObservable
    .subscribe(onNext: {
        print($0)
    })
print("----Of1-----")
let ofObservable = Observable<Int>.of(1, 2, 3, 4, 5)
ofObservable
    .subscribe(onNext: {
        print($0)
    })
print("----Of1-----")
let of2Observable = Observable.of([1, 2, 3, 4, 5])
of2Observable
    .subscribe(onNext: {
        print($0)
    })
print("--From--")
let fromObservable = Observable.from([1, 2, 3, 4, 5])
fromObservable
    .subscribe(onNext: {
        print($0)
    })


print("----subscribe----")
Observable.of(1, 2, 3)
    .subscribe({print($0)})


print("----subscribe2----")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("----subscribe3----")
Observable.of(2,3,5)
    .subscribe(onNext: {
        print($0)
    })

print("----empty----")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("----Never----")
Observable<Void>.never()
    .subscribe {
        print($0)
    } onError: { err in
        print(err.localizedDescription)
    } onCompleted: {
        print("Completed")
    }

print("----Range----")
Observable.range(start: 1, count: 10)
    .subscribe(onNext:{print($0)} )

print("----dispose----")
Observable.of(2, 4, 7)
    .subscribe{print($0)}
    .dispose()

print("----disposeBag----")
let disposeBag = DisposeBag()

Observable.of(2, 4, 7)
    .subscribe{print($0)}
    .disposed(by: disposeBag)

print("----creat----")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

