//
//  Activity.swift
//  Activities
//
//  Created by Anton Karazeev on 15/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ServerTokenMessage: Decodable {
    let token: String
}

struct Activity: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var category: Category
    var distance: Int
    var heartrate: Int
    var time: Int
    var difficulty: Difficulty
    var datetime: String
    var isfavorite: Bool

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
