//
//  Item.swift
//  WikiPotter
//
//  Created by Rizal Khanafi on 22/11/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
