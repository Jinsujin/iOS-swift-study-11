//
//  ViewController.swift
//  1week
//
//  Created by jsj on 2021/08/30.
//

import UIKit

/**
 - api url
 "https://api.themoviedb.org/3/movie/popular?api_key=e7ca07e4fa0f7ad15fd088cb892fdd79&language=ko-KR"
 
 */

class ViewController: UIViewController {

    @IBOutlet weak var moviesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchedLoadButton(_ sender: Any) {
        let dbdata = DBData()
        self.moviesLabel.text = dbdata.datas.compactMap({ $0.title }).joined(separator: ",")
    }
}


