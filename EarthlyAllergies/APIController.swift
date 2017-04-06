//
//  APIController.swift
//  EarthlyAllergies
//
//  Created by shane nelson on 4/5/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import Foundation

struct API
{
  
  static let APIKey = "c3d8d4c9641dfcf8bda6a087e1f55f8b"
  static let BaseURL = URL(string: "https://api.darksky.net/forecast/c3d8d4c9641dfcf8bda6a087e1f55f8b/37.8267,-122.4233")!
  static var AuthenticatedBaseURL: URL
  {
    return BaseURL.appendingPathComponent(APIKey)
  }
}
