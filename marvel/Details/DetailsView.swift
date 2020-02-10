//
//  DetailsView.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit
import SnapKit

final class DetailsView: UIView {
    
    private var imageView: UIImageView!
    private var imageViewSpinningWheel: UIActivityIndicatorView!
    private var participationLabel: UILabel!
    var comicsCollectionView: UICollectionView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView(){
        self.backgroundColor = UIColor(named: "MarvelRed")
        addSubViews()
        setupSubViewsConstraints()
    }
    
    func configureWith(imageUrl: String){
        guard let url = URL(string: imageUrl) else { return }
        imageView.af_setImage(withURL: url, placeholderImage: .none, filter: .none, progress: .none, progressQueue: .main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false) { _ in
            self.imageViewSpinningWheel.stopAnimating()
            self.imageViewSpinningWheel.removeFromSuperview()
        }
    }
    
    func addSubViews(){
        addImageView()
        addImageViewSpinningWheel()
        addParticipationLabel()
        addComicsCollectionView()
    }
    
    func setupSubViewsConstraints(){
        setupImageViewConstraints()
        setupImageViewSpinningWheelConstraints()
        setupParticipationLabelConstraints()
        setupComicsCollectionViewConstraints()
    }
    
    func addImageView(){
        imageView = UIImageView(frame: CGRect.zero)
        imageView.clipsToBounds = true
        self.addSubview(imageView)
    }
    
    func setupImageViewConstraints(){
        imageView.snp.makeConstraints { (make) in
            let margin: CGFloat = 10
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(margin)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(margin)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(margin)
            make.height.equalTo(imageView.snp.width)
        }
    }
    
    func addImageViewSpinningWheel(){
        imageViewSpinningWheel = UIActivityIndicatorView(style: .large)
        imageViewSpinningWheel.hidesWhenStopped = true
        self.addSubview(imageViewSpinningWheel)
        imageViewSpinningWheel.startAnimating()
    }
    
    func setupImageViewSpinningWheelConstraints(){
        imageViewSpinningWheel.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView.snp.centerX)
            make.centerY.equalTo(imageView.snp.centerY)
        }
    }
    
    func addParticipationLabel(){
        participationLabel = UILabel(frame: CGRect.zero)
        participationLabel.text = "Comic books participations"
        participationLabel.font = UIFont(name: "DINCondensed-Bold", size: 23)
        self.addSubview(participationLabel)
    }
    
    func setupParticipationLabelConstraints(){
        participationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.equalTo(imageView.snp.leading)
        }
    }
    
    func addComicsCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.scrollDirection = .horizontal
        let width = 100
        let height = 150
        let size = CGSize(width: width, height: height)
        layout.itemSize = size
        comicsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        comicsCollectionView.backgroundColor = .clear
        self.addSubview(comicsCollectionView)
        comicsCollectionView.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupComicsCollectionViewConstraints(){
        comicsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(participationLabel.snp.bottom)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
            make.height.equalTo(170)
        }
    }
}
