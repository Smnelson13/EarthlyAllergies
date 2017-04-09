//
//  APIController.swift
//  EarthlyAllergies
//
//  Created by shane nelson on 4/5/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol APIControllerProtocol
{
  func didRecieve(_ results: [String: Any])
}

class APIController
{
  private static let APIKey = "c3d8d4c9641dfcf8bda6a087e1f55f8b"
  var delegate: APIControllerProtocol?
  
  init(delegate: APIControllerProtocol)
  {
    self.delegate = delegate
  }
  
  func searchDarkSky(coordinate: CLLocationCoordinate2D)
  {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    let url = URL(string: "https://api.darksky.net/forecast/c3d8d4c9641dfcf8bda6a087e1f55f8b/\(coordinate.latitude),\(coordinate.longitude)")!
    let session = URLSession.shared

    let task = session.dataTask(with: url, completionHandler: { data, response, error -> Void in
      
      print("Task completed")
      if let error = error
      {
        print(error.localizedDescription)
      }
      else
      {
        if let dictionary = self.parseJSON(data!)
        {
          if let results = dictionary["currently"] as? [String: Any]
          {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.delegate?.didRecieve(results)
          }
        }
      }
    })
    
    task.resume()
  }
  
  
  func parseJSON(_ data: Data) -> [String: Any]?
  {
    do
    {
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      if let dictionary = json as? [String: Any]
      {
        return dictionary
      }
      else
      {
        return nil
      }
    }
    catch
    {
      print(error)
      return nil
    }
  }
}

