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
    
    func configCell(town: String, tempr: String, infoFull: String, type: Bool, index: Int, delegate: TownTableViewCellDelegate) {
        townTableViewCellDelegate = delegate
        presenter?.indexCell = index
        
 //       let fontSize = tawnLabel.font.pointSize
 //       let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize) ]
  //      let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize) ]
  //      let townAttrString = NSAttributedString(string: town, attributes: boldAttribute)
  //      let infoAttrString = NSAttributedString(string: info, attributes: attribute)
  //      let text = NSMutableAttributedString()
        
 //       text.append(townAttrString)
 //       text.append(infoAttrString)
        
        if type {
            openButton.backgroundColor = .red
            tawnLabel.text = town + " " + tempr + " " + infoFull
        }
        else {
            openButton.backgroundColor = .green
            tawnLabel.text = town + " " + tempr
        }
    }
    
}
