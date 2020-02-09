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
    private var detailsCoordinator: DetailsCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start(){
        let homeViewController = HomeViewController()
        homeViewController.delegate = self
        self.presenter.pushViewController(homeViewController, animated: true)
        self.homeViewController = homeViewController
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewControllerShouldPresentDetailsOf(_ character: CharacterEntry) {
        self.detailsCoordinator = DetailsCoordinator(presenter: presenter, character: character)
        self.detailsCoordinator?.start()
    }
}
