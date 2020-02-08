//
//  HomeViewController.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    private var homeView: HomeView?
    private var homeViewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        homeView = HomeView(frame: UIScreen.main.bounds)
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel = HomeViewModel()
        self.homeViewModel?.loadData()
        
        setupCollectionCells()

        
    }
    
    
    func setupCollectionCells(){
        guard let homeViewModel = self.homeViewModel else { return }
        guard let homeView = self.homeView else { return }
        homeViewModel.charactersList.bind(to: homeView.collectionView.rx.items(cellIdentifier: "cell", cellType: HomeCollectionViewCell.self)) {
            index, model, cell in
            cell.configureWith(imageUrl: homeViewModel.formatUrl(model.thumbnail))
            
        }.disposed(by: disposeBag)
    }
}
