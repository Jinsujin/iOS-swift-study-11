# POP(Protocol Oriented Programming)

## POP의 배경

기존의 객체지향 프로그래밍에서는 객체지향의 특징인 상속과 다형성을 이용하여 구현한다.

하지만 struct와 enum은 상속이 불가능하고 class에 불필요한 함수를 override할 수 있다는 단점이 있다.

그래서 Swift는 extension, protocol, generic을 활용한 새로운 패러다임 Protocol Oriented Programming으로 프로토콜 지향 접근법으로 시스템을 설계하고자 했다.

POP의 장점은 여러 개의 프로토콜을 채택할 수 있고 메모리에 대한 특정 요구사항도 없다.

struct와 enum과 같은 값 타입에서도 채택이 가능하며, 수직적 구조에서 수평적인 구조로도 구현이 가능하다는 장점을 가지고 있다.

## 프로토콜 프래그래밍이 중요한 이유

구현이 아닌 인터페이스에 맞추어 개발하라는 말이 있다. 그만큼 인터페이스는 중요하다.

여기서 프로토콜과 인터페이스는 무슨 연관일까? 프로토콜은 의도한 행위만 노출 시키는 것이다. 그에 따른 상세 구현은

프로토콜을 채택한 곳에서 행위를 하는 것이기 때문에 그 **의도**만을 나타내는 인터페이스, 프로토콜 인 것이다.

의도한 행위 만을 노출 시킴으로서 그 외 상태에 대한 캡슐화가 이루어진다.

구현체가 아닌 프로토콜에 의존적이면, 구현을 바꾸기가 쉬워진다. 인터페이스만 충족된다면, 사용되는 곳에서는 신경쓰지 않는다.

### 주의할 점

프로토콜의 구현을 바꾸는 건 쉽다는 장점이 있지만 프로토콜 자체를 바꾸는 일은 모든 구현체, 해당 프로토콜을 사용하는 객체, 테스트 코드에 영향을 주기 때문에 어려운 작업이 된다. 따라서 프로토콜을 설계할 때 적절한 권한(역할)을 부여해야 하여 변경을 최소화 해야 한다.

extension을 통해 부분 기본 구현으로 좀더 유연한 개발이 가능해보인다.

## Example

```swift
protocol Walkable {
    var isBareFoot: Bool { get set } // 맨발여부
    var speed: Double { get set }
    func walk(name: String)
}

// Base가 되는 요구사항을 미리 정의
// 중복되는 코드들을 extension 으로 관리할 수 있다.
extension Walkable {
    func walk(name: String) {
        if isBareFoot {
            print("\(name) 은 맨발로 \(speed)속도로 걷는다")
            return
        }
        print("\(name) 은 신발을 신은채 \(speed)속도로 걷는다")
    }
}

protocol Flyable {
    func fly()
}

extension Flyable {
    func fly() {
        print("날다")
    }
}

protocol Runable {
    func run()
}

extension Runable {
    func run() {
        print("뛰다")
    }
}

struct Person: Walkable, Runable {
    var isBareFoot: Bool
    var speed: Double
}

struct Animal: Walkable {
    var isBareFoot: Bool
    var speed: Double
}

struct Bird: Flyable, Runable, Walkable {
    var isBareFoot: Bool
    var speed: Double
}

let jin = Person(isBareFoot: false, speed: 1.0)
jin.walk(name: "JIN")

let dog = Animal(isBareFoot: true, speed: 2.0)
dog.walk(name: "Jindol")

let twit = Bird(isBareFoot: true, speed: 0.3)
twit.fly()
twit.run()
twit.walk(name: "참새")
```
