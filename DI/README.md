# DI (Dependency Injection)

## 의존성 주입(Dependency Injection) 란?

표준을 정의할 수 있고, 정의된 표준을 바탕으로 같은 설계를 하게 해주는 것.

- 객체에게 의존성 주입.

- 인스턴스 생성을 객체 스스로가 아닌, "생성자, 저장속성, 메서드의 파라미터" 형태로 넘겨주는 것.

- 표준을 정의할 수 있고, 정의된 표준을 바탕으로 같은 설계를 하게 해준다.

### 의존성이란?

의존 관계를 가지는 상황에 대한 이해를 하면 좋다.

만일 A클래스를 B클래스의 인스턴스로 만들고 이 인스턴스로 B클래스 내부에 작업을 하게 된다면, B클래스는 자연스럽게 A클래스에 대한 의존 관계가 생기게 된다.

### 주입이란?

내부가 아니라 외부에서 객체를 생성해서 넣어주는 것을 주입이라고 한다.

B클래스 내부에 A클래스의 인스턴스를 생성하는 것이 아닌, A클래스를 사용할 공간을 비워두고 B클래스의 인스턴스를 생성할 때(외부) A클래스를 넣어주는 것을 주입이라고 한다.

### **의존성 분리란?**

의존성 주입은 의존성을 분리시켜 사용한다.

의존성 분리는 의존관계 역전의 원칙[^1]으로 의존관계를 분리시킨다.
상위 모듈이 하위 모듈을 의존하게 되는 상황에서 이를 반전시켜 하위 계층의 구현으로 부터 독립하게 된다. 이를 위해서 Interface를 이용하게 되는데, iOS에서는 protocol로 구현한다.

### 장점

- 코드의 종속성이 감소
  → 변경에 민감하지 않음
- 재사용성을 높여준다
- 테스트에 용이
- 결합도는(coupling) 낮추면서 유연성과 확장성은 향상시킬 수 있다.
- 코드를 단순화 시켜준다.
  종속적이던 코드의 수를 줄여줌
- 코드를 읽기 쉬워진다
  왜 사용하는지 파악이 잘됨
- 객체간의 의존 관계를 없애거나 줄일 수 있다.

## 의존성이 있는 코드를 리펙토링 하기

기존코드를 살펴보자 :

```swift
class AClass {
    var number: Int = 1
}

class BClass {
    var aClass = AClass()
}

let b = BClass()
print(b.aClass)
```

BClass는 AClass의 변수를 내부에 가짐으로서 의존 관계가 생기게 된다.

### 주입

주입이란 내부가 아닌, 외부에서 객체를 생성해 넣어주는 것.

```swift
class CClass {
    var number: Int

    init(withNumber number: Int) {
        self.number = number
    }

    func setNumber(number: Int) {
        self.number = number
    }
}

// 외부에서 객체를 생성자로 넣음
let c = CClass(withNumber: Int(1))
print(c.number)

// 외부에서 객체를 생성해 메서드를 통해 넣음
c.setNumber(number: Int(2))
print(c.number)
```

### 외부에서 넣어줬지만, 아직은 완전한 DI 가 아니다

DI 를 완전히 구현하기 위해서는 의존성 분리가 필요하다.

- DClass 내부에서 AClass 타입의 저장속성을 지님.
  ⇒ 의존성 분리가 필요

```swift
class DClass {
    var aClass: AClass

    init(withVariable variable: AClass) {
        self.aClass = variable
    }
}

let d = DClass(withVariable: AClass())
d.aClass.number
```

### 의존성 분리

- Protocol (Interface) 를 사용해 의존성을 분리.
  ⇒ 의존관계 역전
- 제어의 주체가 Protocol에 있다 =>
  Protocol 의 코드를 분석해서 흐름을 파악할 수 있다.

> 의존관계 역전(Inversion Of Control):
> 의존의 방향이 역전 되었다. (= 의존의 전이를 끊었다)

#### IOC(Inversion Of Control): 제어의 역전

프로그래머가 작성한 프로그램이 라이브러리의 흐름 제어를 받게 되는 디자인 패턴

- 프로그램 제어권을 프레임워크가 가져가는 것
- 개발자는 비지니스 로직에만 신경쓰면 됨
- 개발자가 annotation, xml 등을 통해 설정 해 놓으면 Container가 알아서 처리

### [의존성 분리하는 3가지 방법](./3-patterns.md)

### [Class 간의 의존성 끊는 방법-DIP](./example-DIP.md)

## 아키텍쳐를 적용한 토이프로젝트 🧸

- 🧑🏻‍💻 [Derek](https://github.com/derek1119)
- 👨🏻‍💻 [Walter](https://github.com/taeuk178)
- 👩🏼‍💻 [Rosa](../Rosa/2week/)

[^1]: 의존관계 역전 원칙이란?객체 지향 프로그래밍에서 의존관계 역전 원칙은 소프트웨어 모듈들을 분리하는 특정 형식을 지칭한다. 이 원칙에 따르면 상위 계층이 하위 계층에 의존하는 전통적인 의존관계를 역전 시킴으로써 상위 계층이 하위 계층의 구현으로 부터 독립되게 할 수 있따. 상위 모듈은 하위 모듈에 의존해서는 안된다. 상위 모듈과 하위 모듈 모두 추상화에 의존해야 한다. 추상화는 세부 사항에 의존해서는 안된다. 세부사항이 추상화에 의존해야 한다.(위키피디아)
