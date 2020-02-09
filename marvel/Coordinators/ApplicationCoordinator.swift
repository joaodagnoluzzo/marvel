//
//  ApplicationCoordinator.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow!
    private let rootViewController: UINavigationController!
    private var homeCoordinator: HomeCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.isTranslucent = false
        self.rootViewController.navigationBar.prefersLargeTitles = true
        self.rootViewController.view.backgroundColor = UIColor(named: "SystemColorAdaptive")
        self.homeCoordinator = HomeCoordinator(presenter: rootViewController)
    }
    
    func start(){
        window.rootViewController = rootViewController
        homeCoordinator?.start()
        self.window.makeKeyAndVisible()
    }
}
