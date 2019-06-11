//
//  WeatherPresenter.swift
//  weather
//
//  Created Z on 6/11/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class WeatherPresenter: WeatherPresenterProtocol {

    weak private var view: WeatherViewProtocol?
    var interactor: WeatherInteractorProtocol?
    private let router: WeatherWireframeProtocol

    init(interface: WeatherViewProtocol, interactor: WeatherInteractorProtocol?, router: WeatherWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
