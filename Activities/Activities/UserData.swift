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
    @Published var showFavoritesOnly = false
    @Published var activities = activityData
    @Published var username: String = "test_user"
    @Published var token: String = ""
//    @Published var token: String = "WdxnUke5rX6gXAqSeE/JJDV5GS+Znqt+"
    @Published var isempty: Bool = true
}
