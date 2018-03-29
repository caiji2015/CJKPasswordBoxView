//
//  ViewController.swift
//  Demo
//
//  Created by 蔡吉 on 2018/3/29.
//  Copyright © 2018年 caiji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var showLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }

    func setupUI(){
        let passwordBoxView = CJKPasswordBoxView(frame: CGRect(x: 0, y: 0, width: 245, height: 40), digit: 6, isSecure: true, spacing: 1, borderColor: .black, borderWidth: 1, cornerRadius: 2) {[weak self] (password) in
            self?.showLabel.text = password
        }
        passwordBoxView.center = view.center
        view.addSubview(passwordBoxView)
    }
}

