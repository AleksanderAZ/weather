//
//  ForecastAPIModel.swift
//  weather
//
//  Created by Z on 6/29/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

struct ForecastAPIModel: Codable {
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [List]?
    let city: City?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case cnt = "cnt"
        case list = "list"
        case city = "city"
        case cod = "cod"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
    let timezone: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
    }
}

// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let sys: Syst?
    let dtTxt: String?
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case sys = "sys"
        case dtTxt = "dt_txt"
        case rain = "rain"
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Double?
    let seaLevel: Double?
    let grndLevel: Double?
    let humidity: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity = "humidity"
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Syst: Codable {
    let pod: String?
    
    enum CodingKeys: String, CodingKey {
        case pod = "pod"
    }
}

