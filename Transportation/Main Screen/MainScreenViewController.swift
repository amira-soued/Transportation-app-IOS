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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreenStackView.layer.cornerRadius = 10
        tableView.dataSource = self
        tableView.delegate = self
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
        tableView.tableHeaderView = header
        tableView.separatorColor = .white
        tableView.register(UINib(nibName: "searchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "searchHistoryTableViewCell")
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        UIStatusBarStyle.lightContent
    }
 
    @IBAction func clickOnButton(_ sender: UIButton) {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController!)
        mainScreenCoordinator.showStation(toButtonClicked: sender == toButton)
    }
}

extension MainScreenViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if offset > 0 {
            headerTopConstraint.constant = -offset
        }
        if offset <= 0 {
            headerTopConstraint.constant = 260
        }
        print(offset)
    }
}

extension MainScreenViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent searches"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 80
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = "hello"
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchHistoryTableViewCell", for: indexPath) as! searchHistoryTableViewCell
        cell.setupHistoryCell(from: text, to: text)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
}
