//
//  CovidStats.swift
//  COVID-19 Stats
//
//  Created by Harry Wright on 12/10/2020.
//

import Foundation

struct CovidStats: Decodable {
    let Countries: [Countries]
}

struct Countries: Decodable {
    let Country: String
    let TotalConfirmed: Int
    let TotalDeaths: Int
    let TotalRecovered: Int
    let NewConfirmed: Int
    let Date: String
}
