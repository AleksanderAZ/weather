//
//  TownTableViewCell.swift
//  weather
//
//  Created by Z on 6/14/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
import UIKit

protocol TownTableViewCellDelegate: class {
    func getIndex(index: Int?)  //ShoppingCart
}

class TownTableViewCell: UITableViewCell {
    var presenter: TownTablePresenterCell?
    weak var townTableViewCellDelegate: TownTableViewCellDelegate?
    @IBOutlet weak var tawnLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
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
