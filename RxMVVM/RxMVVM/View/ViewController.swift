//
//  ViewController.swift
//  RxMVVM
//
//  Created by taeuk on 2021/10/08.
//

import UIKit
import SnapKit

final class ViewController: BaseViewController {

    // MARK: - Properties
    
    private let repoSearchBar: UISearchBar = {
        return $0
    }(UISearchBar())
    
    private let layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var collectionView: UICollectionView = {
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
        
    private let searchViewModel = SearchViewModel(dependency: SearchService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        repoSearchBar.delegate = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

    override func setBind() {
        
        searchViewModel.output.repoList.subscribe { [weak self] _ in
            self?.collectionView.reloadData()
        }.disposed(by: searchViewModel.disposeBag)
    }
    
    override func setConfigure() {
        
        collectionView.backgroundColor = .white
        view.addSubview(repoSearchBar)
        view.addSubview(collectionView)
    }
    
    override func setConstraints() {
        
        repoSearchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(repoSearchBar.snp.bottom)
            $0.bottom.leading.trailing.equalTo(view)
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let keyword = searchBar.text, keyword != "" {
            searchViewModel.input.requestSearchRepo(keyword: keyword)
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.output.repoList.value.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.setUp(text: searchViewModel.output.repoList.value.items[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.size.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
