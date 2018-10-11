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
    var URL : String = VGConstant.API_URL
    
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
    func getForecast()
    {
        
    }
}
