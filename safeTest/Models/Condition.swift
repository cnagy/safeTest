//
//  Condition.swift
//  safeTest
//
//  Created by Csongor Nagy on 22/5/2024.
//

import Foundation
import RealmSwift

class Condition: Object {
     
    @objc dynamic var text: String?
    @objc dynamic var icon: String?
    dynamic var code: Int?
    
}
