//
//  StationViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 10/01/2022.
//

import UIKit
import FirebaseFirestore

class StationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var stationScreenStackView: UIStackView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
   
    var isFromTo: Bool = true
    let viewModel = StationViewModel()
    var firebaseClient = FirebaseClient()

    /// Represents al thel stations to be displayed
    var stationsArray = [Station]()

    /// Represents all the stations recieved by the Backend
    var allStationsArray = [Station]() {
        didSet{
            stationsArray = allStationsArray
        }
    }

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
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true

        fromTextField.delegate = self
        toTextField.delegate = self

        loadData()
    }
    
    @IBAction func tfEditing(_ sender: Any) {
    }
    
    @IBAction func backToMainScreen(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
}
extension StationViewController : UITableViewDelegate, UITableViewDataSource{
    
    func loadData() {
        firebaseClient.getStations{ stations in
            self.allStationsArray = stations
            self.tableView.reloadData()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let searchText  = textField.text!
        stationsArray = allStationsArray.filter({ (station) -> Bool in
            return station.name?.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
        
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsArray.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "stationCell")
        cell.textLabel?.text = stationsArray[indexPath.row].name
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        return cell
    }
}
