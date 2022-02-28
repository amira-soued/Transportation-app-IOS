//
//  StationViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 10/01/2022.
//

import UIKit
import FirebaseFirestore

enum Cell {
    case stationCell(Station)
}

class StationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var stationScreenStackView: UIStackView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var cells: [Cell] = []

    var isFromTo: Bool = true
    var firebaseClient = FirebaseClient()
    var startStation: Station?
    var endStation: Station?

    /// Represents all the stations recieved by the Backend
    var allStationsArray = [Station]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationScreenStackView.layer.cornerRadius = 10
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
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 300, right: 0)
        fromTextField.delegate = self
        toTextField.delegate = self
        loadData()
    }
    
    @IBAction func textFieldTyping(_ sender: UITextField) {
        let searchText  = sender.text ?? ""
        tableView.isHidden = false
        cells = allStationsArray.compactMap { station in
            if station.name?.range(of: searchText, options: .caseInsensitive) != nil {
                return .stationCell(station)
            }
            return nil
        }
        tableView.reloadData()
    }
  
    @IBAction func backToMainScreen(_ sender: Any) {
        let coordinator = StationCoordinator(navigationController: navigationController)
        coordinator.dismissStationScreen()
    }
}

extension StationViewController : UITableViewDelegate, UITableViewDataSource{
    
    func loadData() {
        firebaseClient.getStations{ stations in
            self.allStationsArray = stations
            self.cells.removeAll()
            for station in self.allStationsArray {
                self.cells.append(.stationCell(station))
            }
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cells[indexPath.row]
        switch cellType {
        case .stationCell(let station) :
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "stationCell")
            cell.textLabel?.text = station.name
            cell.textLabel?.font = .systemFont(ofSize: 20, weight: .medium)
            cell.detailTextLabel?.text = station.city
            cell.detailTextLabel?.font = .systemFont(ofSize: 15, weight: .light)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = cells[indexPath.row]
        switch cellType {
        case .stationCell(let station):
            if fromTextField.isFirstResponder {
                fromTextField.text = station.name
                startStation = station
                if endStation == nil {
                    toTextField.becomeFirstResponder()
                    textFieldTyping(toTextField)
                }
            } else {
                toTextField.text = station.name
                endStation = station
                if startStation == nil {
                    fromTextField.becomeFirstResponder()
                    textFieldTyping(fromTextField)
                }
            }
        }
        tableView.reloadData()
    }
}
