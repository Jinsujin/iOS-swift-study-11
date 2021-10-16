//
//  RepoListTableViewController.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/15.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class RepoListTableViewController: UIViewController {

    let viewModel = RepoListViewModel()
    let disposeBag = DisposeBag()
    
    let tableView = UITableView().then { tableView in
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.layer.backgroundColor = UIColor.white.cgColor
        tableView.rowHeight = 100
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        bindUI()
        setupUI()
    }
    
    private func bindUI() {
        viewModel.subject.subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        viewModel.subject.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: TableViewCell.self)) { index, model, cell in
            print(model.fullName)
            cell.titleLabel.text = model.fullName
        }.disposed(by: disposeBag)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

class TableViewCell: UITableViewCell {
    let titleLabel = UILabel().then {
        $0.text = "레포 title"
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "cell")
        
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
        
    }

    private func setupCellUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.height.equalTo(50)
        }
        
    }
}
