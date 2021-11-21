//
//  LoginViewController.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/16.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {

    let loginBtn = UIButton(type: .system).then {
        $0.setTitle("Login", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(requestRepo), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // backgound color
        view.backgroundColor = .white
        
        setUpUI()
    }

    func setUpUI() {
        view.addSubview(loginBtn)
        
        loginBtn.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    
    @objc func requestRepo() {
        LoginManager.shared.requestCode()
    }
}
