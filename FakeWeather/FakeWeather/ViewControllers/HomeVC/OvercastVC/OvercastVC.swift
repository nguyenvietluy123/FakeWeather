//
//  OvercastVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/15/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class OvercastVC: UIViewController {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrWeather: [OvercastObj] = []
    var handleAction: ((OvercastObj) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
    }
}

extension OvercastVC {
    func initUI() {
        navi.handleBack = {
            self.navigationController?.popViewController(animated: true)
        }
        
        tableView.separatorColor = .clear
        tableView.register(CellWeather.self)
    }
    
    func initData() {
        var obj = OvercastObj("A Few Clouds And Windy", #imageLiteral(resourceName: "A Few Clouds And Windy"))
        arrWeather.append(obj)
        obj = OvercastObj("Clear", #imageLiteral(resourceName: "Clear"))
        arrWeather.append(obj)
        obj = OvercastObj("Dust", #imageLiteral(resourceName: "Dust"))
        arrWeather.append(obj)
        obj = OvercastObj("Fog", #imageLiteral(resourceName: "A Few Clouds And Windy"))
        arrWeather.append(obj)
        obj = OvercastObj("Freezing Fog", #imageLiteral(resourceName: "Freezing Fog"))
        arrWeather.append(obj)
        obj = OvercastObj("Heavy Rain", #imageLiteral(resourceName: "Heavy Rain"))
        arrWeather.append(obj)
        obj = OvercastObj("Heavy Snow Showers", #imageLiteral(resourceName: "Heavy Snow Showers"))
        arrWeather.append(obj)
        obj = OvercastObj("Heavy Snow", #imageLiteral(resourceName: "Heavy Snow"))
        arrWeather.append(obj)
        obj = OvercastObj("Heavy Thunderstorm Rain", #imageLiteral(resourceName: "Heavy Thunderstorm Rain"))
        arrWeather.append(obj)
        obj = OvercastObj("Heavy Thunderstorm Snow", #imageLiteral(resourceName: "Heavy Thunderstorm Snow"))
        arrWeather.append(obj)
        obj = OvercastObj("Hot", #imageLiteral(resourceName: "hot"))
        arrWeather.append(obj)
        obj = OvercastObj("Mostly Cloud", #imageLiteral(resourceName: "Mostly Cloud"))
        arrWeather.append(obj)
        obj = OvercastObj("Overcast", #imageLiteral(resourceName: "Overcast"))
        arrWeather.append(obj)
        obj = OvercastObj("Partly Cloud", #imageLiteral(resourceName: "Partly Cloud"))
        arrWeather.append(obj)
        obj = OvercastObj("Rain Drop", #imageLiteral(resourceName: "Rain Drop"))
        arrWeather.append(obj)
        obj = OvercastObj("Rain", #imageLiteral(resourceName: "Rain"))
        arrWeather.append(obj)
        obj = OvercastObj("Sandstorm", #imageLiteral(resourceName: "Sandstorm"))
        arrWeather.append(obj)
        obj = OvercastObj("Smoke", #imageLiteral(resourceName: "Smoke"))
        arrWeather.append(obj)
        obj = OvercastObj("Snow Showers", #imageLiteral(resourceName: "Snow Showers"))
        arrWeather.append(obj)
        obj = OvercastObj("Snow", #imageLiteral(resourceName: "snow"))
        arrWeather.append(obj)
        obj = OvercastObj("Storm", #imageLiteral(resourceName: "Storm"))
        arrWeather.append(obj)
        obj = OvercastObj("Sunny", #imageLiteral(resourceName: "Sunny"))
        arrWeather.append(obj)
        obj = OvercastObj("Tornado", #imageLiteral(resourceName: "Tornado"))
        arrWeather.append(obj)
        obj = OvercastObj("Windy", #imageLiteral(resourceName: "Windy"))
        arrWeather.append(obj)
        
    }
}

extension OvercastVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellWeather
        cell.configCell(overcast: arrWeather[indexPath.item])
        return cell
    }
}

extension OvercastVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        handleAction?(arrWeather[indexPath.item])
        self.navigationController?.popViewController(animated: true)
    }
}
