//
//  Restaurant.swift
//  RestaurantFinder
//
//  Created by Michael Sacks on 12/9/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Restaurant: NSObject {

    var name: String
    var coordinates: CLLocation?
    var placemark: MKPlacemark
    
    init(name: String, placemark: MKPlacemark) {
        self.name = name
        self.placemark = placemark
        self.coordinates = placemark.location
    }
    
}
