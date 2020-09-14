//
//  WeatherData.swift
//  Clima-programatic-UI
//
//  Created by Raghav Vashisht on 14/09/20.
//

import Foundation


struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    
}
