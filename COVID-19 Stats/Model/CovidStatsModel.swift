//
//  CovidStatsModel.swift
//  COVID-19 Stats
//
//  Created by Harry Wright on 12/10/2020.
//

import Foundation

struct CovidStatsModel {
    let totalConfirmed: Int
    let totalDeaths: Int
    let totalRecovered: Int
    let countryNumebr: Int
    let countries: [String]
    let newConfirmed: Int
    let date: String
    
    var simpleDate: String {
        String(date.prefix(10))
    }
    
    var simpleDay: String {
        String(simpleDate.dropFirst(8))
    }
    
    var simpleMonth: String {
        String(simpleDate.dropFirst(5).dropLast(3))
    }
    
    var simpleYear: String {
        String(simpleDate.dropLast(6))
    }
    
    var newConfirmedString: String {
        String(newConfirmed)
    }
    
    var totalConfirmedString: String {
        String(totalConfirmed)
    }
    
    var totalDeathsString: String {
        String(totalDeaths)
    }
    
    var totalRecoveredString: String {
        String(totalRecovered)
    }
    
}
