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
  var apiController: APIController!
  
  @IBOutlet var accessoryLabels: [UILabel]!

  @IBOutlet weak var currentTemperatureLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var apparentTemperatureLabel: UILabel!
  @IBOutlet weak var skyconImage: SKYIconView!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var visibilityLabel: UILabel!
  @IBOutlet weak var windSpeedLabel: UILabel!
  @IBOutlet weak var searchButton: UIButton!

  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    apiController = APIController(delegate: self)
    skyconImage.setColor = UIColor.white
    skyconImage.backgroundColor = UIColor.clear
    
    searchButton.setImage(UIImage(named: "search.png"), for: .normal)
    searchButton.tintColor = view.backgroundColor
    searchButton.imageView?.tintColor = view.backgroundColor
    searchButton.layer.cornerRadius = searchButton.frame.width / 2
    searchButton.layer.masksToBounds = true
    searchButton.clipsToBounds = true
    searchButton.layer.shadowOpacity = 0.25
    searchButton.layer.shadowColor = UIColor.darkGray.cgColor
    searchButton.alpha = 0
    
    let labels = [
      currentTemperatureLabel,
      humidityLabel,
      apparentTemperatureLabel,
      summaryLabel,
      visibilityLabel,
      windSpeedLabel
    ] + accessoryLabels
    
    for label in labels
    {
      label.font = UIFont(name: "Avenir-Light", size: label.font.pointSize)
    }
    
    //skyconImage.setType = Skycons(rawValue: "clear-day")!
    loadCurrentLocation()
  }
  
  override func viewDidAppear(_ animated: Bool)
  {
    super.viewDidAppear(animated)
    
    let frame = searchButton.frame
    
    searchButton.frame.origin.x += 200
    searchButton.alpha = 0
    
    UIView.animate(withDuration: 0.5, animations: { 
      self.searchButton.alpha = 1
      self.searchButton.frame = frame
    }, completion: { finished in
      UIView.animate(withDuration: 0.25, animations: { 
        self.searchButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
      }, completion: { finished in
        UIView.animate(withDuration: 0.125, animations: { 
          self.searchButton.transform = .identity
        })
      })
    })
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
      apiController.searchDarkSky(coordinate: location.coordinate)
    }
  }
}

extension EarthlyViewController: ZipcodeViewControllerDelegate
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let zipcodeViewController = segue.destination as? ZipcodeViewController
    {
      zipcodeViewController.delegate = self
    }
  }
  
  func zipcodeViewControllerDidReceiveLocationCoordinate(coordinate: CLLocationCoordinate2D)
  {
    dismiss(animated: true) { 
      self.apiController.searchDarkSky(coordinate: coordinate)
    }
  }
}
