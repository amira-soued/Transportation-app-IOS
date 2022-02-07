//
//  MainScreenCoordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 12/01/2022.
//

import UIKit
class MainScreenCoordinator: Coordinator{

    var childCoordinators: [Coordinator] = []
    var navigationController : UINavigationController
    init(navigationController: UINavigationController){
                self.navigationController = navigationController
            }
    
    func start(){
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "MainScreenViewController") as? MainScreenViewController else {
                    return
                }
        self.navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showStation(toButtonClicked : Bool){
        let coordinator = StationCoordinator(navigationController: navigationController)
        coordinator.status = toButtonClicked
        coordinator.start()
        self.navigationController.isToolbarHidden = true
    }
}
