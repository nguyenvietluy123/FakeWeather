//
//  MenuObj.swift
//  Carenefit
//
//  Created by Hoa Phan on 9/14/17.
//  Copyright © 2017 sdc. All rights reserved.
//

import UIKit

class NavigationView: UIView {
    @IBOutlet weak var lbTitleNav: KHLabel!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var imgLeft: KHImageView!
    
    @IBInspectable open var title: String = "" {
        didSet {
            lbTitleNav.text = title.localized
        }
    }
    
    @IBInspectable open var hasLeft: Bool = false {
        didSet {
            viewLeft.isHidden = !hasLeft
        }
    }
    
    @IBInspectable open var hasCancel: Bool = false {
        didSet {
            imgLeft.image = hasCancel ? #imageLiteral(resourceName: "navi_cancel") : #imageLiteral(resourceName: "Rain")
        }
    }
    
    var handleBack: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "NavigationView" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for ctr in self.constraints {
            if ctr.firstAttribute == .height {
                if DeviceType.IS_IPAD {
                    ctr.constant = 85
                } else if DeviceType.IS_IPHONE_X {
                    ctr.constant = 49 + UIApplication.shared.statusBarFrame.height
                } else {
                    ctr.constant = 69*ScreenSize.SCREEN_HEIGHT/736
                }
            }
        }
        GCDCommon.mainQueue {
            Common.gradient(UIColor.init("3687d3", alpha: 1.0), UIColor.init("1963af", alpha: 1.0), view: self)
        }
    }
    
    @IBAction func actionLeft(_ sender: Any) {
        handleBack?()
    }

}
