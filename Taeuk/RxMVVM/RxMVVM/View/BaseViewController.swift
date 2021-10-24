//
//  BaseViewController.swift
//  RxMVVM
//
//  Created by taeuk on 2021/10/08.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        setProperties()
        setBind()
        setConfigure()
        setConstraints()
    }
    
    func setProperties() {}
    func setBind() {}
    func setConstraints() {}
    func setConfigure() {}
    
}
