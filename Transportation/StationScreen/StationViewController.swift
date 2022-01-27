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
    let database = Firestore.firestore()
    var searchedArray:[String] = Array()
    var stations = [Station]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var tableFilterData = [String]()
    var allStations = [Station]() {
        didSet {
            DispatchQueue.main.async {
                self.stations = self.allStations
            }
        }
    }
    var stationsNamesTable : [String] = Array()

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
        tableView.reloadData()
        tableView.allowsSelection = true
        loadData()
        tableView.isHidden = true
        fromTextField.delegate = self
        toTextField.delegate = self
        
    }
    
    @IBAction func tfEditing(_ sender: Any) {
        tableView.isHidden = false
    }
    
    @IBAction func backToMainScreen(_ sender: Any) {
        guard let trainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainScreenViewController") as? MainScreenViewController else {
            return
        }
        trainViewController.modalPresentationStyle = .fullScreen
        present(trainViewController, animated: false)
    }
}
extension StationViewController : UITableViewDelegate, UITableViewDataSource{
    
    func loadData() {
        firebaseClient.getStations{ stations in
            self.allStations = stations
            
            for stationNames in stations{
                
                self.stationsNamesTable.append(stationNames.name!)
            }
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let searchText  = textField.text!
        self.tableFilterData.removeAll()
        if searchText.count > 0 {
            tableView.isHidden = false
            
            tableFilterData = stationsNamesTable.filter({ (result) -> Bool in
                return result.range(of: searchText, options: .caseInsensitive) != nil
                
            })
            
            tableView.reloadData()
        }
        else{
            tableView.isHidden = true
            tableFilterData = []
        }
        
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableFilterData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "stationCell")
        cell.textLabel?.text = tableFilterData[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        cell.detailTextLabel?.text = stations[indexPath.row].city
        cell.detailTextLabel?.font = .systemFont(ofSize: 15, weight: .light)
        return cell
    }
}
