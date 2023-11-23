//
//  CovidRequirement.swift
//  CovidTracker
//
//  Created by Azul Rosales on 23/11/23.
//

import Foundation

protocol CovidRequirementProtocol {
    func getCovidData(country: String) async -> CovidData?
}

class CovidRequirement: CovidRequirementProtocol {
    static let shared = CovidRequirement()
    
    let covidRepository: CovidRepository
    
    init(covidRepository: CovidRepository = CovidRepository.shared) {
        self.covidRepository = covidRepository
    }
    
    func getCovidData(country: String) async -> CovidData? {
        do {
            print("Making API request for country: \(country)")
            let result = try await covidRepository.getCovidData(country: country)
            return result
        } catch {
            print("Error fetching Covid data: \(error)")
            return nil
        }
    }

}
