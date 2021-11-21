# 의존성 분리하는 3가지 방법

Protocol 과, 이 Protocol 을 따르는 구조체를 이용한 의존성 주입을 살펴보자.

```swift
protocol Eatable {
    var calorie: Int { get }
}

struct Pizza: Eatable {
    var calorie: Int {
        return 300
    }
}
```

1. Constructor Injection (Initializer 생성자 주입)
   initializer 를 통해 dependency 를 파악할 수 있고, 주입받는 인스턴스를 immutable 하게 유지할 수 있다.

```swift
class FoodTruck {
    let food: Eatable

    init(food: Eatable) {
        self.food = food
    }
}

let foodTruck = FoodTruck(food: Pizza())
print(foodTruck.food.calorie) // 300
```

2. Property Injection (저장속성에 주입)
   - 프로퍼티에 직접 접근하여 인스턴스를 주입
   - 편리
   - 생성자 주입과 비교하면 immutable 속성을 유지할 수 없고 중간에 replace 될수 있다는 것에 주의

```swift
class Market {
    var food: Eatable?
}

let market = Market()
market.food = Pizza()
print(market.food?.calorie)
```

3. Method Injection (함수를 통한 주입)
   - 여러 use case 에 따라 매개변수를 달리하여 유연성에 집중할 수 있다

```swift
class HomeMade {
    var food: Eatable?

    func setupFood(_ food: Eatable) {
        self.food = food
    }
}

let homeMade = HomeMade()
homeMade.setupFood(Pizza())
print(homeMade.food?.calorie)
```

---

#### 참고자료

[의존성 주입 3가지 방법](https://eunjin3786.tistory.com/115)
