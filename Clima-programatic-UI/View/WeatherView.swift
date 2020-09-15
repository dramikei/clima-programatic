//
//  WeatherView.swift
//  Clima-programatic-UI
//
//  Created by Raghav Vashisht on 15/09/20.
//

import UIKit

class WeatherView: UIView {
    
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
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        [backgroundImage, topStackView, weatherImageView, tempLabel, cityLabel].forEach { (elem) in
            addSubview(elem)
        }
        configureBgImageView()
        configureTopStackView()
        configureWeatherImageView()
        configureTempLabel()
        configureCityLabel()
    }
    
    
    private func configureCityLabel() {
        cityLabel.anchor(top: tempLabel.bottomAnchor, leading: nil, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 20), size: .init())
    }
    
    private func configureTempLabel() {
        tempLabel.anchor(top: weatherImageView.bottomAnchor, leading: nil, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20), size: .init())
    }
    
    private func configureWeatherImageView() {
        weatherImageView.anchor(top: topStackView.bottomAnchor, leading: nil, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 20), size: .init(width: 120, height: 120))
        weatherImageView.tintColor = UIColor(named: "bgColor")
    }
    
    
    private func configureTopStackView() {
        topStackView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20), size: .init())
        [locationBtn, searchTextField, searchBtn].forEach { (elem) in
            topStackView.addArrangedSubview(elem)
        }
    }
    
    
    private func configureBgImageView() {
        backgroundImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(), size: .init())
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
