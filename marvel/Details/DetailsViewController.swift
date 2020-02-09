//
//  DetailsViewController.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {

    var character: CharacterEntry?
    private var detailsViewModel: DetailsViewModel?
    private var detailsView: DetailsView?
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        detailsView = DetailsView(frame: UIScreen.main.bounds)
        view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        guard let detailsViewModel = detailsViewModel else { return }
        let character = detailsViewModel.getCharacter()
        self.title = character.name
        detailsView?.configureWith(imageUrl: detailsViewModel.formatCharacterImageUrl(character.thumbnail))
        setupCollectionCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setupViewModel(){
        guard let character = self.character else { return }
        detailsViewModel = DetailsViewModel(character: character)
        self.character = nil
        self.detailsViewModel?.loadInitialData()
    }
    
    func setupCollectionCells(){
        guard let detailsViewModel = self.detailsViewModel else { return }
        guard let detailsView = self.detailsView else { return }
        detailsViewModel.comicsList.bind(to: detailsView.comicsCollectionView.rx.items(cellIdentifier: "cell", cellType: ComicsCollectionViewCell.self)) {
            index, model, cell in
            cell.configureWith(imageUrl: detailsViewModel.formatComicUrl(model.thumbnail))
        }.disposed(by: disposeBag)
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        let expression = (( indexPath.row >= detailsViewModel!.currentOffset)
                            && (detailsViewModel!.currentOffset < detailsViewModel!.total))
        return expression
    }
}

extension DetailsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            detailsViewModel?.loadNewData()
        }
    }
}
