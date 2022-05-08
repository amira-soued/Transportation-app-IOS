//
//  UIImageView + Extension.swift
//  Transportation
//
//  Created by MacBook Pro on 03/05/2022.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func setImage(url: String?, placeholder: String = "") {
        guard let baseURL = URL(string: url ?? "") else {
            print("error receiving url")
            return
        }        
        self.sd_setImage(with: baseURL, placeholderImage: UIImage(named: placeholder)!, options: .refreshCached, context: nil)
    }
}
