//
//  Activity.swift
//  Activities
//
//  Created by Anton Karazeev on 15/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Activity: Hashable, Codable {
    var name: String
    var category: Category
    var distance: Int
    var heartrate: Int
    var time: Int
    var difficulty: Difficulty
    var datetime: String

    enum Category: String, CaseIterable, Codable, Hashable {
        case swimming = "swimming"
        case running = "running"
        case cycling = "cycling"
    }
    
    enum Difficulty: String, CaseIterable, Codable, Hashable {
        case easy = "easy"
        case hard = "hard"
    }
}
