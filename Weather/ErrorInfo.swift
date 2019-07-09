//
//  ErrorInfo.swift
//  weather
//
//  Created by Z on 7/9/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

enum ErrorInfo: String{
    case ErrorAPI = "Server access error or no data available"
    case ErrorAddCityNot = "Not city."
    case ErrorAddCityExist = "This city already exists."
    case ErrorAddCityNoAPI = "No information about this city"
    case ErrorAddCityDB = "Error data base write"
    case ErrorLoadDB = "Error load towns from DB"
    case ErrorLoadAPI = "Error load data for "
}
