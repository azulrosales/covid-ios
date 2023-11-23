//
//  NetworkAPIService.swift
//  CovidTracker
//
//  Created by Azul Rosales on 23/11/23.
//

import Foundation
import Alamofire

/// Service for handling network requests related to the CovidTracker app.
class NetWorkAPIService {
    // Singleton instance of the network service
    static let shared = NetWorkAPIService()
    
    func getCovidData(url: URL, country: String) async -> CovidData? {
        let parameters : Parameters = [ // Request parameters
            "country" : country
        ]
        let headers: HTTPHeaders = ["X-Api-Key": "wLVPN1zV08lJYF7uXqgyPw==zVwp6TlVcAO1NLUf"]
        
        // Request:
        let taskReq = AF.request(url, method: .get, parameters: parameters, headers: headers).validate()
        // Response:
        let response = await taskReq.serializingData().response
        
        switch response.result {
        case let .success(data):
            do {
                return try JSONDecoder().decode(CovidData.self, from: data)
            } catch {
                return nil
            }
        case let .failure(error):
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}


