//
//  HomeVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
//    @IBOutlet weak var viewCountry: InputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func viewDidLayoutSubviews() {
        Common.gradient(UIColor.init("ffa45f", alpha: 1.0), UIColor.init("ff8769", alpha: 1.0), view: self.view)
    }
}

extension HomeVC {
    func initUI() {
    }
    
    func initData() {
        
    }
}

