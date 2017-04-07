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
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var visibilityLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    skyconImage.setColor = UIColor.black
    skyconImage.backgroundColor = UIColor.white
    //skyconImage.setType = Skycons(rawValue: "clear-day")!
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
      self.currentTemperatureLabel.text = "\(currentWeather.temperature)℉"
      self.apparentTemperatureLabel.text = "\(currentWeather.apparentTemperature)℉"
      self.humidityLabel.text = "\(currentWeather.humidity)%"
      self.skyconImage.setType = Skycons(rawValue: currentWeather.icon)!
      self.summaryLabel.text = "\(currentWeather.summary)"
      self.windSpeedLabel.text = "\(currentWeather.windSpeed)MPH"
      self.visibilityLabel.text = "\(currentWeather.visibility)Mi"
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
