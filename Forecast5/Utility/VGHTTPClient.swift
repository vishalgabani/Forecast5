//
//  VGHTTPClient.swift
//  Forecast5
//
//  Created by Vishal Gabani on 11/10/18.
//  Copyright © 2018 Vishal Gabani. All rights reserved.
//

import Foundation

class VGHTTPClient : NSObject
{
    //MARK: - Properties
    var apiURL : String = VGConstant.API_URL
    
    //Singleton construction
    class var sharedClient : VGHTTPClient
    {
        struct Static
        {
            static let instance = VGHTTPClient.init()
        }
        
        return Static.instance
    }
    
    //MARK: - API Calls
    func getForecast(_ lat : Double, _ long : Double, completionBlock: @escaping (_ weatherObj : VGWeather?, _ error : NSError?) -> Void)
    {
        let url = String(format: self.apiURL, lat, long)
        URLSession.shared.dataTask(with: URL.init(string: url)!) { (data, response, error) in
            
            //make sure there is some data
            if data != nil
            {
                do
                {
                    let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary

                    let weatherObj = VGWeather(jsonResult)
                    
                    completionBlock(weatherObj, nil)
                }
                catch
                {
                    completionBlock(nil, NSError.init(domain: "F5Domain", code: -1, userInfo: ["message" : "Could not parse JSON"]))
                }
            }
            else
            {
                //received error
                completionBlock(nil, error as NSError?)
            }
            
        }.resume()
    }
}
