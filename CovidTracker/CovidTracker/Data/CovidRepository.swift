//
//  CovidRepository.swift
//  CovidTracker
//
//  Created by Azul Rosales on 23/11/23.
//

import Foundation

// Structure to hold API endpoint details
struct Api {
    static let base: String = "https://api.api-ninjas.com/v1/"
    
    struct route {
        static let covid: String = "/covid19"
    }
}

// Protocol defining the Covid API methods
protocol CovidAPIProtocol {
    
    //https://api.api-ninjas.com/v1/covid19?country=
    func getCovidData(country: String) async -> CovidData?
}

/// Class implementing the Covid API methods
class CovidRepository: CovidAPIProtocol {
    static let shared = CovidRepository()
    
    let n_service: NetWorkAPIService
    init(n_service: NetWorkAPIService = NetWorkAPIService.shared){
        self.n_service = n_service
    }
    
    func getCovidData(country: String) async -> CovidData? {
        return await n_service.getCovidData(url: URL(string: "\(Api.base)\(Api.route.covid)")!, country: country)
    }
}
