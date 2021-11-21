//
//  RepositoryListViewController.swift
//  GitHubRepoApp
//
//  Created by Sh Hong on 2021/11/18.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class RepositoryListViewController: UITableViewController {
    
    // MARK: - Properties
    private let organization = "Apple"
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = organization + "Repository"
        
        self.refreshControl = UIRefreshControl().then {
            $0.backgroundColor = .white
            $0.tintColor = .darkGray
            $0.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
            $0.addTarget(self, action: #selector(hadleRefresh), for: .valueChanged)
        }
        
        tableView.register(RepositoryListCell.self)
        tableView.rowHeight = 140
    }
    
    // MARK: - Handlers
    @objc func hadleRefresh() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.fetchRepositories(of: self.organization)
        }
    }
    
    func fetchRepositories(of organiztion: String) {
        // 왜 From으로 받았는지? of나 just로 받아도 되지 않았을까?
        // 한번에 여러개를 받을 수 있나?
        Observable.from([organiztion])
            .map { organiztion -> URL in
                return URL(string: "https://api.github.com/orgs/\(organiztion)/repos")!
            }
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = "get"
                return request
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse, data: Data)> in
                return URLSession.shared.rx.response(request: request)
            }
            .filter { response, _ in
                return 200..<300 ~= response.statusCode
            }
            .map { _, data -> [[String: Any]] in
                guard
                    let json = try? JSONSerialization.jsonObject(with: data, options: []),
                    let result = json as? [[String: Any]] else { return [] }
                return result
            }
            .filter { result in
                return result.count > 0
            }.map { objects in
                // compactMap을 사용하는 이유는 nil값을 제거하기 위함이다.
                return objects.compactMap { dic -> Repository? in
                    guard
                        let id = dic["id"] as? Int,
                        let name = dic["name"] as? String,
                        let description = dic["description"] as? String,
                        let stargazersCount = dic["stargazers_count"] as? Int,
                        let language = dic["language"] as? String else { return nil}
                    
                    return Repository(id: id, name: name, description: description, stargazersCount: stargazersCount, language: language)
                }
            }
            .subscribe(onNext: { [weak self] newRepositories in
                self?.repositories.onNext(newRepositories)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableView DataSource Delegate
extension RepositoryListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositories.value().count
        } catch {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        var currentRepo: Repository? {
            do {
                return try repositories.value()[indexPath.row]
            } catch {
                return nil
            }
        }
        
        cell.repository = currentRepo
        
        return cell
    }
}
