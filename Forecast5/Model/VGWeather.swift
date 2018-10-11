//
//  VGWeather.swift
//  Forecast5
//
//  Created by Vishal Gabani on 11/10/18.
//  Copyright © 2018 Vishal Gabani. All rights reserved.
//

import Foundation

class VGWeather : NSObject
{
    var city : String = ""
    var hourWeatherArray : [VGHourWeather] = []
    
    convenience init(_ dict : NSDictionary) {
        self.init()
        
        self.city = dict.value(forKeyPath: "city.name") as! String
        
        if let list = dict.value(forKey: "list") as? NSArray
        {
            for dict in list
            {
                let hWeather = VGHourWeather(dict as! NSDictionary)
                self.hourWeatherArray.append(hWeather)
            }
            
            self.hourWeatherArray = self.hourWeatherArray.sorted{ $0.timestamp > $1.timestamp }
        }
    }
}

class VGHourWeather : NSObject
{
    var timestamp : TimeInterval = 0
    var temp : Double = 0
    var minTemp : Double = 0
    var maxTemp : Double = 0
    var pressure : Double = 0 //hPa
    var humidity : Double = 0 //%
    var status : String = "" //weather description
    var windSpeed : Double = 0
    var winddeg : Double = 0
    var date : String = ""
    
    convenience init(_ dict : NSDictionary) {
        self.init()
        
        self.timestamp = dict.value(forKey: "dt") as! Double
        self.date = getDateFromTimestamp(timeStamp: self.timestamp)

        //temprature
        //Convert temprature unit from kelvin to celsius since API is not working when using unit parameter
        self.temp = dict.value(forKeyPath: "main.temp") as! Double - 273.15
        self.minTemp = dict.value(forKeyPath: "main.temp_min") as! Double - 273.15
        self.maxTemp = dict.value(forKeyPath: "main.temp_max") as! Double - 273.15
        self.pressure = dict.value(forKeyPath: "main.pressure") as! Double
        self.humidity = dict.value(forKeyPath: "main.humidity") as! Double
        
        //status
        if let weather = dict.value(forKey: "weather") as? NSArray
        {
            let weatherDict = weather[0] as! NSDictionary
            self.status = weatherDict.value(forKey: "main") as! String
        }
        
        //Wind
        self.pressure = dict.value(forKeyPath: "wind.speed") as! Double
        self.humidity = dict.value(forKeyPath: "wind.deg") as! Double
    }
    
    func getDateFromTimestamp(timeStamp : Double) -> String {

        let date = Date.init(timeIntervalSince1970: timeStamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMM YY, hh:mm a"
        return formatter.string(from: date as Date)
    }
}
