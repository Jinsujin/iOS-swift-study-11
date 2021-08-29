//
//  ViewController.swift
//  ReferenceType
//
//  Created by jsj on 2021/08/29.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var mainViewController: MainViewController? = MainViewController()
        mainViewController = nil
    }
}


// MARK:- MainViewController
class MainViewController: ChildDelegate {

    let childVC: ChildView?
    
    init() {
        print("MainViewController 생성")
        
        // ChildViewController, MainViewController 가 강한 참조를 하게 됨
        childVC = ChildView()
        childVC?.delegate = self
        childVC?.blabla()
    }
    
    deinit {
        print("MainViewController 소멸")
    }
    
    // delegate function
    func somePrint() {
        // ChildView 에서 event가 일어났을때 작업
    }
}


//MARK:- ChildView
protocol ChildDelegate {
    func somePrint()
}

// 해결: class protocol 적용
//protocol ChildDelegate: class {
//    func somePrint()
//}

class ChildView: UIView {
    // strong reference
    var delegate: ChildDelegate?
    
    // 해결: weak reference
//    weak var delegate: ChildDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("ChildView 생성")
    }
    
    deinit {
        print("ChildView 소멸")
    }
    
    func blabla() {
        print("print blabla")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


