//
//  CurrentWeather.swift
//  safeTest
//
//  Created by Csongor Nagy on 22/5/2024.
//

import Foundation
import RealmSwift

class CurrentWeather: Object {
    
    @objc dynamic var location: Location? = Location()
    @objc dynamic var current: Current? = Current()
    
}
