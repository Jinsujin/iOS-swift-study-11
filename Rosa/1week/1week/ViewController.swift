/**
 - api url
 "https://api.themoviedb.org/3/movie/popular?api_key=e7ca07e4fa0f7ad15fd088cb892fdd79&language=ko-KR"

 
 ViewController
    화면에 그려질 데이터는 모두 ViewModel 에 있다.
    => ViewModel 의 데이터가 변경되었는지 확인하여, 변경되면 화면에 뿌려주는 역할
 
 이벤트가 들어왔을때, ViewModel 에게 요청
 -> ViewModel 은 이 요청을 뷰모델에서 직접 처리하는 것이 아닌, Service 에게 넘겨준다.
 
 */



import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var moviesLabel: UILabel!
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // callback 으로 받아서 UI변경 => UI 와 데이터를 묶어주는 bind 역할
        viewModel.onUpdated = { [weak self] in
            guard let self = self else { return }
            self.moviesLabel.text = self.viewModel.titlesString
        }
        viewModel.reload()
    }
    
    // MARK:- Actions
    @IBAction func touchedSortButton(_ sender: Any) {
        viewModel.sortMovies()
    }
    
    @IBAction func touchedAddButton(_ sender: Any) {
        viewModel.addMovie("크루엘라")
    }
}


