//
//  CellMenu.swift
//  HMKFieldCollector
//
//  Created by Luy Nguyen on 11/7/18.
//  Copyright © 2018 Hoa. All rights reserved.
//

import UIKit

class CellWeather: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CellWeather {
    func configCell(overcast: OvercastObj) {
        self.title.text = overcast.title
        self.imgView.image = overcast.img
    }
}

