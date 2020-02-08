//
//  HomeView.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit
import SnapKit

class HomeView: UIView {

    var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        backgroundColor = .systemRed
        addSubviews()
        setupSubviewConstraints()
    }
    
    func addSubviews(){
        addCollectionView()
    }
    
    func setupSubviewConstraints(){
        setupCollectionViewConstraints()
    }
    
    func addCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let width = (UIScreen.main.bounds.width-30)/2
        let height = width * 1.6
        let size = CGSize(width: width, height: height)
        layout.itemSize = size
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemPink
        self.addSubview(collectionView)
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupCollectionViewConstraints(){
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
}
