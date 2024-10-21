//
//  Expences.swift
//  SwiftDataExample
//
//  Created by Pasham Srinivas Goud on 17/10/24.
//

import Foundation
import SwiftData

@Model
class Expences
{
    @Attribute(.unique) var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
}
