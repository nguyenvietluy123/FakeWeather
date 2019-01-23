//
//  FavoriteVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/16/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    @IBOutlet weak var navi: NavigationView!
    @IBOutlet weak var tableView: UITableView!
    
    var arrWeather: [WeatherObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        Common.gradient(UIColor.init("ffa45f", alpha: 1.0), UIColor.init("ff8769", alpha: 1.0), view: self.view)
    }
}

extension FavoriteVC {
    func initUI() {
        navi.handleBack = {
            self.navigationController?.popViewController(animated: true)
        }
        tableView.register(CellHistory.self)
    }
    
    func loadData() {
        arrWeather.removeAll()
        let arrData = weatherManager.getAllWeather()
        for i in arrData.indices {
            if arrData[i].isFavorite {
                arrWeather.append(arrData[i])
            }
        }
        tableView.reloadData()
    }
    
}

extension FavoriteVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellHistory
        cell.lbName.text = "\(arrWeather[indexPath.item].country), \(arrWeather[indexPath.item].city)"
        return cell
    }
}

extension FavoriteVC: UITableViewDelegate {
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
