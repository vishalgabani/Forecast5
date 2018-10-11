//
//  VGMainViewController.swift
//  Forecast5
//
//  Created by Vishal Gabani on 11/10/18.
//  Copyright © 2018 Vishal Gabani. All rights reserved.
//

import UIKit
import CoreLocation

class VGMainViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var userLocation = CLLocation()
    var weatherData = VGWeather()
    
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var tempLabel : UILabel!
    @IBOutlet weak var weatherStatusLabel : UILabel!
    @IBOutlet weak var statusLabel : UILabel!
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Start location services
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        self.statusLabel.text = VGConstant.FETCH_LOCATION
    }
    
    //MARK: - API Call
    @IBAction func callWeatherAPI()
    {
        self.statusLabel.text = VGConstant.FETCH_DATA
        VGHTTPClient.sharedClient.getForecast(self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude) { (weatherObj, error) in
            DispatchQueue.main.async {
                if weatherObj != nil
                {
                    self.weatherData = weatherObj!
                    self.cityLabel.text = weatherObj!.city
                    self.tempLabel.text = String(format: "%0.0f˚C", weatherObj!.hourWeatherArray.first!.temp)
                    self.weatherStatusLabel.text = weatherObj?.hourWeatherArray.first?.status
                    
                    self.tableView.reloadData()
                }
                self.statusLabel.text = ""
            }
        }
    }

    //MARK: - CLLocationManager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Implementing this method is required
        debugLog(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.userLocation = location
            debugLog("\(location.coordinate.latitude), \(location.coordinate.longitude)")
            
            callWeatherAPI()
        }
    }
}

extension VGMainViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherData.hourWeatherArray.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VGConstant.TABLE_CELL, for: indexPath) as! VGTableCell
        
        let dayWeather = self.weatherData.hourWeatherArray[indexPath.row + 1]
        
        cell.dayLabel.text = dayWeather.date
        cell.maxTempLabel.text = String(format: "%0.0f˚", dayWeather.maxTemp)
        cell.minTempLabel.text = String(format: "%0.0f˚", dayWeather.minTemp)
        
        return cell
    }
}

