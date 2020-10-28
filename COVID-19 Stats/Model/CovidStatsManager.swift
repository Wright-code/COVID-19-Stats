//
//  CovidStatsController.swift
//  COVID-19 Stats
//
//  Created by Harry Wright on 12/10/2020.
//

import Foundation

protocol CovidStatsDelegate {
    func didUpdateCovidStats(stats: CovidStatsModel)
    func didFailWithError(_ error: Error)
}

struct CovidStatsManager {
    
    
    var delegate: CovidStatsDelegate?
    
    var url: String = "https://api.covid19api.com/summary"
    
    func performRequests(url: String, country: Int) {
        
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let covidData = self.parseJSON(covidData: safeData, country: country) {
                        self.delegate?.didUpdateCovidStats(stats: covidData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(covidData: Data, country: Int) -> CovidStatsModel? {
        let decoder = JSONDecoder()
        do {
            var countriesArrayTwo = [String]()
            let decodedData = try decoder.decode(CovidStats.self, from: covidData)
            let totalConfirmed = decodedData.Countries[country].TotalConfirmed
            let totalDeaths = decodedData.Countries[country].TotalDeaths
            let totalReovered = decodedData.Countries[country].TotalRecovered
            let countriesName = decodedData.Countries
            let newConfirmed = decodedData.Countries[country].NewConfirmed
            let date = decodedData.Countries[country].Date
            for country in countriesName {
                countriesArrayTwo.append(country.Country)
            }
            print(countriesArrayTwo)
            let covidStatsModelObeject = CovidStatsModel(totalConfirmed: totalConfirmed, totalDeaths: totalDeaths, totalRecovered: totalReovered, countryNumebr: countriesArrayTwo.count, countries: countriesArrayTwo, newConfirmed: newConfirmed, date: date)
            return covidStatsModelObeject
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}



