//
//  ZipcodeViewController.swift
//  EarthlyAllergies
//
//  Created by shane nelson on 4/9/17.
//  Copyright © 2017 The Iron Yard. All rights reserved.
//
import CoreLocation
import UIKit

protocol ZipcodeViewControllerDelegate
{
//  func didRecieve(_ results: [Any])
  
  func zipcodeViewControllerDidReceiveLocationCoordinate(coordinate: CLLocationCoordinate2D)
}

class ZipcodeViewController: UIViewController, UISearchBarDelegate
{
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var searchButton: UIButton!
  var delegate: ZipcodeViewControllerDelegate!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    searchBar.delegate = self
    searchBar.showsCancelButton = true
    searchBar.delegate = self

  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
  {
    searchBar.showsCancelButton = true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
  {
    searchBar.text = nil
    searchBar.showsCancelButton = false
    
    // Remove focus from the search bar.
    searchBar.endEditing(true)
    
  }
  override func didReceiveMemoryWarning()
  {
      super.didReceiveMemoryWarning()
  
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
  {
    print("searchText \(searchText)")
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
  {
    performGeocode(text: searchBar.text)
  }
  
  func performGeocode(text: String?)
  {
    guard let text = text, text != "" else
    {
      return
    }
    
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(text)
    { placemarks, error in
      if let coordinate = placemarks?.first?.location?.coordinate
      {
        self.delegate.zipcodeViewControllerDidReceiveLocationCoordinate(coordinate: coordinate)
      }
    }
  }
 
  @IBAction func cancelTapped(sender: UIButton)
  {
    dismiss(animated: true, completion: nil)
  }
//  func geocoderAPI()
//  {
//  
//  let geocoder = CLGeocoder()
//  
//  geocoder.geocodeAddressString(searchBar.text!, completionHandler:
//  {
//  placemarks, error in
//  if let geocodeError = error
//  {
//  print(geocodeError.localizedDescription)
//  }
//  else
//  {
//  if let placemark = placemarks?[0]
//  {
//    placemark.location?.coordinate
//  }
//  }
//  })
//  }
}
