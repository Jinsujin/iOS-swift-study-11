import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindUI()
    }

    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindUI() {
        self.textView.text =
        """
        $\(item?.name)
        $\(item?.itemDescription)
        $\(item?.htmlURL)
        """
        
        guard let avatarURLString =  item?.owner.avatarURL,
              let avatarURL = URL(string: avatarURLString) else {
            return
        }
        
        loadImage(url: avatarURL)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { (image) in
                self.imageView.image = image
            }, onCompleted: {
                print("completed")
            }).disposed(by: disposeBag)
    }
    
    
    func loadImage(url: URL) -> Observable<UIImage?> {
        return Observable<UIImage?>.create { emitter in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    emitter.onNext(nil)
                    emitter.onCompleted()
                    return
                }
                let image = UIImage(data: data)
                emitter.onNext(image)
                emitter.onCompleted()
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    private func setupViews() {
        self.view.addSubview(imageView)
        self.view.addSubview(textView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .systemGray6
        tv.textColor = .darkGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .darkGray
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
}
