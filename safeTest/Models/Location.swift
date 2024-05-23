//
//  Location.swift
//  safeTest
//
//  Created by Csongor Nagy on 22/5/2024.
//

import Foundation
import RealmSwift

class Location: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var region: String?
    @objc dynamic var country: String?
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var lon: Double = 0.0
    @objc dynamic var tz_id: String?
    dynamic var localtime_epoch: Int?
    @objc dynamic var localtime: String?
    
}
