# 프로젝트 소개

DI 를 적용해 이전에 만든 [week1 프로젝트](../1week/)를 리펙토링 하였습니다.

## 의존성 주입

Constructor Injection(생성자 주입) 을 사용해, 뷰컨트롤러에서 사용할 ViewModel 을 주입해 주었다.

사용되는 뷰 모델은 2개 이며, **ListViewModelInterface** 를 채택하였다.
이 ViewModel들을 사용하는 뷰 컨트롤러 에서는 초기화할때 다음과 같이 모델을 주입받는다:

```swift
init(model: ListViewModelInterface) {...}
```

RootTabbarViewController.swift 파일에서 객체생성은 다음과 같다:

```swift
// viewDidLoad
let model1 = MovieViewModel()
let navController = UINavigationController(rootViewController: ViewController(model: model1))
```

ViewModel 만 바꿔 끼워주면, 뷰컨트롤러를 재사용 할 수 있다는 점이 장점인것 같다.

# 폴더 구조

아키텍쳐는 week1 프로젝트와 별반 다름이 없다.
Mocks 가 추가된것 뿐이다.

## Mocks

데이터가 들어있는 json 파일. 데이터베이스 대용으로 임시로 사용.

## Entity(Data)

서버 API 또는 로컬 DB에서 가져온 원본 데이터 모델.

## Model(Data)

로직(Service) 에서 다루어질 실질적 데이터

## ViewModel(Data)

뷰에서 보여주는 데이터이다.

뷰에서 보여야 하는 데이터인 **titlesString** 이 변경되면(didSet) **onUpdated** 를 호출한다.
**onUpdated** 는 뷰와 바인딩 되어 있는 클로저를 저장하고, 이벤트 발생시 이 클로저를 실행한다.

```swift
var titlesString: String = "" {
    didSet {
        onUpdated()
    }
}
var onUpdated: (() -> Void) = {}
```

## View(ViewController)

화면을 담당한다.
ViewModel 과 바인딩 하여 ViewModel 이 변경되면, 변경 사항을 화면에 업데이트 한다.
ViewModel 의 **onUpdated** 호출시 ViewModel에 있는 데이터를 View 의 Label에 넣는다.

```swift
model.onUpdated = { [weak self] in
    guard let self = self else { return }
    self.titleLabel.text = self.model.titlesString
    print("model updated!")
}
```

## Service

어플리케이션의 핵심 비지니스 로직을 수행

## Repository

Entity 를 서버나 로컬 DB에서 fetch 하는 역할.

재사용을 위해 인자로 받은 타입에 따라 Entity모델로 변환하였다.

```swift
func fetch<T: MappingInterface>(type: T.Type, filename: String) -> [T.EntityType] {
```

이를 Service 에서 다음과 같이 사용한다:

```swift
let datas = repository.fetch(type: MovieModel.self, filename: "mock")
```
