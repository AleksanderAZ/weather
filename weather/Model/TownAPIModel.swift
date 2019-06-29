//
//  TownAPIModel.swift
//  weather
//
//  Created by Z on 6/29/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

struct TownAPIModel: Codable {
    let name: String?
    let info: [Info]?
    
    enum CodingKeys: String, CodingKey {
        case name =   "name"
        case info =   "info"
    }
}

struct Info: Codable {
    let item: String?
    
    enum CodingKeys: String, CodingKey {
        case item =           "item"
    }
}
