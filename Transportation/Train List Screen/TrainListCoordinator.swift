//
//  TrainListCoordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 07/02/2022.
//

import UIKit
class TrainListCoordinator : Coordinator{
    let navigationController : UINavigationController?
    init(navigationController : UINavigationController?) {
        self.navigationController = navigationController
    }
    var childCoordinators : [Coordinator] = []
    var departureStation : String?
    
    func start(){
         showTrainListScreen()
    }
    
    func showTrainListScreen(){
        let trainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrainListViewController") as? TrainListViewController
        trainViewController?.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(trainViewController!, animated: true)
    }
    
    func dismissTrainScreen(){
        guard let stationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationViewController") as? StationViewController else {
             return
         }
        stationViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: true)
    }
}
