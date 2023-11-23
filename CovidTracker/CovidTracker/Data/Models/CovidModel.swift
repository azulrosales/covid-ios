//
//  CovidModel.swift
//  CovidTracker
//
//  Created by Azul Rosales on 23/11/23.
//

import Foundation

// Struct to represent the "cases" object
struct CovidCases: Codable {
    var total: Int
    var new: Int
}

// Struct to represent the date-specific data
struct CovidDate: Codable {
    var total: Int
    var new: Int
}

// Struct to represent the top-level object
struct CovidData: Codable, Identifiable {
    var id = UUID()
    var country: String
    var region: String
    var cases: [String: CovidDate]
    
    private enum CodingKeys: String, CodingKey {
            case country, region, cases
        }
}
