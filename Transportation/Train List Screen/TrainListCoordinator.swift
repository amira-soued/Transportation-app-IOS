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
    var fromButton: String = "" , toButton : String = ""
    var depID = "" , desID = ""
    func start(){
         showTrainListScreen()
    }
    
    func showTrainListScreen(){
        let trainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrainListViewController") as? TrainListViewController
        trainViewController?.modalPresentationStyle = .fullScreen
        trainViewController?.fromButtonName = fromButton
        trainViewController?.toButtonName = toButton
        trainViewController?.departureID = depID
        trainViewController?.destinationID = desID
        self.navigationController?.pushViewController(trainViewController!, animated: true)
    }
    
    func dismissTrainScreen(){
        guard let stationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationViewController") as? StationViewController else {
             return
         }
        stationViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.popViewController(animated: true)
    }
    
    func assignNames(from : String , to: String){
        fromButton = from
        toButton = to
    }
    
    func getStationsID(departureID : String , destinationID: String){
        depID = departureID
        desID = destinationID
    }
}
