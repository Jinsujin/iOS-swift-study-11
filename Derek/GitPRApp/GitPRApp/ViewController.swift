//
//  ViewController.swift
//  GitPRApp
//
//  Created by Sh Hong on 2021/10/06.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginBtnTapped(_ sender: UIButton) {
        LoginManager.shared.requestCode()
    }
    
}

