//
//  DepartureStationViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 19/01/2022.
//

import UIKit

class DepartureStationViewController: UIViewController,UITableViewDataSource , UITableViewDelegate{

        @IBOutlet weak var tableView: UITableView!
   
    private var firebaseClient = FirebaseClient()
    private var allStations = [Station]() {
        didSet {
            DispatchQueue.main.async {
                self.stations = self.allStations
            }
        }
    }
    var stations = [Station]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.allowsSelection = true
        loadData()
        tableView.isHidden = true
    }
    func loadData() {
        firebaseClient.getStations{ stations in
            self.allStations = stations
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       //let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "stationCell")
        //cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = stations[indexPath.row].name
        cell.textLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        cell.detailTextLabel?.text = stations[indexPath.row].city
        cell.detailTextLabel?.font = .systemFont(ofSize: 15, weight: .light)
        return cell
    }
   
}

