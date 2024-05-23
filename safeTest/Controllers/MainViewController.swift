//
//  ViewController.swift
//  safeTest
//
//  Created by Csongor Nagy on 22/5/2024.
//

import UIKit

class MainViewController: UIViewController, Storyboarded, SafeTestNetworkManagerDelegate  {
    
    @IBOutlet weak var currentWeatherView: UIView!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherCity: UILabel!
    @IBOutlet weak var currentWeatherCountry: UILabel!
    @IBOutlet weak var currentWeatherCondition: UILabel!
    @IBOutlet weak var currentWeatherTemperature: UILabel!
    @IBOutlet weak var currentWeatherActivity: UIActivityIndicatorView!
    
    weak var coordinator: MainCoordinator?
    var networkManager: SafeTestNetworkManager = SafeTestNetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeatherView.layer.cornerRadius = 20
        
        networkManager.managerDelegate = self
        networkManager.getCurrent()
        
    }
    
    
    // MARK: SafeTestNetworkManagerDelegate Methods
    
    func didGetCurrentWeather(currentWeather: CurrentWeather) {
        DispatchQueue.main.async { [self] in
            currentWeatherActivity.stopAnimating()
            currentWeatherCity.text = currentWeather.location!.name!
            currentWeatherCountry.text = "\(currentWeather.location!.region!) - \(currentWeather.location!.country!)"
            currentWeatherCondition.text = currentWeather.current!.condition!.text
            currentWeatherCondition.text = currentWeather.current!.condition!.text
            currentWeatherTemperature.text = "\(currentWeather.current!.temp_c)º"
        }
        
        let url = URL(string: "https:\(currentWeather.current!.condition!.icon!)")
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async { [self] in
                    currentWeatherImage.image = UIImage(data: data)
                }
            }
        }
    }

}

