//
//  StationViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 10/01/2022.
//

import UIKit
import FirebaseFirestore

class StationViewController: UIViewController {

    @IBOutlet weak var stationScreenStackView: UIStackView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    var isFromTo: Bool = true
    let viewModel = StationViewModel()
    var firebaseClient = FirebaseClient()
    let database = Firestore.firestore()
    //var data = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationScreenStackView.layer.cornerRadius = 10
        viewModel.placeholderWhite(text: "From:", textField: fromTextField)
        viewModel.placeholderWhite(text: "To:", textField: toTextField)
        if isFromTo{
            toTextField.becomeFirstResponder()
        } else {
            fromTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func tfEditing(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DepartureStationViewController") as? DepartureStationViewController else {
            return
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
    
    @IBAction func backToMainScreen(_ sender: Any) {
        guard let trainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainScreenViewController") as? MainScreenViewController else {
            return
        }
        trainViewController.modalPresentationStyle = .fullScreen
        present(trainViewController, animated: false)
    }
}
