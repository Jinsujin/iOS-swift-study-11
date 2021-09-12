import UIKit

class RootTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navController = UINavigationController(rootViewController: ViewController())
        navController.title = "TAB 1"
    
        
        let navController2 = UINavigationController(rootViewController: ViewController())
        navController2.title = "TAB 2"
        
        self.viewControllers = [navController, navController2]
    }

}
