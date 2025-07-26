//
//  Team.swift
//  KLeague-Weather
//
//  Created by JunnKyuu on 7/24/25.
//

import Foundation

struct Team {
    let id: Int
    let name: String
    let league: League
    let logoURL: String
    let stadiumName: String
    let nx: String
    let ny: String
}

enum League: String, CaseIterable {
    case kLeague1 = "K리그1"
    case kLeague2 = "K리그2"
}
