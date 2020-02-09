//
//  DetailsCoordinator.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class DetailsCoordinator: Coordinator {
    
    private let presenter: UINavigationController?
    private let character: CharacterEntry?
    private var detailsViewController: DetailsViewController?
    
    init(presenter: UINavigationController, character: CharacterEntry) {
        self.presenter = presenter
        self.character = character
    }
    
    func start() {
        let detailsViewController = DetailsViewController()
        detailsViewController.character = self.character
        self.presenter?.pushViewController(detailsViewController, animated: true)
        self.detailsViewController = detailsViewController
    }
}
