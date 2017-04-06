//
//  WeatherViewController.swift
//  EarthlyAllergies
//
//  Created by shane nelson on 4/5/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//
import UIKit

class EarthlyViewController: UIViewController, APIControllerProtocol
{
  @IBOutlet weak var currentTemperatureLabel: UILabel!

 
    override func viewDidLoad()
    {
        super.viewDidLoad()
      let apiController = APIController(delegate: self)
      apiController.searchDarkSky()
   //   CurrentTemperatureLabel.text = Weather.
   
    }
      override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  func didRecieve(_ results: [String: Any])
  {
    let currentWeather =  Weather(weatherDictionary: results)
    let dispatchQueue = DispatchQueue.main
    dispatchQueue.async {
      self.currentTemperatureLabel.text = "\(currentWeather.temperature)"
      
    }
  }
  
  
  
  
  
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
