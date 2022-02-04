//
//  NavigationManager.swift
//  Transportation
//
//  Created by MacBook Pro on 07/01/2022.
//

import UIKit

class NavigationManager{

    let window : UIWindow?
    private var navigationController : UINavigationController?
    init(window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start(){
        //showMainScreen()
        navigationController = UINavigationController()
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController!)
        mainScreenCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
