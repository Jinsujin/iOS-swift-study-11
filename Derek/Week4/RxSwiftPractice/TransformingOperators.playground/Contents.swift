import RxSwift
import Foundation

let disposeBag = DisposeBag()

print("-----toArray------")
// ---> Single로 변함
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {print($0)})
    .disposed(by: disposeBag)

print("-----map------")
Observable.of(Date())
    .map {
        let dateformmater = DateFormatter()
        dateformmater.dateFormat = "yyyy-mm-dd"
        dateformmater.locale = Locale(identifier: "ko_KR")
        return dateformmater.string(from: $0)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("-----flapmap------")
protocol Player {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수: Player {
    var 점수: BehaviorSubject<Int>
}

let 한국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
let 미국국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8))

let 올림픽경기 = PublishSubject<Player>()

올림픽경기
    .flatMap {
        $0.점수
    }
    .subscribe(onNext: { print($0)} )
    .disposed(by: disposeBag)

올림픽경기.onNext(한국국가대표)
한국국가대표.점수.onNext(10)


올림픽경기.onNext(미국국가대표)
한국국가대표.점수.onNext(10)
미국국가대표.점수.onNext(9)

print("-----flapmapLatest------")
struct 높이뛰기선수: Player {
    var 점수: BehaviorSubject<Int>
}

let seoul = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 7))
let jeju = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 7))

let koreaCompetiton = PublishSubject<Player>()

koreaCompetiton
    .flatMapLatest { 선수 in
        선수.점수
    }
    .subscribe(onNext:{ print($0) })
    .disposed(by: disposeBag)

koreaCompetiton.onNext(seoul)
seoul.점수.onNext(9)

koreaCompetiton.onNext(jeju)
seoul.점수.onNext(10)
jeju.점수.onNext(9)

print("-----materialize and dematerialize------")

enum Faul: Error {
    case falseStart
}

struct Runner: Player {
    var 점수: BehaviorSubject<Int>
}

let kimtokki = Runner(점수: BehaviorSubject<Int>(value: 0))
let parkChita = Runner(점수: BehaviorSubject<Int>(value: 1))

let run100m = BehaviorSubject<Player>(value: kimtokki)

run100m
    .flatMapLatest { player in
        player.점수
            .materialize()
    }
    .filter {
        guard let error = $0.error else {
           return true
        }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext: { print($0) })
    .disposed(by: disposeBag)

kimtokki.점수.onNext(1)
kimtokki.점수.onError(Faul.falseStart)
kimtokki.점수.onNext(2)

run100m.onNext(parkChita)
parkChita.점수.onNext(3)

print("-------전화번호 11자리---------")

let input = PublishSubject<Int?>()

let list: [Int] = [1]

input
    .flatMap( {
        $0 == nil
        ? Observable.empty()
        : Observable.just($0)
    })
    .map { $0! }
    // 0이 나오기 전까지는 스킵
    .skip(while: { $0 != 0 })
    // 0이 나오기 시작하면 그 이후 전화번호 11자리 받아
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)"}
    }
    .map { numberStr in
        var numberList = numberStr
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: { print($0) })

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(8)
input.onNext(4)
input.onNext(5)
input.onNext(1)
input.onNext(3)
input.onNext(2)
input.onNext(9)



