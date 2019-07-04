//
//  DataBaseServise.swift
//  weather
//
//  Created by Z on 6/15/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import Foundation
import RealmSwift

class TownDataBase {
    public static let shared = TownDataBase()
    
    private var townRealm: Realm?
    public var uiRealm: Realm? {
        get {
            if self.townRealm == nil {
                do {
                    self.townRealm = try Realm()
                }
                catch {
                }
            }
            return self.townRealm
        }
    }
    
    public func write(writeClosure: (Realm) -> ()) {
        if let realm = self.uiRealm {
            do {
                try realm.write {
                    writeClosure(realm)
                }
            }
            catch {
            }
        }
    }
    
    private init() {
   //     guard let realm = self.uiRealm else { return  }
   //     guard let _ = realm.objects(TownItemDB.self).first else {
   //         addItem(item: "Vinnytsia")
   //         addItem(item: "Kiev")
    //        return
    //    }
    }
    
    deinit {
    }
}
