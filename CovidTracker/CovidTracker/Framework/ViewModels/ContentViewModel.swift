//
//  ContentViewModel.swift
//  CovidTracker
//
//  Created by Azul Rosales on 23/11/23.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var covidData = [CovidData]()

    var covidRequirement: CovidRequirementProtocol

    init(covidRequirement: CovidRequirementProtocol = CovidRequirement.shared) {
        self.covidRequirement = covidRequirement
    }

    @MainActor
    func getCovidData() async {
        print("Attempting to fetch Covid data...")
        do {
            print("Inside do block")
            if let result = try await covidRequirement.getCovidData(country: "canada") {
                print("API Response: \(result)")
                covidData = [result]
            }
        } catch {
            print("Error fetching Covid data: \(error)")
        }
    }


}


