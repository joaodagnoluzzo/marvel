//
//  ComicsCollectionViewCell.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 09/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    private var spinningWheel: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    func configureWith(imageUrl: String){
        guard let url = URL(string: imageUrl) else { return }
        spinningWheel.startAnimating()
        imageView.af_setImage(withURL: url, placeholderImage: .none, filter: .none, progress: .none, progressQueue: .main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false) { _ in
            self.spinningWheel.stopAnimating()
            self.spinningWheel.removeFromSuperview()
        }
    }
    
    func setupCell(){
        addSubviews()
        setupSubviewConstraints()
    }
    
    func addSubviews(){
        addImageView()
        addSpinningWheel()
    }
    
    func setupSubviewConstraints(){
        setupImageViewConstraints()
        setupSpinningWheelConstraints()
    }
    
    func addImageView(){
        imageView = UIImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.addSubview(imageView)
    }
    
    func setupImageViewConstraints(){
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func addSpinningWheel(){
        spinningWheel = UIActivityIndicatorView(style: .medium)
        spinningWheel.hidesWhenStopped = true
        self.addSubview(spinningWheel)
    }
    
    func setupSpinningWheelConstraints(){
        spinningWheel.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView.snp.centerX)
            make.centerY.equalTo(imageView.snp.centerY)
        }
    }
}
