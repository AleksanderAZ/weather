//
//  ForecastInteractor.swift
//  weather
//
//  Created Z on 6/11/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ForecastInteractor: ForecastInteractorProtocol {
    weak var presenter: ForecastPresenterProtocol?
    
    func loadAPIRequestForecast(nameTown: String, completion: @escaping (ForecastAPIModel?)->()) {
        let url: String = RequestsDataAPI.baseURL + RequestsDataAPI.forecastPath
        NetworkServiceAPI.shared.loadAPIRequest(url: url, nameTown: nameTown) { [weak self] (result: ForecastAPIModel?, error: String?) in
            if let err = error {
                self?.error(text: err)
            }
            else {
                if result?.cod == "200" {
                    completion(result)
                }
                else {
                    self?.error(text: "Error load data for " + nameTown)
                }
            }
        }
    }
    
    func error(text: String) {
        self.presenter?.error(text: text)
    }
}
