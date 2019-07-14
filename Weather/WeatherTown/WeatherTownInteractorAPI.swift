//
//  TownInteractorAPI.swift
//  weather
//
//  Created by Z on 7/3/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

class WeatherTownInteractorAPI: WeatherTownInteractorAPIProtocol {
    weak var presenter: WeatherTownPresenterProtocol?
    
    func loadAPIRequestTown(nameTown: String, completion: @escaping (TownAPIModel?)->()) {
        let url: String = RequestsDataAPI.baseURL + RequestsDataAPI.townPath
        NetworkServiceAPI.shared.loadAPIRequest(url: url, nameTown: nameTown) { [weak self] (result: TownAPIModel?, error: String?) in
            if let err = error {
                self?.error(text: err)
            }
            else {
                if result?.cod == 200 {
                    completion(result)
                }
                else {
                    self?.error(text: ErrorInfo.ErrorLoadAPI.rawValue + nameTown)
                }
            }
        }
    }
  
    func error(text: String) {
        self.presenter?.error(text: text)
    }
}
