//
//  ContentView.swift
//  CovidTracker
//
//  Created by Azul Rosales on 23/11/23.
//

import SwiftUI

// Helper function to group cases by week
extension CovidData {
    func groupCasesByWeek() -> [String: CovidCases] {
        var weeklyCases: [String: CovidCases] = [:]

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for (date, covidDate) in cases {
            if let formattedDate = dateFormatter.date(from: date) {
                let calendar = Calendar.current
                let weekOfYear = calendar.component(.weekOfYear, from: formattedDate)
                let year = calendar.component(.year, from: formattedDate)

                let weekKey = "\(year)-W\(weekOfYear)"

                if let existingWeek = weeklyCases[weekKey] {
                    weeklyCases[weekKey] = CovidCases(total: existingWeek.total + covidDate.total, new: existingWeek.new + covidDate.new)
                } else {
                    weeklyCases[weekKey] = CovidCases(total: covidDate.total, new: covidDate.new)
                }
            }
        }

        return weeklyCases
    }
}



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
                    },
            "2020-02-07": {
                "total": 0,
                "new": 0
            },
            "2020-02-08": {
                "total": 0,
                "new": 0
            },
            "2020-02-09": {
                "total": 0,
                "new": 0
            },
            "2020-02-10": {
                "total": 0,
                "new": 0
            },
            "2020-02-11": {
                "total": 0,
                "new": 0
            },
            "2020-04-24": {
                "total": 12872,
                "new": 1239
            },
            "2020-04-25": {
                "total": 13842,
                "new": 970
            },
            "2020-04-26": {
                "total": 14677,
                "new": 835
            },
            "2020-04-27": {
                "total": 15529,
                "new": 852
            },
            "2020-04-28": {
                "total": 16752,
                "new": 1223
            },
                }
            }
        ]
        """

    var body: some View {
        List {
            ForEach(covidData) { data in
                VStack(alignment: .leading) {
                    Text("Country: \(data.country)")
                        .font(.headline)
                    Text("Region: \(data.region)")
                        .font(.subheadline)

                    // Move the outer loop inside to create a new card for each country
                    ForEach(data.groupCasesByWeek().sorted(by: { $0.key < $1.key }), id: \.key) { week, weeklyCases in
                        VStack(alignment: .leading) {
                            Text("Week: \(week)")
                                .font(.caption)
                            Text("Total Cases: \(weeklyCases.total)")
                            Text("New Cases: \(weeklyCases.new)")
                        }
                        .padding(.leading, 20) // Indentation
                        .background(Color.gray.opacity(0.1)) // Card background
                        .cornerRadius(10)
                        .padding(10) // Padding around the card
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
        return ContentView()
    }
}

