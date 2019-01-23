//
//  WeatherObj.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import CoreData

class WeatherObj: NSObject {
    var id: String = ""
    var country: String = ""
    var city: String = ""
    var temp: String = ""
    var tempHigh: String = ""
    var tempLow: String = ""
    
    var isFavorite: Bool = false
    var background: UIImage = UIImage()
    var typeTemp: TypeTemp = .tempC
    var overcast: OvercastObj = OvercastObj()

    override init() {
        super.init()
    }
    
    init(_ obj: Weather) {
        self.id = obj.id ?? ""
        self.overcast.title = obj.title ?? ""
        if let data = obj.img {
            if let img = UIImage(data: data) {
                self.overcast.img = img
            }
        }
        if let data = obj.background {
            if let img = UIImage(data: data) {
                self.background = img
            }
        }
        self.city = obj.city ?? ""
        self.country = obj.country ?? ""
        self.temp = obj.temp ?? ""
        self.typeTemp = TypeTemp(rawValue: obj.typeTemp ?? "") ?? .tempC
        self.tempHigh = obj.tempHigh ?? ""
        self.tempLow = obj.tempLow ?? ""
        self.isFavorite = obj.isFavorite
    }
}

extension WeatherObj {
    func saveSearchList(_ isMerge: Bool = false) {
        print("save weather list, \(self.id), \(isMerge)")
        let minionManagedObjectContextWorker: NSManagedObjectContext =
            NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        minionManagedObjectContextWorker.parent = mainContextInstance
        
        let weather = NSEntityDescription.insertNewObject(forEntityName: "Weather",
                                                             into: minionManagedObjectContextWorker) as! Weather
        weather.id = self.id
        weather.country = self.country
        weather.city = self.city
        weather.temp = self.temp
        weather.typeTemp = self.typeTemp.rawValue
        weather.tempHigh = self.tempHigh
        weather.tempLow = self.tempLow
        weather.title = self.overcast.title
        weather.isFavorite = self.isFavorite
        weather.img = self.overcast.img.pngData()
        weather.background = self.background.pngData()
        
        persistenceManager.saveWorkerContext(minionManagedObjectContextWorker)
        if isMerge {
            persistenceManager.mergeWithMainContext()
        }
    }
    
    func updateWeather(isFavorite: Bool) {
        if let weather = findWeather() {
            weather.background = self.background.pngData()
            weather.isFavorite = isFavorite
            persistenceManager.mergeWithMainContext()
        }
    }
    
    func deleteWeather() {
        if let weather = findWeather() {
            mainContextInstance.delete(weather)
            persistenceManager.mergeWithMainContext()
        }
    }
    
    func findWeather() -> Weather? {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Weather")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"%K == %@", "id", self.id as CVarArg)
        
        var fetchedResults: Array<Weather> = Array<Weather>()
        
        do {
            fetchedResults = try  mainContextInstance.fetch(fetchRequest) as! [Weather]
        } catch let fetchError as NSError {
            print("retrieveById error: \(fetchError.localizedDescription)")
            fetchedResults = Array<Weather>()
        }
        if fetchedResults.count == 1 {
            return fetchedResults[0]
        }
        return nil
    }
}

