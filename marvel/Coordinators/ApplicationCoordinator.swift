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
        setNavBarTextProperties()
        self.rootViewController.view.backgroundColor = UIColor(named: "MarvelRed")
        self.rootViewController.navigationBar.barTintColor = UIColor(named: "MarvelRed")
        self.rootViewController.navigationBar.tintColor = .white
        self.homeCoordinator = HomeCoordinator(presenter: rootViewController)
    }
    
    func start(){
        window.rootViewController = rootViewController
        homeCoordinator?.start()
        self.window.makeKeyAndVisible()
    }
    
    func setNavBarTextProperties(){
        guard let font = UIFont(name: "DINCondensed-Bold", size: 23) else { return }
        let attributes = [NSAttributedString.Key.font : font]
        let largeAttributes = [NSAttributedString.Key.font : font.withSize(35)]
        self.rootViewController.navigationBar.titleTextAttributes = attributes
        self.rootViewController.navigationBar.largeTitleTextAttributes = largeAttributes
    }
}
