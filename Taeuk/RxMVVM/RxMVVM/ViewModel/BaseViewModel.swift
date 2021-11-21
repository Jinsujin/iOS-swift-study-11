//
//  BaseViewModel.swift
//  RxMVVM
//
//  Created by taeuk on 2021/10/09.
//

import Foundation
import RxSwift

protocol BaseViewModel {

    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    
    var disposeBag: DisposeBag { get }
}
