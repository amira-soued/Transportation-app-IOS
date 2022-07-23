//
//  LoadingCoordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 22/04/2022.
//

import UIKit
import Coordinator
class LoadingCoordinator : Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController : UINavigationController

    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start(){
        guard let viewController = UIStoryboard(name: "Loading", bundle: nil)
            .instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController else {
            return
        }
        self.navigationController.setViewControllers([viewController], animated: false)
    }
}
