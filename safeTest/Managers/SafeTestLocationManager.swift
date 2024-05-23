//
//  SafeTestLocationManager.swift
//  safeTest
//
//  Created by Csongor Nagy on 22/5/2024.
//

import Foundation
import CoreLocation
import MapKit

@objc protocol SafeTestLocationManagerDelegate: NSObjectProtocol {
    @objc optional func didUpdateLocation(location: CLLocation)
}

class SafeTestLocationManager: NSObject, CLLocationManagerDelegate {
    
    let locationManger = CLLocationManager()
    weak var managerDelegate: SafeTestLocationManagerDelegate?
    
    override init() {
        
        super.init()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManger.requestAlwaysAuthorization()
        locationManger.allowsBackgroundLocationUpdates = true
        locationManger.pausesLocationUpdatesAutomatically = true
        locationManger.startUpdatingLocation()
    }
    
    func getLocation() -> CLLocation {
        return locationManger.location!
    }
    
    
    // MARK: CLLocationManagerDelegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        managerDelegate?.didUpdateLocation!(location: locations.last!)
    }
    
}
