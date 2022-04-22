//
//  LoadingViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 22/04/2022.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

class LoadingViewController: UIViewController {

    @IBOutlet weak var loadingImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let stringURL = "https://cdn.pixabay.com/photo/2020/03/23/06/11/metro-4959523_1280.jpg"
        guard let baseURL = URL(string: stringURL) else {
            print("error receiving url")
            return
        }
        loadingImage.contentMode = .bottom
        loadingImage.sd_setImage(with: baseURL, completed: {
            downloadedImage , downloadException, cacheType, downloadURL in
            if let downloadException = downloadException {
                print("error downloading the image \(downloadException.localizedDescription)")
            } else {
                return
            }
        })
        startAnimation()
        
    }
    
    private func startAnimation(){
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballClipRotatePulse, color: .black, padding: 0)
        view.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 60),
            loading.heightAnchor.constraint(equalToConstant: 60),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
        loading.startAnimating()
    }
   
}
