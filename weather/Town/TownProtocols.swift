//
//  TownProtocols.swift
//  weather
//
//  Created Z on 6/11/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol TownWireframeProtocol: class {
    func showWeatherView(nameTown: String)
}
//MARK: Presenter -
protocol TownPresenterProtocol: class {
    func count()->Int
    func actionCellButton(index: Int?)
    func getTextTownInfo(index: Int)->(String, String, String)
    func getTypeTownInfo(index: Int)->Bool
    func showWeatherView(indexCell: Int)
    func choiceTown(townName: String?)
    func addTown(townName: String?)
    func updata(towns: [TownModel]?)
    func error(text: String)
}

//MARK: Interactor -


//MARK: View -
protocol TownViewProtocol: class {
    var presenter: TownPresenterProtocol?  { get set }
    func update()
    func showError(text: String)
}

protocol TownInteractorDBProtocol: class {
    var presenter: TownPresenterProtocol?  { get set }
    
    func addItem(item: TownItemDB, completion: @escaping (String?)->())
    func getItems(completion: @escaping ([TownItemDB]?)->())
    func error(text: String)
}
protocol TownInteractorAPIProtocol: class {
    var presenter: TownPresenterProtocol?  { get set }
    
    func loadAPIRequestTown(nameTown: String, completion: @escaping (TownAPIModel?)->())
    func error(text: String)
}


