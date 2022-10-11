//
//  BusinessSearch.swift
//  City-Sights
//
//  Created by Jacob Summerville on 10/10/22.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
