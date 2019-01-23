//
//  OvercastObj.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/15/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class OvercastObj: NSObject {
    var title: String = ""
    var img: UIImage = UIImage()
    
    override init() {
        super.init()
    }
    
    init(_ title: String, _ img: UIImage) {
        self.title = title
        self.img = img
    }
}
