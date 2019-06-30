//
//  WeatherTableViewCell.swift
//  weather
//
//  Created by Z on 6/14/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell, WeatherTableViewCellProtocol {
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(text: String) {
        weatherLabel.text = text
    }
}
