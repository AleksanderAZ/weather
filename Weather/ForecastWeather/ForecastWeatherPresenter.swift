//
//  ForecastWeatherPresenter.swift
//  weather
//
//  Created Z on 7/15/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ForecastWeatherPresenter: ForecastWeatherPresenterProtocol {

    weak private var view: ForecastWeatherViewProtocol?
    var interactor: ForecastWeatherInteractorProtocol?
    private let router: ForecastWeatherWireframeProtocol

    var nameTown: String?
    var forecastModel: [ForecastModel]?
    
    init(interface: ForecastWeatherViewProtocol, interactor: ForecastWeatherInteractorProtocol?, router: ForecastWeatherWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func updata(forecast: [ForecastModel]?) {
        self.forecastModel = forecast
        self.view?.update()
    }
    
    func loadData() {
        guard let name = self.nameTown else { return }
        self.loadInfo(nameTown: name) { [weak self] (result: [ForecastModel]?) in
            self?.updata(forecast: result)
        }
    }
    
    func count()->Int? {
        return forecastModel?.count
    }
    
    func getTitle()->String {
        let title = nameTown ?? ""
        return title
    }
    
    func getForecastInfo(index: Int)->String {
        let forecastForecast = (forecastModel?[index].forecast ?? "")
        return forecastForecast
    }
    
    func error(text: String) {
        self.view?.showError(text: text)
    }
    
    func loadInfo(nameTown: String, completion: @escaping ([ForecastModel]?)->()) {
        interactor?.loadAPIRequestForecast(nameTown: nameTown) { [weak self] (result: ForecastAPIModel?) in
            guard let list = result?.list else { return }
            let count = list.count
            var forecastModel = [ForecastModel]()
            var date: String = ""
            var tempr: String = ""
            var rain: String = "0"
            var main: String = ""
            
            for i in 0..<count {
                date = list[i].dtTxt ?? ""
                if let m = list[i].weather?[0].main?.description {
                    main = m
                }
                if let r = list[i].rain?.the3H {
                    rain = String(describing:  r)
                }
                if let t = list[i].main?.temp {
                    tempr = String(t)
                }
                
                let text = "For time: " + date + "\n" +  "tempr - " + tempr + "C,\nmain - " + main + ",\nrain - " + rain + "%"
                forecastModel.append(ForecastModel(forecast: text))
            }
            completion(forecastModel)
        }
    }
    
    deinit {
        forecastModel?.removeAll()
    }
}