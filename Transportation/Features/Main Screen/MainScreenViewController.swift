//
//  MainScreenViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 07/01/2022.
//

import UIKit

class MainScreenViewController: UIViewController {
  
    @IBOutlet weak var mainScreenImageView: UIImageView!
    @IBOutlet weak var homeScreenStackView: UIStackView!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    
    let historyManager = HistoryManager()
    var recentSearchedTrips = [RecentTrip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenImageView.setImage(url: Current.imageUrlString, placeholder: "metro")
        homeScreenStackView.layer.cornerRadius = 10
        toButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        fromButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentSearchedTrips = historyManager.getRecentTrips()
        tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }
 
    @IBAction func clickOnButton(_ sender: UIButton) {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController!)
        mainScreenCoordinator.showStation(toButtonClicked: sender == toButton)
    }
}

extension MainScreenViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent searches"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        recentSearchedTrips.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearchedTrips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recentDeparture = recentSearchedTrips[indexPath.row].start
        let recentDestination = recentSearchedTrips[indexPath.row].finish
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell", for: indexPath) as! SearchHistoryTableViewCell
        cell.setupHistoryCell(start: recentDeparture.name, finish: recentDestination.name)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let startStation = recentSearchedTrips[indexPath.row].start
        let finishStation = recentSearchedTrips[indexPath.row].finish
        let recentSearch = true
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController!)
        mainScreenCoordinator.showHistorySearch(historySearch: recentSearch, start: startStation, finish: finishStation)
    }
  
}
