//
//  HomeVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeVC: UIViewController {
    @IBOutlet weak var inputCountry: InputView!
    @IBOutlet weak var inputCity: InputView!
    @IBOutlet weak var inputTemp: InputView!
    @IBOutlet weak var selectTypeTemp: InputView!
    @IBOutlet weak var inputHighTemp: InputView!
    @IBOutlet weak var inputLowTemp: InputView!
    @IBOutlet weak var inputOvercast: InputView!
    @IBOutlet weak var buttonView: ButtonView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    var interstitial: GADInterstitial!
    var weatherObj: WeatherObj = WeatherObj()
    var arrBackgrounds: [UIImage] = [#imageLiteral(resourceName: "bg"), #imageLiteral(resourceName: "bg1"), #imageLiteral(resourceName: "bg9"), #imageLiteral(resourceName: "bg8"), #imageLiteral(resourceName: "bg13"), #imageLiteral(resourceName: "offline_imagexxx37"), #imageLiteral(resourceName: "bg16"), #imageLiteral(resourceName: "bg2"), #imageLiteral(resourceName: "bg7"), #imageLiteral(resourceName: "bg12"), #imageLiteral(resourceName: "bg4"), #imageLiteral(resourceName: "offline_imagexxx13_compressed"), #imageLiteral(resourceName: "bg5"), #imageLiteral(resourceName: "offline_imagexxx3"), #imageLiteral(resourceName: "bg3"), #imageLiteral(resourceName: "bg10"), #imageLiteral(resourceName: "Moon"), #imageLiteral(resourceName: "bg11"), #imageLiteral(resourceName: "Sea"), #imageLiteral(resourceName: "Waves"), #imageLiteral(resourceName: "bg6")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initAdmob()
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
            self.weatherObj.temp = self.inputTemp.tfValue.text!
            self.weatherObj.tempHigh = self.inputHighTemp.tfValue.text!
            self.weatherObj.tempLow = self.inputLowTemp.tfValue.text!
            
            if self.isValid() {
                self.weatherObj.id = self.generateId()
                if let img = self.arrBackgrounds.randomElement() {
                    self.weatherObj.background = img
                }
                let vc = WeatherVC.init(nibName: "WeatherVC", bundle: nil)
                vc.hidesBottomBarWhenPushed = true
                self.weatherObj.saveSearchList(true)
                vc.weatherObj = self.weatherObj
                vc.handleBack = {
                    TAppDelegate.tabVC?.tabBar.isHidden = false
                    if self.interstitial.isReady {
//                        self.interstitial.present(fromRootViewController: self)
                    }
                    self.weatherObj.country = ""
                    self.weatherObj.city = ""
                    self.weatherObj.temp = ""
                    self.weatherObj.tempHigh = ""
                    self.weatherObj.tempLow = ""
                    self.weatherObj.overcast = OvercastObj()
                    self.inputCountry.tfValue.text = ""
                    self.inputCity.tfValue.text = ""
                    self.inputTemp.tfValue.text = ""
                    self.selectTypeTemp.actionTempC(self.buttonView)
                    self.inputHighTemp.tfValue.text = ""
                    self.inputLowTemp.tfValue.text = ""
                    self.inputOvercast.tfValue.text = ""
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        selectTypeTemp.handleTypeTemp = { (typeTemp) in
            self.weatherObj.typeTemp = typeTemp
        }
        
        inputOvercast.handleSelectItem = {
            self.view.endEditing(true)
            let vc = OvercastVC.init(nibName: "OvercastVC", bundle: nil)
            vc.handleAction = { (overcast) in
                self.weatherObj.overcast = overcast
                self.inputOvercast.tfValue.text = overcast.title
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func initAdmob() {
        bannerView.adUnitID = kAdmobBanner
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())

        interstitial = createAndLoadInterstitial()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        interstitial = GADInterstitial(adUnitID: kAdmobInterstitial)
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func isValid() -> Bool {
        self.view.endEditing(true)
        if weatherObj.country.count == 0 {
            Common.showAlert("Please type 'Country'")
            return false
        }
        if weatherObj.city.count == 0 {
            Common.showAlert("Please type 'City'")
            return false
        }
        if weatherObj.temp.count == 0 {
            Common.showAlert("Please type 'Temperature'")
            return false
        }
        if weatherObj.tempHigh.count == 0 {
            Common.showAlert("Please type 'High T°'")
            return false
        }
        if weatherObj.tempLow.count == 0 {
            Common.showAlert("Please type 'Low T°'")
            return false
        }
        if weatherObj.tempHigh.isnumberordouble == false {
            Common.showAlert("'High T°' must be a number")
            return false
        }
        if weatherObj.tempLow.isnumberordouble == false {
            Common.showAlert("'Low T°' must be a number")
            return false
        }
        if (Double(weatherObj.tempLow)! > Double(weatherObj.tempHigh)!) {
            Common.showAlert("'Low T°' can't greater than 'High T°'. Please type again.")
            return false
        }
        if weatherObj.overcast.title.count == 0 {
            Common.showAlert("Please select 'Overcast'")
            return false
        }
        return true
    }
    
    func generateId() -> String {
        return NSUUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
}

extension HomeVC: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
}

extension HomeVC : GADInterstitialDelegate {
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        TAppDelegate.tabVC?.tabBar.isHidden = false
        self.view.layoutSubviews()
        interstitial = createAndLoadInterstitial()
    }
}
