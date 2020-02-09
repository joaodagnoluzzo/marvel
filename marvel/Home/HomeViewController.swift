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
        self.homeViewModel?.loadInitialData()
        
        setupCollectionViewDelegateAndDataSource()
        setupCollectionCells()

        
    }
    
    func setupCollectionViewDelegateAndDataSource(){
        guard let homeView = self.homeView else { return }
        homeView.collectionView.prefetchDataSource = self
    }
    
    func setupCollectionCells(){
        guard let homeViewModel = self.homeViewModel else { return }
        guard let homeView = self.homeView else { return }
        homeViewModel.charactersList.bind(to: homeView.collectionView.rx.items(cellIdentifier: "cell", cellType: HomeCollectionViewCell.self)) {
            index, model, cell in
            cell.configureWith(name: model.name, imageUrl: homeViewModel.formatUrl(model.thumbnail))
            
        }.disposed(by: disposeBag)
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= homeViewModel!.currentOffset
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel!.total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension HomeViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            homeViewModel?.loadNewData()
        }
    }
    

}
