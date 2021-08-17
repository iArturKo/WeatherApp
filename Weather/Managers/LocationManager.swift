//
//  LocationManager.swift
//  Weather
//
//  Created by Артур Кононович on 10.06.21.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    var locations = BehaviorRelay(value: [Location]())
    let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        
        if UserDefaults.wasAppLaunched() {
            self.loadLocations()
        } else {
            self.saveLocations()
            UserDefaults.setAppWasLaunched()
        }
        self.configureLocationManager()
    }
    
    func addLocation(location: Location) {
        var locations = self.locations.value
        locations.append(location)
        self.locations.accept(locations)
        self.saveLocations()
    }
    
    func removeLocation(indexPath: IndexPath) {
        var locations = self.locations.value
        locations.remove(at: indexPath.row)
        self.locations.accept(locations)
        self.saveLocations()
    }
    
    func configureLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func saveLocations() {
        var locations = self.locations.value
        
        if !locations.isEmpty {
            locations.removeFirst()
        }
        
        UserDefaults.standard.set(encodable: locations, forKey: "locations")
    }
    
    func loadLocations() {
        guard let locations = UserDefaults.standard.value([Location].self, forKey: "locations") else {
            return
        }
        self.locations.accept(locations)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {
            return
        }
        print("locations = \(location.coordinate.latitude) \(location.coordinate.longitude)")
        manager.stopUpdatingLocation()
        
        let geo = CLGeocoder()
        geo.reverseGeocodeLocation(location) { place, error in
            var locations = self.locations.value
            locations.insert(Location(title: place?.first?.locality ?? "", coordinates: location.coordinate), at: 0)
            self.locations.accept(locations)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


