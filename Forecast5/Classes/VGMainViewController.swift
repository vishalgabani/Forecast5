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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Start location services
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
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
            userLocation = location
            debugLog("\(location.coordinate.latitude), \(location.coordinate.longitude)")
        }
    }
}

