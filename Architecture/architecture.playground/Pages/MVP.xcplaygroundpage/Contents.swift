//: [Previous](@previous)

import UIKit

// Model
struct Person {
    let name: String
    let age: Int
}


protocol HelloViewPresenter {
    init(view: HelloView, person: Person)
    func showGreeting()
}


protocol HelloView: class {
    func setHello(hello: String)
}


// Presenter
class HelloPresenter : HelloViewPresenter {
    unowned let view: HelloView
    let person: Person
    required init(view: HelloView, person: Person) {
        self.view = view
        self.person = person
    }
    func showGreeting() { // 1. 뷰 업데이트 지시
        let greeting = "Hello" + " I'm " + self.person.name
            + " " + "\(self.person.age)" + "year's old."
        self.view.setHello(hello: greeting)
    }
}


// View
class HelloViewController : UIViewController, HelloView {
    var presenter: HelloPresenter!
    let button = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.addTarget(self, action: "touchedButton:", for: .touchUpInside)
    }
    
    func touchedButton(button: UIButton) {
        self.presenter.showGreeting()
    }
    
    func setHello(hello: String) {
        self.label.text = hello
    }
    
    // layout code goes here
}



// Assembling of MVP
let model = Person(name: "jin", age: 22)
let view = HelloViewController()
let presenter = HelloPresenter(view: view, person: model)
view.presenter = presenter

//: [Next](@next)
