//
//  DataBaseServiseProtocol.swift
//  weather
//
//  Created by Z on 6/28/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

protocol TownDataBaseProtocol: class {
    func getItem(index: Int)->String
    func count()->Int
    func addItem(item: String)
}

