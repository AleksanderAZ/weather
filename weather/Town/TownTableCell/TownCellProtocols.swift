
//
//  TownCellProtocols.swift
//  weather
//
//  Created by Z on 6/17/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

protocol TownCellWireframeProtocol {
    
}

protocol TownTableViewCellDelegate: class {
    func getIndex(index: Int?)  //ShoppingCart
}

protocol TownTableViewCellProtocol: class {
    var presenter: TownTablePresenterCellProtocol?  { get set }
    func configCell(town: String, info: String, type: Bool, index: Int, delegate: TownTableViewCellDelegate)
}

protocol TownTablePresenterCellProtocol: class {
    var indexCell: Int? {get set}
}

protocol TownTableCellInteractorProtocol: class {
    var presenter: TownTablePresenterCellProtocol? {get set}
}


