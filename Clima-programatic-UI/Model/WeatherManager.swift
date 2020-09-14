//
//  WeatherManager.swift
//  Clima-programatic-UI
//
//  Created by Raghav Vashisht on 14/09/20.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    let API_KEY = "&appid=32a035ed00c3d6f12f7eabee9c76a4ca"
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    
    func fetchWeather(cityName: String) {
        let URL = "\(baseURL)\(API_KEY)&q=\(cityName)"
        performRequest(with: URL)
    }
    
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let URL = "\(baseURL)\(API_KEY)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: URL)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, res, err) in
                if err != nil {
                    delegate?.didFailWithError(error: err!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(id: id, cityName: name, temp: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
