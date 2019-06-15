//
//  TownPresenter.swift
//  weather
//
//  Created Z on 6/11/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class TownPresenter: TownPresenterProtocol {
    
    var townModel: [TownModel]?
    

    weak private var view: TownViewProtocol?
    var interactor: TownInteractorProtocol?
    private let router: TownWireframeProtocol
    
    
    init(interface: TownViewProtocol, interactor: TownInteractorProtocol?, router: TownWireframeProtocol) {
        
       
        self.view = interface
        self.interactor = interactor
        self.router = router
        
        townModel = [TownModel]()
        
        townModel?.append(TownModel(name: "Vinnitsa", temperature: "28", townFullInfo: "x=123 y=23 reg=fjfjjfjfj", typeInfo: false))
        townModel?.append(TownModel(name: "Kyiv", temperature: "31", townFullInfo: "xxxxx=124645643 yyyyyy=246575673 reg=gref dfgdgrr jfjjfjfj", typeInfo: true))

    }

    func count()->Int? {
        return townModel?.count
    }
    
    func getTextTownInfo(index: Int)->String {
        
        let town = townModel?[index].name ?? ""
        let tempr = townModel?[index].temperature ?? ""
        
        if getTypeTownInfo(index: index) {
            return town + " " + tempr
        }
        else {
            let info = townModel?[index].townFullInfo ?? ""
            return town + " " + tempr + " " + info
        }
    }
    
    func getTypeTownInfo(index: Int)->Bool {
       let type = townModel?[index].typeInfo ?? false
        return type
    }
    
    func actionCellButton(index: Int?) {
        print(index)
    }
    
    deinit {
        townModel?.removeAll()
    }
}
