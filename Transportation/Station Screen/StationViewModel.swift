//
//  StationViewModel.swift
//  Transportation
//
//  Created by MacBook Pro on 12/01/2022.
//

import UIKit

class StationViewModel{
    
    var firebaseClient = FirebaseClient()
    func placeholderWhite(text: String, textField : UITextField){
        let placeholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white] )
        textField.attributedPlaceholder = placeholder
    }
 }
