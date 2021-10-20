//: [Previous](@previous)
import UIKit

struct Person { // Model
    let name: String
    let age: Int
}

// View + Controller
class HelloViewController : UIViewController {
    var person: Person!
    let button = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.addTarget(self, action: #selector(didTapButton), forControlEvents: .TouchUpInside)
    }
    
    @objc func didTapButton() {
        let greeting = "Hello" + " " + self.person.name + ", " + self.person.age
        self.label.text = greeting
        
    }
}

// Assembling of MVC
let model = Person(name: "jin", age: 22)
let view = HelloViewController()
view.person = model;

//: [Next](@next)
