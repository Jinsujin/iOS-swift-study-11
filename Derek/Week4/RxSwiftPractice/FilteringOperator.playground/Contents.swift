import RxSwift

let disposeBag = DisposeBag()

print("----ignore Element----")
let 취침모드😴 = PublishSubject<String>()
취침모드😴.ignoreElements()
    .subscribe { _ in
        print("☀️")
    }
    .disposed(by: disposeBag)

취침모드😴.onNext("🔊")
취침모드😴.onNext("🔊")
취침모드😴.onNext("🔊")

//onNext 는 무시하는 것

취침모드😴.onCompleted()

print("----ElementAt----")
// 특정 인덱스의 넥스트 이벤트만 받는다.
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("🔊")
두번울면깨는사람.onNext("🔊")
두번울면깨는사람.onNext("😃")
두번울면깨는사람.onNext("🔊")
두번울면깨는사람.onNext("🔊")

print("----Filter----")

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext : {
        print($0)
    })
    .disposed(by: disposeBag)

print("----Skip----")

Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .skip(5)
    .subscribe(onNext:{ print($0) })
    .disposed(by: disposeBag)

print("----SkipWhile----")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8, 9)
    .skip(while: { $0 != 3 })
    .subscribe(onNext:{ print($0) })
    .disposed(by: disposeBag)

print("----skip until----")

let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님
    .skip(until: 문여는시간)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


손님.onNext("😀")
손님.onNext("😀")
손님.onNext("😀")

문여는시간.onNext("지금입니다.")
손님.onNext("🥸")
손님.onNext("🥸")


print("----take----")
Observable.of("🥇", "🥈", "🥉", "🤩", "🤓")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----take while----")
Observable.of("🥇", "🥈", "🥉", "🤩", "🤓")
    .take(while: { $0 != "🥉"})
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("----enumerated----")

Observable.of("🥇", "🥈", "🥉", "🤩", "🤓")
    .enumerated()
    .take(while: { $0.index < 3})
    .subscribe(onNext: { print($0.element) })
    .disposed(by: disposeBag)

print("----take until----")

let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {print($0)})
    .disposed(by: disposeBag)

수강신청.onNext("🖐")
수강신청.onNext("🖐")

신청마감.onNext("끝")

수강신청.onNext("🖐")

print("----distinctUntilChanged----")

Observable.of("저는", "저는", "앵무새", "앵무새", "앵무새", "입니다", "입니다", "입니다")
    .distinctUntilChanged()
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)
