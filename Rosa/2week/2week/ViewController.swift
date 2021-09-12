import UIKit

class ViewController: UIViewController {

    private var model: ListViewModelInterface
    
    
    init(model: ListViewModelInterface) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setNavigationItems()
        bindingViews()
    }
    
    //MARK:- Action functions
    @objc func touchedSortMovies() {
        model.sortMovies()
    }
    
    @objc func touchedAddMovie() {
        model.addMovie("크루엘라")
    }
    
    //MARK:- Private functions
    private func bindingViews() {
        model.onUpdated = { [weak self] in
            guard let self = self else { return }
            self.titleLabel.text = self.model.titlesString
            print("model updated!")
        }
        model.reload()
    }
    
    private func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(touchedSortMovies))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(touchedAddMovie))
    }
    
    
    private func setupViews() {
        view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
        ])
    }

    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = .lightGray
        return lb
    }()
}

