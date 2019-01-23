//
//  HistoryVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HistoryVC: UIViewController {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var arrWeather: [WeatherObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initAdmob()
    }
    
    override func viewDidLayoutSubviews() {
        Common.gradient(UIColor.init("ffa45f", alpha: 1.0), UIColor.init("ff8769", alpha: 1.0), view: self.view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

}

extension HistoryVC {
    func initUI() {
        tableView.register(CellHistory.self)
    }
    
    func initAdmob() {
        bannerView.adUnitID = kAdmobBanner
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
    }
    
    func loadData() {
        arrWeather.removeAll()
        arrWeather = weatherManager.getAllWeather()
        tableView.reloadData()
    }
    
}

extension HistoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellHistory
        cell.lbName.text = "\(arrWeather[indexPath.item].country), \(arrWeather[indexPath.item].city)"
        return cell
    }
    
    
}

extension HistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55*heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WeatherVC(nibName: "WeatherVC", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        vc.pushFrom = .historyVC
        vc.weatherObj = arrWeather[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrWeather[indexPath.row].deleteWeather()
            arrWeather.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}

extension HistoryVC: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
}
