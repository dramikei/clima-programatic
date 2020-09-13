//
//  ViewController.swift
//  Clima-programatic-UI
//
//  Created by Raghav Vashisht on 13/09/20.
//

import UIKit

class WeatherVC: UIViewController {
    
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
        return button
    }()
    
    var searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemFill
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        return textField
    }()
    
    var searchBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
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
    }
    
    
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
