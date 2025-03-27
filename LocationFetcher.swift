//
//  LocationFetcher.swift
//  HackingWithSwift
//
//  Created by Ajay Sangwan on 19/03/25.
//

import CoreLocation
import SwiftUI

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func start(){
        // ✅ Avoid calling locationServicesEnabled() directly
            if manager.authorizationStatus == .notDetermined {
                manager.requestWhenInUseAuthorization()
            } else if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
                manager.startUpdatingLocation()
            }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {  // ✅ Use the most recent location
                    lastKnownLocation = location.coordinate
                    print("📍 Location updated: \(lastKnownLocation!.latitude), \(lastKnownLocation!.longitude)")
                    
                    // Stop updating to save battery after getting a location
                    manager.stopUpdatingLocation()
                }
    }
}
