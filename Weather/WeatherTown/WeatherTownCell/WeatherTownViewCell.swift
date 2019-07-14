//
//  TableViewCell.swift
//  weather
//
//  Created by Z on 7/5/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import UIKit

class WeatherTownViewCell: UITableViewCell {
    var presenter: WeatherTownPresenterCell?
    weak var townTableViewCellDelegate: WeatherTownTableViewCellDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temprLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func openButtonAction(_ sender: UIButton) {
        self.townTableViewCellDelegate?.getIndex(index: presenter?.indexCell)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
