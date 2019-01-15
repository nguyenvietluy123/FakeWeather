//
//  HomeVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var inputCountry: InputView!
    @IBOutlet weak var inputCity: InputView!
    @IBOutlet weak var inputTemp: InputView!
    @IBOutlet weak var inputHighTemp: InputView!
    @IBOutlet weak var inputLowTemp: InputView!
    @IBOutlet weak var inputOvercast: InputView!
    @IBOutlet weak var buttonView: ButtonView!
    
    var weatherObj: WeatherObj = WeatherObj()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
    
    override func viewDidLayoutSubviews() {
        Common.gradient(UIColor.init("ffa45f", alpha: 1.0), UIColor.init("ff8769", alpha: 1.0), view: self.view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension HomeVC {
    func initUI() {
        buttonView.handleStyle1Button = {
            self.weatherObj.country = self.inputCountry.tfValue.text!
            self.weatherObj.city = self.inputCity.tfValue.text!
            self.inputTemp.handleTypeTemp = { (typeTemp) in
                self.weatherObj.typeTemp = typeTemp
            }
            self.weatherObj.tempHigh = self.inputHighTemp.tfValue.text!
            self.weatherObj.tempLow = self.inputLowTemp.tfValue.text!
            
            let vc = WeatherVC.init(nibName: "WeatherVC", bundle: nil)
            vc.weatherObj = self.weatherObj
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        inputOvercast.handleSelectItem = {
            let vc = OvercastVC
        }
        
    }
    
    
    func initData() {
        
    }
}

