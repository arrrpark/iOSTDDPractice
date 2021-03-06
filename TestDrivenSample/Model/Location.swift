//
//  Location.swift
//  TestDrivenSample
//
//  Created by Arrr Park on 2022/05/01.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.coordinate?.latitude == rhs.coordinate?.latitude && lhs.coordinate?.longitude == rhs.coordinate?.longitude
    }
}
