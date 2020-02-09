//
//  HomeCoordinator.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    private let presenter: UINavigationController!
    private var homeViewController: HomeViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start(){
        let homeViewController = HomeViewController()
        self.presenter.pushViewController(homeViewController, animated: true)
        self.homeViewController = homeViewController
        self.homeViewController?.title = "Characters"
    }
}
