//
//  Location.swift
//  Weather
//
//  Created by Артур Кононович on 14.08.21.
//

import Foundation
import CoreLocation

class Location: NSObject, Codable {
    var title: String
    var coordinates: CLLocationCoordinate2D
    
    init(title: String, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.coordinates = coordinates
    }
    
    public enum CodingKeys: String, CodingKey {
        case title, coordinatesLatitude, coordinatesLongitude
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.title, forKey: .title)
        try container.encode(self.coordinates.latitude, forKey: .coordinatesLatitude)
        try container.encode(self.coordinates.longitude, forKey: .coordinatesLongitude)
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        let latitude = try container.decode(Double.self, forKey: .coordinatesLatitude)
        let longitude = try container.decode(Double.self, forKey: .coordinatesLongitude)
        self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
