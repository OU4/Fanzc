//
//  Models.swift
//  Fanzc
//
//  Created by Abdulaziz dot on 05/10/2024.
//

import Foundation
import CoreLocation

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let location: CLLocationCoordinate2D
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let username: String
    let score: Int
}
