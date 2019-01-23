//
//  WeatherView.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/15/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    @IBOutlet weak var lbTemp: KHLabel!
    @IBOutlet weak var lbTypeTemp: KHLabel!
    @IBOutlet weak var lbTempLow: KHLabel!
    @IBOutlet weak var lbTempHigh: KHLabel!
    @IBOutlet weak var imgOvercast: KHImageView!
    @IBOutlet weak var lbTypeOvercast: KHLabel!
    
    func configView(temp: String, typeTemp: TypeTemp, low: String, high: String, overcast: OvercastObj) {
        lbTemp.text = temp.text
        lbTypeTemp.text = typeTemp == .tempC ? "°C" : "°F"
        lbTempLow.text = low.degree
        lbTempHigh.text = high.degree
        
        imgOvercast.image = overcast.img.withRenderingMode(.alwaysTemplate)
        imgOvercast.tintColor = .white
        lbTypeOvercast.text = overcast.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "WeatherView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
