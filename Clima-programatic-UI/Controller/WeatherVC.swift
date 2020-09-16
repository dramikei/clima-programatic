//
//  ViewController.swift
//  Clima-programatic-UI
//
//  Created by Raghav Vashisht on 13/09/20.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {
    
    //MARK: - Variables
    var weatherView = WeatherView()
    var manager = WeatherManager()
    var locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = weatherView
        weatherView.locationBtn.addTarget(self, action: #selector(locationBtnPressed), for: .touchUpInside)
        weatherView.searchBtn.addTarget(self, action: #selector(searchBtnPressed), for: .touchUpInside)
        weatherView.searchTextField.delegate = self
        manager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    //MARK: - Action functions
    
    @objc func searchBtnPressed() {
        weatherView.searchTextField.endEditing(true)
    }
    
    
    @objc func locationBtnPressed() {
        locationManager.requestLocation()
    }


}

//MARK: - CLLocationManagerDelegate

extension WeatherVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed with error: \(error)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = loc.coordinate.latitude
            let long = loc.coordinate.longitude
            self.manager.fetchWeather(latitude: lat, longitude: long)
        }
    }
}


//MARK: - UITextFieldDelegate

extension WeatherVC: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherView.searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text! == "" {
            textField.placeholder = "Type something"
            return false
        }
        textField.placeholder = "Search"
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = weatherView.searchTextField.text {
            manager.fetchWeather(cityName: city)
        }
        weatherView.searchTextField.text = ""
        
    }
}


//MARK: - WeatherManagerDelegate

extension WeatherVC: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.weatherView.cityLabel.text = weather.cityName
            self.weatherView.tempLabel.text = weather.tempString + "°C"
            self.weatherView.weatherImageView.image = UIImage(systemName: weather.condition)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print("Error occured: \(error)")
    }
}

//#if DEBUG
//import SwiftUI
//
//struct VCRepresentable: UIViewControllerRepresentable {
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//
//    @available(iOS 13.0.0, *)
//    func makeUIViewController(context: Context) -> UIViewController {
//        WeatherVC()
//    }
//}
//
//@available(iOS 13.0, *)
//struct VCPreview: PreviewProvider {
//    static var previews: some View {
//        VCRepresentable()
//    }
//}
//#endif
