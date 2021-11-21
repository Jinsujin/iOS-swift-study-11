import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let cellId = "mycell"

    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
    }

    @IBAction func touchedLoginButton(_ sender: Any) {
        viewModel.login()
    }
    
    @IBAction func touchedFetchButton(_ sender: Any) {
        viewModel.fetchData()
    }
    
    private func bindUI() {
        viewModel.subject
        .bind(to: tableView.rx.items(cellIdentifier: cellId, cellType: ItemCell.self)) { index, model, cell in
            cell.setData(model)
        }.disposed(by: disposeBag)
        
        
        self.tableView.rx.modelSelected(Item.self)
            .subscribe(onNext: { item in
                print(item.owner)
                
                let vc = DetailViewController(item: item)
                self.present(vc, animated: false, completion: nil)
            })
            .disposed(by: disposeBag)
        
        // zip 으로 선택한 셀의 model + indexPath 가져오기
//        Observable.zip(tableView.rx.modelSelected(Item.self), tableView.rx.itemSelected)
//            .bind {[weak self] (item, indexPath) in
//                self?.tableView.deselectRow(at: indexPath, animated: true)
//                print(item.name, indexPath)
//            } .disposed(by: disposeBag)
    }
    
}

// MARK:- ItemCell
class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLable: UILabel!
    
    func setData(_ data: Item) {
        self.titleLable.text = data.name
    }
}
