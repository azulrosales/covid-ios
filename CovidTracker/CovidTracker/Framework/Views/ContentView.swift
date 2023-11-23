//
//  ContentView.swift
//  CovidTracker
//
//  Created by Azul Rosales on 23/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var covidData: [CovidData] = [] // Assuming this is your fetched data

    let jsonString = """
        [
            {
                "country": "Mexico",
                "region": "",
                "cases": {
                    "2020-01-22": {
                        "total": 0,
                        "new": 0
                    },
                    "2020-01-23": {
                        "total": 0,
                        "new": 0
                    }
                }
            }
        ]
        """
    
    var body: some View {
            List(covidData) { data in
                VStack(alignment: .leading) {
                    Text("Country: \(data.country)")
                        .font(.headline)
                    Text("Region: \(data.region)")
                        .font(.subheadline)

                    // Iterate through cases
                    ForEach(data.cases.sorted(by: { $0.key < $1.key }), id: \.key) { date, covidDate in
                        VStack(alignment: .leading) {
                            Text("Date: \(date)")
                                .font(.caption)
                            Text("Total Cases: \(covidDate.total)")
                            Text("New Cases: \(covidDate.new)")
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                do {
                    let jsonData = jsonString.data(using: .utf8)!
                    covidData = try JSONDecoder().decode([CovidData].self, from: jsonData)
                } catch {
                    print("Error decoding predefined JSON data: \(error)")
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
