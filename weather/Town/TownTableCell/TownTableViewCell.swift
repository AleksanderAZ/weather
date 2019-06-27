//
//  TownTableViewCell.swift
//  weather
//
//  Created by Z on 6/14/19.
//  Copyright © 2019 Zyma. All rights reserved.
//


import UIKit

class TownTableViewCell: UITableViewCell, TownTableViewCellProtocol {
    
    var presenter: TownTablePresenterCellProtocol?
    weak var townTableViewCellDelegate: TownTableViewCellDelegate?
    
    @IBOutlet weak var tawnLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
        
    @IBAction func openButtonAction(_ sender: UIButton) {
        self.townTableViewCellDelegate?.getIndex(index: presenter?.indexCell)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(text: String, type: Bool, index: Int, delegate: TownTableViewCellDelegate) {
        
        townTableViewCellDelegate = delegate
        presenter?.indexCell = index
        tawnLabel.text = text
        if type {
            openButton.titleLabel?.text = "V"
            openButton.backgroundColor = .red
        }
        else {
            openButton.titleLabel?.text = "^"
            openButton.backgroundColor = .green
        }
    }
}
