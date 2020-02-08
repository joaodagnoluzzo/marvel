//
//  HomeCollectionViewCell.swift
//  marvel
//
//  Created by João Pedro Cappelletto D'Agnoluzzo on 08/02/20.
//  Copyright © 2020 João Pedro Cappelletto D'Agnoluzzo. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

final class HomeCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    
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
        imageView.af_setImage(withURL: url, placeholderImage: .none, filter: .none, progress: .none, progressQueue: .main, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true) { _ in
        }
    }
    
    func setupCell(){
        backgroundColor = .systemIndigo
        addSubviews()
        setupSubviewConstraints()
    }
    
    func addSubviews(){
        addImageView()
    }
    
    func setupSubviewConstraints(){
        setupImageViewConstraints()
    }
    
    func addImageView(){
        imageView = UIImageView(frame: CGRect.zero)
        imageView.backgroundColor = .systemGreen
        self.addSubview(imageView)
    }
    
    func setupImageViewConstraints(){
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
}
