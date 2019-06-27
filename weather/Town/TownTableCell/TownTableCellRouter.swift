//
//  TownTableCellRouter.swift
//  weather
//
//  Created by Z on 6/17/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation


import UIKit

class TownCellRouter: TownCellWireframeProtocol {
    
    weak var viewCell: UITableViewCell?
    
    static func createModule(_ tableView: UITableView, indexPath: IndexPath)->UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"TownTableViewCell", for: indexPath) as! TownTableViewCell

        let router = TownCellRouter()
        let interactor = TownTableCellInteractor()
        
        
        let presenter = TownTablePresenterCell(interface: (cell as TownTableViewCellProtocol), interactor: interactor, router: router)
        
        cell.presenter = presenter
        interactor.presenter = presenter
        router.viewCell = cell
        
        return cell
    }
}

