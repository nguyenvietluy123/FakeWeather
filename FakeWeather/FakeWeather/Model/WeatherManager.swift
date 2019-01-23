//
//  WeatherManager.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/16/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import UserNotifications

class WeatherManager {
    static let sharedInstance = WeatherManager()
    var arrSearch: [WeatherObj] = []
    
    init() {
    }
    
    func getAllWeather() -> [WeatherObj] {
        var fetchedResults: Array<Weather> = Array<Weather>()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Weather")
        do {
            fetchedResults = try  mainContextInstance.fetch(fetchRequest) as! [Weather]
        } catch let fetchError as NSError {
            print("retrieveById error: \(fetchError.localizedDescription)")
            fetchedResults = Array<Weather>()
        }
        var result: [WeatherObj] = []
        for fetch in fetchedResults {
            let obj: WeatherObj = WeatherObj(fetch)
            result.append(obj)
        }
        return result.sorted(by: { (obj1, obj2) -> Bool in
            obj1.country.localizedCaseInsensitiveCompare(obj2.country) == .orderedAscending
        })
    }
    
    func loadLocalData() {
        arrSearch = self.getAllWeather()
    }
}

let weatherManager = WeatherManager.sharedInstance

