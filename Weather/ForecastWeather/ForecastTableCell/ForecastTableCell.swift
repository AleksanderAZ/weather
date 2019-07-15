//
//  ForecastTableCell.swift
//  weather
//
//  Created by Z on 7/15/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import UIKit

class ForecastTableCell: UITableViewCell {

    @IBOutlet weak var forecastInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
