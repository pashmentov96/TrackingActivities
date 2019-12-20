//
//  UserData.swift
//  Activities
//
//  Created by Anton Karazeev on 16/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var activities: [Activity]? = nil
    @Published var username: String = ""
    @Published var token: String = ""
    @Published var showFavoritesOnly = false
    @Published var isempty: Bool = true
}
