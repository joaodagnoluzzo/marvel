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

protocol HomeViewControllerDelegate: class {
    func homeViewControllerShouldPresentDetailsOf(_ character: CharacterEntry)
}

class HomeViewController: UIViewController {

    private var homeView: HomeView?
    private var homeViewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    weak var delegate: HomeViewControllerDelegate?
    
    override func loadView() {
        homeView = HomeView(frame: UIScreen.main.bounds)
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MARVEL Characters"
        self.homeViewModel = HomeViewModel()
        self.homeViewModel?.loadInitialData(completion: { (error) in
            if let error = error {
                let msg = UIAlertController().errorMsg(error.errorDescription!, handler: nil)
                self.present(msg, animated: true, completion: nil)
            }
        })
        setupCollectionViewPrefetchDataSource()
        setupCollectionCells()
        setupCollectionCellTapHandling()
    }
    
    func setupCollectionViewPrefetchDataSource(){
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
    
    func setupCollectionCellTapHandling(){
        guard let homeView = self.homeView else { return }
        homeView
        .collectionView
        .rx
        .modelSelected(CharacterEntry.self)
            .bind { (character) in
                self.delegate?.homeViewControllerShouldPresentDetailsOf(character)
        }.disposed(by: disposeBag)
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        let expression = (( indexPath.row >= homeViewModel!.currentOffset)
                            && (homeViewModel!.currentOffset < homeViewModel!.total))
        return expression
    }
}

extension HomeViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            homeViewModel?.loadNewData(completion: { (error) in
                if let error = error {
                    let msg = UIAlertController().errorMsg(error.errorDescription!, handler: nil)
                    self.present(msg, animated: true, completion: nil)
                }
            })
        }
    }
}
