//
//  WeatherViewController.swift
//  EarthlyAllergies
//
//  Created by shane nelson on 4/5/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//
import UIKit
import CoreLocation

class EarthlyViewController: UIViewController, APIControllerProtocol, CLLocationManagerDelegate
{
  let locationManager = CLLocationManager()

  @IBOutlet weak var currentTemperatureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var apparentTemperatureLabel: UILabel!
  @IBOutlet weak var skyconImage: SKYIconView!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    skyconImage.setColor = UIColor.black
    skyconImage.backgroundColor = UIColor.white
    skyconImage.setType = .clearDay
    loadCurrentLocation()
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
    
  func didRecieve(_ results: [String: Any])
  {
    let currentWeather =  Weather(weatherDictionary: results)
    let dispatchQueue = DispatchQueue.main
    dispatchQueue.async {
      self.currentTemperatureLabel.text = "\(currentWeather.temperature)"
      self.apparentTemperatureLabel.text = "\(currentWeather.apparentTemperature)"
      self.humidityLabel.text = "\(currentWeather.humidity)"
    }
  }
  
  func loadCurrentLocation()
  {
    configureLocationManager()
  }
  
  func configureLocationManager()
  {
    if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied && CLLocationManager.authorizationStatus() != CLAuthorizationStatus.restricted
    {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
      if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined
      {
        locationManager.requestWhenInUseAuthorization()
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
  {
    if status == CLAuthorizationStatus.authorizedWhenInUse
    {
      locationManager.startUpdatingLocation()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    locationManager.stopUpdatingLocation()
    if let location = locations.last
    {
      let apiController = APIController(delegate: self)
      apiController.searchDarkSky(coordinate: location.coordinate)

    }
  }

}
