//
//  CitySearchViewModel.swift
//  Weather
//
//  Created by Артур Кононович on 30.07.21.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

class CitySearchViewModel: NSObject {
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = BehaviorRelay(value: [MKLocalSearchCompletion]())
    
    func setup() {
        searchCompleter.resultTypes = .address
        searchCompleter.delegate = self
    }
    
    func addQuery(query: String) {
        if query.isEmpty {
            searchResults.accept([])
        } else {
            searchCompleter.queryFragment = query
        }
    }
    
    func searchLocation(completion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let selectedItem = response?.mapItems.first?.placemark {
                LocationManager.shared.addLocation(location: Location(title: selectedItem.name ?? "", coordinates: selectedItem.coordinate))
            }
        }
    }
}

extension CitySearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults.accept(searchCompleter.results)
    }
}
