//
//  Item.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
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
