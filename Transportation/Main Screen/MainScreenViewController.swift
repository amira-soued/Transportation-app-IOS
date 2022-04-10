//
//  MainScreenViewController.swift
//  Transportation
//
//  Created by MacBook Pro on 07/01/2022.
//

import UIKit

class MainScreenViewController: UIViewController {
  
    @IBOutlet weak var homeScreenStackView: UIStackView!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    
    let historyManager = HistoryManager()

    var recentTrips = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenStackView.layer.cornerRadius = 10
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: "searchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "searchHistoryTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentTrips = historyManager.getRecentTrips()
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
        recentTrips.isEmpty ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentTrips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = recentTrips[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchHistoryTableViewCell", for: indexPath) as! SearchHistoryTableViewCell
        cell.setupHistoryCell(from: text, to: "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
}
