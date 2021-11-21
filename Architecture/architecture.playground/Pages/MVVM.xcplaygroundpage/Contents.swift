//: [Previous](@previous)

import UIKit

// Model
struct Person {
    let name: String
    let age: Int
}

protocol ViewModelProtocol: class {
    var hello: String? { get }
    var helloDidChange: ((ViewModelProtocol) -> ())? { get set }
    init(person: Person)
    func showHello()
}

// ViewModel
class ViewModel : ViewModelProtocol {
    let person: Person
    var hello: String? {
        didSet {
            self.helloDidChange?(self)
        }
    }
    var helloDidChange: ((ViewModelProtocol) -> ())?
    required init(person: Person) {
        self.person = person
    }
    func showHello() {
        self.hello = "Hello" + " I'm " + self.person.name
    }
}

// View
class HelloViewController : UIViewController {
    var viewModel: ViewModelProtocol! {
        didSet {
            self.viewModel.helloDidChange = { [unowned self] viewModel in
                self.label.text = viewModel.hello
            }
        }
    }
    let button = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.addTarget(self.viewModel, action: "showHello", for: .touchUpInside)
    }
    // ...
}

// Assembling of MVVM
let model = Person(name: "jin", age: 22)
let viewModel = ViewModel(person: model)
let view = HelloViewController()
view.viewModel = viewModel

//: [Next](@next)
