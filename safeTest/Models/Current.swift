//
//  Current.swift
//  safeTest
//
//  Created by Csongor Nagy on 22/5/2024.
//

import Foundation
import RealmSwift

class Current: Object {
    
    dynamic var last_updated_epoch: Int?
    @objc dynamic var last_updated: String?
    @objc dynamic var name: String?
    @objc dynamic var temp_c: Double = 0.0
    @objc dynamic var temp_f: Double = 0.0
    dynamic var is_day: Int?
    @objc dynamic var condition : Condition? = Condition()
    @objc dynamic var wind_mph: Double = 0.0
    @objc dynamic var wind_kph: Double = 0.0
    @objc dynamic var wind_degree: Double = 0.0
    @objc dynamic var wind_dir: String?
    @objc dynamic var pressure_mb: Double = 0.0
    @objc dynamic var pressure_in: Double = 0.0
    @objc dynamic var precip_mm: Double = 0.0
    @objc dynamic var precip_in: Double = 0.0
    @objc dynamic var humidity: Double = 0.0
    @objc dynamic var cloud: Double = 0.0
    @objc dynamic var feelslike_c: Double = 0.0
    @objc dynamic var feelslike_f: Double = 0.0
    @objc dynamic var vis_km: Double = 0.0
    @objc dynamic var vis_miles: Double = 0.0
    @objc dynamic var uv: Double = 0.0
    @objc dynamic var gust_mph: Double = 0.0
    @objc dynamic var gust_kph: Double = 0.0
    
}
