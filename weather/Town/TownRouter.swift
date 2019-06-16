//
//  TownRouter.swift
//  weather
//
//  Created Z on 6/11/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class TownRouter: TownWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(view: TownViewController) {
        // Change to get view from storyboard if not using progammatic UI
        let view = view
        let interactor = TownInteractor()
        let router = TownRouter()
        let presenter = TownPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
    }
    
    func showWeatherView(nameTown: String) {
        let view = WeatherRouter.createModule(nameTown: nameTown)
        self.viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
