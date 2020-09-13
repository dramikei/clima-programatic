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


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backgroundImage)
        configureBgImageView()
        
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
//        ViewController()
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
