//
//  CellHome.swift
//  FakeWeather
//
//  Created by Luy Nguyen on 1/14/19.
//  Copyright © 2019 Luy Nguyen. All rights reserved.
//

import UIKit

class CellHome: UITableViewCell {
    @IBOutlet weak var lbTitle: KHLabel!
    @IBOutlet weak var tfValue: KHTextField!
    @IBOutlet weak var viewInput: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lbTitle.roundCorners(corners: [.topLeft, .bottomLeft], radius: DeviceType.IS_IPAD ? 18 : 10)
        tfValue.roundCorners(corners: [.topRight, .bottomRight], radius: DeviceType.IS_IPAD ? 18 : 10)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }   
}
