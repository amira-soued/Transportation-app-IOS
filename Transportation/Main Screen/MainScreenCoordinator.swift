//
//  MainScreenCoordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 12/01/2022.
//

import UIKit
class MainScreenCoordinator{

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
    
    func showStation(buttonClicked: UIButton, whichButton: UIButton){
        let coordinator = StationCoordinator(navigationController: navigationController)
        coordinator.start(buttonClicked: buttonClicked, whichButton: whichButton)
        self.navigationController.isToolbarHidden = true
    }
}
