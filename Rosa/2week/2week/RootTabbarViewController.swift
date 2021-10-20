import UIKit

class RootTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let model1 = MovieViewModel()
        
        let model2 = YoutubeViewModel()
        
//        let model1 = MovieViewModel()
        let navController = UINavigationController(rootViewController: ViewController(model: model1))
        navController.title = "TAB 1"
    
        
//        let model2 = YoutubeViewModel()
        let navController2 = UINavigationController(rootViewController: ViewController(model: model2))
        navController2.title = "TAB 2"
        
        self.viewControllers = [navController, navController2]
    }

}
