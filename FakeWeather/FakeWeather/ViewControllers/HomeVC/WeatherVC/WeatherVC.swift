//
//  WeatherVC.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/15/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit
import Agrume

class WeatherVC: UIViewController {
    @IBOutlet weak var viewBack: KHView!
    @IBOutlet weak var bgView: KHImageView!
    @IBOutlet weak var lbCountry: KHLabel!
    @IBOutlet weak var lbCity: KHLabel!
    @IBOutlet weak var lbDate: KHLabel!
    @IBOutlet weak var weatherView: WeatherView!
    @IBOutlet weak var buttonView: ButtonView!
    @IBOutlet weak var ctrTopCountry: NSLayoutConstraint!
    
    var weatherObj: WeatherObj = WeatherObj()
    var pushFrom: PushFrom = .homeVC
    var arrBackgrounds: [UIImage] = [#imageLiteral(resourceName: "bg"), #imageLiteral(resourceName: "bg1"), #imageLiteral(resourceName: "bg9"), #imageLiteral(resourceName: "bg8"), #imageLiteral(resourceName: "bg13"), #imageLiteral(resourceName: "offline_imagexxx37"), #imageLiteral(resourceName: "bg16"), #imageLiteral(resourceName: "bg2"), #imageLiteral(resourceName: "bg7"), #imageLiteral(resourceName: "bg12"), #imageLiteral(resourceName: "bg4"), #imageLiteral(resourceName: "offline_imagexxx13_compressed"), #imageLiteral(resourceName: "bg5"), #imageLiteral(resourceName: "offline_imagexxx3"), #imageLiteral(resourceName: "bg3"), #imageLiteral(resourceName: "bg10"), #imageLiteral(resourceName: "Moon"), #imageLiteral(resourceName: "bg11"), #imageLiteral(resourceName: "Sea"), #imageLiteral(resourceName: "Waves"), #imageLiteral(resourceName: "bg6")]
    var camera: CameraHelper? = nil
    var handleBack: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        TAppDelegate.tabVC?.tabBar.isHidden = true
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        TAppDelegate.tabVC?.tabBar.isHidden = false
//    }
    
    @IBAction func actionBack(_ sender: Any) {
        handleBack?()
        self.navigationController?.popViewController(animated: true)
    }
}

extension WeatherVC {
    func initUI() {
        ctrTopCountry.constant = DeviceType.IS_IPHONE_X ? 10 : 0
        buttonView.isHidden = pushFrom == .historyVC
        bgView.image = weatherObj.background
        lbCity.text = weatherObj.city.text
        lbCountry.text = weatherObj.country.text
        lbDate.text = Date().startDate.secondsSince1970.timeZone.date("EEEE, MMM d, yyyy")
        weatherView.configView(temp: weatherObj.temp, typeTemp: weatherObj.typeTemp, low: weatherObj.tempLow, high: weatherObj.tempHigh, overcast: weatherObj.overcast)
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(slideImage))
        gesture.direction = .left
        self.view.addGestureRecognizer(gesture)
        
        buttonView.handle3ButtonLeft = {
            self.actionAddPhoto()
        }
        
        buttonView.handle3ButtonCenter = {
            self.actionFavorite()
        }
        
        buttonView.handle3ButtonRight = {
            self.actionSharing()
        }
        
    }
    
    func actionAddPhoto() {
        self.view.endEditing(true)
        if camera == nil {
            camera = CameraHelper(delegate_: self)
        }
        _ = UIAlertController.present(style: .actionSheet, title: "Select from:", message: nil, attributedActionTitles: [("Camera", .default), ("Library", .default), ("Cancel", .cancel)], handler: { (action) in
            
            if action.title == "Camera" {
                self.camera?.getCameraOn(self, canEdit: false)
//                let vc = CameraVC.init(nibName: "CameraVC", bundle: nil)
//                self.present(vc, animated: true, completion: nil)
            } else if action.title == "Library" {
                self.camera?.getPhotoLibraryOn(self, canEdit: false)
            }
        })
    }
    
    func actionFavorite() {
        weatherObj.isFavorite = true
        updateBackgroundImage()
        Common.showAlert("This weather is Favorited")
    }
    
    func actionSharing() {
        viewBack.isHidden = true
        buttonView.isHidden = true
        
        let imageView = UIImageView()
        imageView.image = UIApplication.shared.screenShot
        let imageShare = [ imageView.image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
        viewBack.isHidden = false
        buttonView.isHidden = false
    }
    
    @objc func slideImage() {
        if pushFrom == .homeVC {
            bgView.image = arrBackgrounds.randomElement()
            updateBackgroundImage()
        }
    }
    
    func updateBackgroundImage() {
        weatherObj.background = bgView.image ?? UIImage()
        weatherObj.updateWeather(isFavorite: weatherObj.isFavorite)
    }
}

extension WeatherVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            GCDCommon.progressTaskInBackground {
                let image = pickedImage.resizeImage(CGSize(width: 1024, height: 1024))
                GCDCommon.mainQueue {
                    self.bgView.image = image
                    self.updateBackgroundImage()
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
