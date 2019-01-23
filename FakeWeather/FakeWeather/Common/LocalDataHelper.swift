//
//  LocalDataHelper.swift
//  HMKFieldCollector
//
//  Created by Hoa on 11/23/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit
import CoreLocation

class LocalDataHelper: NSObject {
    static let shared = LocalDataHelper()

    var weatherList: [WeatherObj] = []
    
    override init() {
        super.init()
    }
    
    func getWeatherList() {
        weatherList.removeAll()
        weatherList = weatherManager.getAllWeather()
    }
}

let localDataShared = LocalDataHelper.shared

