//
//  ViewController.swift
//  Clima-programatic-UI
//
//  Created by Raghav Vashisht on 13/09/20.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController {
    
    //MARK: - UI Elements
    
    var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    var locationBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(locationBtnPressed), for: .touchUpInside)
        return button
    }()
    
    var searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemFill
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        textField.returnKeyType = .go
        return textField
    }()
    
    var searchBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(searchBtnPressed), for: .touchUpInside)
        return button
    }()
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
       return imageView
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 80, weight: .black)
        label.text = "21°C"
        return label
    }()
    
    var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.text = "London"
        return label
    }()
    
    
    //MARK: - Variables
    
    var manager = WeatherManager()
    var locationManager = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backgroundImage)
        view.addSubview(topStackView)
        view.addSubview(weatherImageView)
        view.addSubview(tempLabel)
        view.addSubview(cityLabel)
        configureBgImageView()
        configureTopStackView()
        configureWeatherImageView()
        configureTempLabel()
        configureCityLabel()
        searchTextField.delegate = self
        manager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    //MARK: - UI config
    
    private func configureCityLabel() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5).isActive = true
        cityLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
    
    private func configureTempLabel() {
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 20).isActive = true
        tempLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
    
    private func configureWeatherImageView() {
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 20).isActive = true
        weatherImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        weatherImageView.tintColor = UIColor(named: "bgColor")
    }
    
    
    private func configureTopStackView() {
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        topStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        topStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        topStackView.addArrangedSubview(locationBtn)
        topStackView.addArrangedSubview(searchTextField)
        topStackView.addArrangedSubview(searchBtn)
    }
    
    
    private func configureBgImageView() {
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImage.contentMode = .scaleAspectFill
        
        
    }
    
    
    //MARK: - Action functions
    
    @objc func searchBtnPressed() {
        searchTextField.endEditing(true)
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
        searchTextField.endEditing(true)
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
        if let city = searchTextField.text {
            manager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
        
    }
}


//MARK: - WeatherManagerDelegate

extension WeatherVC: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.tempLabel.text = weather.tempString + "°C"
            self.weatherImageView.image = UIImage(systemName: weather.condition)
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
