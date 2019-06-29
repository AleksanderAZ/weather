//
//  WeatherAPIModel.swift
//  weather
//
//  Created by Z on 6/29/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

struct WeatherAPIModel: Codable {
    let name: String?
    let items: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case name =   "name"
        case items =        "items"
    }
}

struct Item: Codable {
    let item: String?
    
    enum CodingKeys: String, CodingKey {
        case item =           "item"
    }
}
