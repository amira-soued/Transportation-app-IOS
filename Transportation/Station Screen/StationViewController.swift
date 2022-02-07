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
    var lastSelectedIndexPath = NSIndexPath(row: -1, section: 0)
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
        self.navigationController?.isNavigationBarHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.isHidden = true
        tableView.allowsMultipleSelection
        
        fromTextField.delegate = self
        toTextField.delegate = self
        
        loadData()
    }
    
    @IBAction func textFieldTyping(_ sender: UITextField) {
        let searchText  = sender.text!
        tableView.isHidden = false
        stationsArray = allStationsArray.filter({ (station) -> Bool in
            return station.name?.range(of: searchText, options: .caseInsensitive) != nil
        })
        tableView.reloadData()
    }
    
    
    @IBAction func backToMainScreen(_ sender: Any) {
       //dismiss(animated: true, completion: nil)
        guard let stationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainScreenViewController") as? MainScreenViewController else {
             return
         }
        stationViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(stationViewController, animated: false)
    }
    
}
extension StationViewController : UITableViewDelegate, UITableViewDataSource{
    
    func loadData() {
        firebaseClient.getStations{ stations in
            self.allStationsArray = stations
            self.tableView.reloadData()
        }
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
        cell.detailTextLabel?.text = stationsArray[indexPath.row].city
        cell.detailTextLabel?.font = .systemFont(ofSize: 15, weight: .light)
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//       let departureStation : String?
//       let destinationStation : String?
//        if stationsArray[indexPath.row] != nil {
//            departureStation = stationsArray[indexPath.row].name
//            fromTextField.text = departureStation
//
//        }
//        if indexPath.row != lastSelectedIndexPath.row {
//
//            let newCell = tableView.cellForRow(at: indexPath)
//            lastSelectedIndexPath = indexPath as NSIndexPath
//            destinationStation  = newCell?.textLabel?.text
//            toTextField.text = destinationStation
//
//        }
//    }
    func departureSelection(){
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            fromTextField.text = stationsArray[indexPath.row].name
        }
    }
    func destinationSelection(){
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            toTextField.text = stationsArray[indexPath.row].name
        }
    }
    
}
