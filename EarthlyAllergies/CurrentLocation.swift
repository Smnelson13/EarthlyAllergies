//
//  CurrentLocation.swift
//  EarthlyAllergies
//
//  Created by shane nelson on 4/7/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//

import Foundation
import CoreLocation

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
    let currentLocationAnnotation = MKPointAnnotation()
    currentLocationAnnotation.coordinate = location.coordinate
    currentLocationAnnotation.title = "TIY Orlando"
    currentLocationAnnotation.subtitle = "Shane"
    mapView.showAnnotations([currentLocationAnnotation], animated: true)
  }
}
