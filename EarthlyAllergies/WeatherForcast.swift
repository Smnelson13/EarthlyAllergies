//
//  WeatherForcast.swift
//  EarthlyAllergies
//
//  Created by Shane Nelson on 6/28/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import Foundation

class WeatherForcast
{
  let icon: String
  
  init(dailyWeatherDicionary: [String: Any])
  {
    icon = dailyWeatherDicionary["icon"] as! String
  }

}
