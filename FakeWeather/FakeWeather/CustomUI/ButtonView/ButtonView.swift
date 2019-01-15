//
//  NotificationVC.swift
//  CarZapp
//
//  Created by Pham Khanh Hoa on 9/6/17.
//  Copyright © 2017 SDC. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    @IBOutlet weak var viewStyle1Button: UIView!
    @IBOutlet weak var viewStyle3Button: UIView!
    @IBOutlet weak var viewChild3Button: UIView!
    @IBOutlet weak var btn1Button: KHButton!
    @IBOutlet weak var btn3ButtonLeft: KHButton!
    @IBOutlet weak var btn3ButtonCenter: KHButton!
    @IBOutlet weak var btn3ButtonRight: KHButton!
    
    @IBInspectable open var titleStyle1Button: String = "" {
        didSet {
            btn1Button.setTitle(titleStyle1Button.localized, for: .normal)
        }
    }
    
    @IBInspectable open var style: Int = 1 {
        didSet {
            switch style {
            case 1:
                viewStyle1Button.isHidden = false
                viewStyle3Button.isHidden = true
                break
            case 2:
                viewStyle1Button.isHidden = true
                viewStyle3Button.isHidden = false
                break
            default:
                break
            }
        }
    }
    
    var index: Int = 1 {
        didSet {
            if style == 2 {
                switch index {
                case 1:
                    addGradientLayer(viewSelect: btn3ButtonLeft, view1: btn3ButtonCenter, view2: btn3ButtonRight)
                    break
                case 2:
                    addGradientLayer(viewSelect: btn3ButtonCenter, view1: btn3ButtonLeft, view2: btn3ButtonRight)
                    break
                case 3:
                    addGradientLayer(viewSelect: btn3ButtonRight, view1: btn3ButtonCenter, view2: btn3ButtonLeft)
                    break
                default:
                    break
                }
            }
        }
    }
    
    func addGradientLayer(viewSelect: KHButton, view1: KHButton, view2: KHButton) {
        Common.gradient(UIColor.init("3688d4", alpha: 1.0), UIColor.init("1962ae", alpha: 1.0), view: viewSelect)
        Common.gradient(UIColor.init("FFFFFF", alpha: 1.0), UIColor.init("FFFFFF", alpha: 1.0), view: view1)
        Common.gradient(UIColor.init("FFFFFF", alpha: 1.0), UIColor.init("FFFFFF", alpha: 1.0), view: view2)
        
        for layer in view1.layer.sublayers! {
            if(layer.name == "gradientLayer"){
                layer.removeFromSuperlayer()
            }
        }
        
        for layer in view2.layer.sublayers! {
            if(layer.name == "gradientLayer"){
                layer.removeFromSuperlayer()
            }
        }
        
        viewSelect.setTitleColor(.white, for: .normal)
        view1.setTitleColor(.black, for: .normal)
        view2.setTitleColor(.black, for: .normal)
    }
    
    var handleStyle1Button: (() -> Void)?
    var handle3ButtonLeft: (() -> Void)?
    var handle3ButtonCenter: (() -> Void)?
    var handle3ButtonRight: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "ButtonView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height && ctr.constant > 0 {
                if DeviceType.IS_IPAD {
                    ctr.constant = 80*1.2
                } else {
                    ctr.constant = 80*ScreenSize.SCREEN_HEIGHT/736
                }
            }
        }
        
        GCDCommon.mainQueue {
            Common.gradient(UIColor.init("3688d4", alpha: 1.0), UIColor.init("1962ae", alpha: 1.0), view: self.viewChild3Button)
            self.addGradientLayer(viewSelect: self.btn3ButtonLeft, view1: self.btn3ButtonCenter, view2: self.btn3ButtonRight)
        }
        
    }
    
    
    @IBAction func actionStyle1Button(_ sender: Any) {
        handleStyle1Button?()
    }

    @IBAction func action3ButtonLeft(_ sender: Any) {
        index = 1
        handle3ButtonLeft?()
    }
    
    @IBAction func action3ButtonCenter(_ sender: Any) {
        index = 2
        handle3ButtonCenter?()
    }
    
    @IBAction func action3ButtonRight(_ sender: Any) {
        index = 3
        handle3ButtonRight?()
    }
}
