//
//  Constant.swift
//  BoredApiApp
//
//  Created by Nguyen Loc on 3/12/22.
//

import Foundation

struct Constant {
    static let baseUrl = "http://www.boredapi.com/api/"
}

enum ActivityType: String {
    case Education = "education"
    case Recreational = "recreational"
    case Social = "social"
    case Diy = "diy"
    case Charity = "charity"
    case Cooking = "cooking"
    case Relaxation = "relaxation"
    case Music = "music"
    case Busywork = "busywork"
}
