//
//  Weather.swift
//  EarthlyAllergies
//
//  Created by shane nelson on 4/5/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import Foundation


class Weather
{
  let temperature: Double
  let humidity: Double
  let apparentTemperature: Double
  let icon: String
  let summary: String
  let windSpeed: Double
  let visibility: Double
  
  init(weatherDictionary: [String: Any])
  {
    temperature = weatherDictionary["temperature"] as! Double
    humidity = weatherDictionary["humidity"] as! Double
    apparentTemperature = weatherDictionary["apparentTemperature"] as! Double
    icon = weatherDictionary["icon"] as! String
    summary = weatherDictionary["summary"] as! String
    windSpeed = weatherDictionary["windSpeed"] as! Double
    visibility = weatherDictionary["visibility"] as! Double
  }
  
}
