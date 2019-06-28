//
//  DataBaseServise.swift
//  weather
//
//  Created by Z on 6/15/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation

import RealmSwift

class TownDataBase: TownDataBaseProtocol {
    
    let uiRealm = try! Realm()
    
    init() {
 //       deleteDB()
    }
    
    private func deleteDB() {
        try! uiRealm.write {
            uiRealm.deleteAll()
        }
    }
    
    func addItem(item: String) {
    
        let townItemDB = TownItemDB()
        townItemDB.nameTown = item
        
        try! uiRealm.write() {
            uiRealm.add(townItemDB)
        }
    }
    
    func count()->Int {
        let townsBD = uiRealm.objects(TownItemDB.self)
        return townsBD.count
    }
    
    func getItem(index: Int)->String {
        let townsBD = uiRealm.objects(TownItemDB.self)
        let item = townsBD[index].nameTown
        return item
    }
}
