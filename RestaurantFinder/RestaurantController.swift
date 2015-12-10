//
//  RestaurantController.swift
//  RestaurantFinder
//
//  Created by Michael Sacks on 12/9/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import MapKit

class RestaurantController {
    
    static func getRestaurants(location: CLLocation, completion:(restaurants: [Restaurant]) -> Void) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "Restaurants"
        request.region = MKCoordinateRegionMakeWithDistance(location.coordinate, 20, 20)
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response, error) -> Void in
            guard let response = response else {
                print("Seach error \(error?.localizedDescription)")
                return
            }
            
            var arrayOfRestaurants = [Restaurant]()
            for item in response.mapItems {
                guard let name = item.name else {
                    continue
                }
                
                let newRestaurant = Restaurant(name: name, placemark: item.placemark)
                arrayOfRestaurants.append(newRestaurant)
            }
            completion(restaurants: arrayOfRestaurants)
        }
    }
}
