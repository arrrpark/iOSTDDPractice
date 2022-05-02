//
//  ToDoItem.swift
//  TestDrivenSample
//
//  Created by Arrr Park on 2022/05/01.
//

import Foundation
import CoreLocation

struct ToDoItem: Equatable {
    let title: String
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    init(title: String, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil)  {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
    
    static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        if lhs.title != rhs.title {
            return false
        }
        
        if lhs.itemDescription != rhs.itemDescription {
            return false
        }
        
        if lhs.timestamp != rhs.timestamp {
            return false
        }
        
        return lhs.location == rhs.location
    }
}
