//
//  Coordinator.swift
//  Transportation
//
//  Created by MacBook Pro on 07/02/2022.
//

import Foundation
protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
    func start()
    func childDidFinish(childCoordinator: Coordinator)
}

extension Coordinator {
    func childDidFinish(childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: {
            (coordinator: Coordinator) -> Bool in
            childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
