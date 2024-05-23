//
//  SafeTestNetworkManager.swift
//  safeTest
//
//  Created by Csongor Nagy on 22/5/2024.
//

import Foundation
import CoreLocation
import RealmSwift

@objc protocol SafeTestNetworkManagerDelegate: NSObjectProtocol {
    @objc optional func didStartedToPullCurrentWeather()
    @objc optional func didGetCurrentWeather(currentWeather: CurrentWeather)
}

enum status {
    case iddle
    case current
}

class SafeTestNetworkManager: NSObject, URLSessionTaskDelegate, SafeTestLocationManagerDelegate, SafeTestWebSocketManagerDelegate {
    
    weak var managerDelegate: SafeTestNetworkManagerDelegate?
    var locationManager: SafeTestLocationManager = SafeTestLocationManager()
    var websocketManager: SafeTestWebSocketManager = SafeTestWebSocketManager()
    private var lastLocation : CLLocation?
    private var status : status = .iddle
    
    override init() {
        super.init()
        locationManager.managerDelegate = self
        websocketManager.managerDelegate = self
    }
    
    func getCurrent() {
        
        status = .current
        
        if lastLocation != nil {
            getCurrentWithLocation(location: lastLocation!)
            return
        }
        
        let realm = try! Realm()
        
        if (realm.objects(CurrentWeather.self).count > 0) {
            let currentWeather = realm.objects(CurrentWeather.self).first!
            managerDelegate?.didGetCurrentWeather?(currentWeather: currentWeather)
        }

    }
    
    func getCurrentWithLocation(location: CLLocation) {
        
        let url = URL(string: "https://api.weatherapi.com/v1/current.json?q=\(location.coordinate.latitude),\(location.coordinate.longitude)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as? String, forHTTPHeaderField: "Key")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default,
                                 delegate: self,
                                 delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){ [self] data, response, error in
            if error != nil{
                print("Error -> \(String(describing: error))")
                return
            }

            do {
                let result = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]
                let currentWeather = CurrentWeather(value: result! as Any)
                let realm = try! Realm()
                try! realm.write {
                   realm.add(currentWeather)
                }
                
                managerDelegate?.didGetCurrentWeather?(currentWeather: currentWeather)
            } catch {
                print("Error -> \(error)")
            }
        }
        
        task.delegate = self
        task.resume()
        
    }
    
    
    // MARK: SafeTestLocationManagerDelegate Methods
    
    func didUpdateLocation(location: CLLocation) {
        lastLocation = location
        
        switch status {
            case .current:
                status = .iddle
                getCurrentWithLocation(location: lastLocation!)
            default:
                return
        }
    }
    
    
    // MARK: SafeTestWebSocketManagerDelegate Methods
    
    func didConnectSocket() {
        
    }
    
    func didDisconnectSocket() {
        
    }
    
    func didReceivedMesssage(message: String) {
        switch message {
        case "updateCurrent":
            getCurrent()
        default:
            return
        }
    }
    
    func didReceivedData(data: Data) {
        
    }
}
