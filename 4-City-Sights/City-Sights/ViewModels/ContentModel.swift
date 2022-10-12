//
//  ContentModel.swift
//  City-Sights
//
//  Created by Jacob Summerville on 10/8/22.
//

import CoreLocation
import Foundation

// info.plist...
// Add: Privacy - Location Always and When In Use Usage Description & String description
// Add: Privacy - Location When In Use Usage Description & String description

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
   
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    @Published var placemark: CLPlacemark?
    
    override init() {
        super.init()
        
        // Set content model as the delegate
        locationManager.delegate = self
    }

    func requestGeolocationPermission() {
        // Request permission from user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        if locationManager.authorizationStatus == .authorizedAlways ||
           locationManager.authorizationStatus == .authorizedWhenInUse {
            // Permission granted -> start geolocating
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Gives location of the user
        let userLocation = locations.first
        
        if userLocation != nil {
            // Stop requesting the location after initial get
            locationManager.stopUpdatingLocation()
            
            // Get user's city from coordinates
            let geoCoder = CLGeocoder()
            
            geoCoder.reverseGeocodeLocation(userLocation!) { (placemarks, error) in
                if error == nil && placemarks != nil {
                    self.placemark = placemarks?.first
                }
            }
            
            getBusinesses(category: Constants.restaurantKey, location: userLocation!)
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
        }
    }
    
    // MARK: - Yelp API methods
    
    func getBusinesses(category: String, location: CLLocation) {
        var urlComponents = URLComponents(string: Constants.apiUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        if let url = url {
        
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(YelpAPI.key)", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                // Check that there isn't an error
                if error == nil {
                    // parse json
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        // sort businesses
                        var businesses = result.businesses
                        businesses.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        // get image data
                        for b in result.businesses {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            switch (category) {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                            case Constants.restaurantKey:
                                self.restaurants = result.businesses
                            default:
                                break
                            }
                        }
                        
                    } catch {
                        print(error)
                    }
                }
            }
            
            // Start the Data Task
            dataTask.resume()
        }
    }
}

