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
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainScreenLogo: UIImageView!
    
    let historyManager = HistoryManager()
    var recentSearchedTrips = [RecentTrip]()
    var historySectionName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenImageView.setImage(url: Current.imageUrlString, placeholder: "metro")
        homeScreenStackView.layer.cornerRadius = 10
        mainScreenLogo.layer.cornerRadius = 5
        startButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        finishButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 18)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
        historySectionName = "main_screen_history_section_name".localized()
        startButton.setTitle("main_screen_start_placeholder_text".localized(), for: UIControl.State())
        finishButton.setTitle("main_screen_finish_placeholder_text".localized(), for: UIControl.State())
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
        mainScreenCoordinator.showStation(toButtonClicked: sender == finishButton)
    }
}

extension MainScreenViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return historySectionName
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


