import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let cellId = "mycell"

    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }


    @IBAction func touchedFetchButton(_ sender: Any) {
        viewModel.fetchData()
    }
    
    private func bindUI() {
        viewModel.subject
        .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: ItemCell.self)) { index, model, cell in
            cell.setData(model)
        }.disposed(by: disposeBag)
    }
    
}

// MARK:- ItemCell
class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLable: UILabel!
    
    func setData(_ data: Item) {
        self.titleLable.text = data.name
    }
}
