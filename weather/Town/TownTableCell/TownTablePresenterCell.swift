//
//  TownTablePresenterCell.swift
//  weather
//
//  Created by Z on 6/14/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

class TownTablePresenterCell: TownTablePresenterCellProtocol {
    
    private var index: Int?

    var indexCell: Int? {
        get {
            return index
        }
        set {
            index = newValue
        }
    }
    
    weak private var cell: TownTableViewCellProtocol?
    var interactor: TownTableCellInteractorProtocol?
    private let router: TownCellWireframeProtocol
    
    init(interface: TownTableViewCellProtocol, interactor: TownTableCellInteractorProtocol?, router: TownCellWireframeProtocol) {
        self.cell = interface
        self.interactor = interactor
        self.router = router
    }
    
    
}
