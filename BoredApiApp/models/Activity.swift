//
//  Activity.swift
//  BoredApiApp
//
//  Created by Nguyen Loc on 3/12/22.
//

import Foundation

struct Activity: Codable {
    let activity: String
    let accessibility: Double
    let type: String
    let participants: Int
    let price: Double
    let key: String
}
