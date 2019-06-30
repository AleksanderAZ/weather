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
    var townsBD: [TownItemDB]?
    var token: NotificationToken?
    
    init() {
       deleteDB()
        
        if uiRealm.objects(TownItemDB.self).filter("nameTown = 'Vinnytsia'").first == nil {
            addItem(item: "Vinnytsia")
        }

        if uiRealm.objects(TownItemDB.self).filter("nameTown = 'Kiev'").first == nil {
            addItem(item: "Kiev")
        }
        
        townsBD = self.uiRealm.objects(TownItemDB.self).sorted(by: { (lhsData, rhsData) -> Bool in
            return lhsData.nameTown > rhsData.nameTown
        })
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
        townsBD = self.uiRealm.objects(TownItemDB.self).sorted(by: { (lhsData, rhsData) -> Bool in
            return lhsData.nameTown > rhsData.nameTown
        })
    }
    
    func count()->Int {
        return self.townsBD?.count ?? 0
    }
    
    func getItem(index: Int)->String {
        let towns = self.townsBD
        let item = self.townsBD?[index].nameTown
        return item ?? ""
    }

    deinit {
    }
}
