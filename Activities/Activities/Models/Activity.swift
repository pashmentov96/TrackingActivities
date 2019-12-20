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
    var category: String
    var difficulty: String
    var distance: Int
    var heartrate: Int
    var time: Int
    var datetime: String
    var isfavorite: Bool
}

extension Activity {
    var image: Image {
        ImageStore.shared.image(name: category)
    }
}
