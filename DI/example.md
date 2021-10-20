# DIP (Dependency Inversion Principle)

- class 간에 의존성 부패(Dependency Rot)을 제거하기 위한 일반적인 디자인 방법
- classA ---> 추상화된것 <--- classB
  A, B 모두 추상화된것에 의존해야 한다. (A->B)로의 의존성을 끊는다.

## 1. 의존성이 있는 기존 코드 형태

Handle은 FileSystemManager 에 의존하고 있다.

```swift
class Handle {
    let fm = FileSystemManager()

    func handle(str: String) {
        fm.save(string: str)
    }
}

// FileSystemManager는 어디에도 의존하고 있지 않기때문에, 재사용 가능하다
class FileSystemManager {
    func save(string: String) {

    }
}
```

## 2. 인터페이스를 통해 추상화된것을 A, B 가 의존하게 한다

Handler 는 FileSystemManager와 직접적인 영향이 없어졌다.

```swift

// 다음과 같이 Layer 가 분리된다.
// Handler -----> StorageInterface
//                      |
//    FileSystemManager / DatabaseManager
protocol StorageInterface {
    func save(string: String)
}

class Handle {
    let storage: StorageInterface

    init(storage: StorageInterface) {
        self.storage = storage
    }

    func handle(str: String) {
        storage.save(string: str)
    }
}

// StorageInterface
class FileSystemManager: StorageInterface {
    func save(string: String) {
        // 파일 저장
    }
}

class DatabaseSystemManager: StorageInterface {
    func save(string: String) {
        // DB 저장
    }
}
```

---

#### 참고자료

[의존성 주입](https://lidium.tistory.com/34)
