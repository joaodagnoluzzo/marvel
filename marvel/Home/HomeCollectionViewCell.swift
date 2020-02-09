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
    
    private var nameLabel: UILabel!
    private var nameLabelBackground: UIVisualEffectView!
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
    
    func configureWith(name: String?,imageUrl: String){
        guard let name = name else { return }
        guard let url = URL(string: imageUrl) else { return }
        nameLabel.text = name
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
        addNameLabel()
        addNameLabelBackground()
        addSpinningWheel()
    }
    
    func setupSubviewConstraints(){
        setupImageViewConstraints()
        setupNameLabelConstraints()
        setupNameLabelBackgroundConstraints()
        setupSpinningWheelConstraints()
    }
    
    func addImageView(){
        imageView = UIImageView(frame: CGRect.zero)
        imageView.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.addSubview(imageView)
    }
    
    func setupImageViewConstraints(){
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    func addNameLabel(){
        nameLabel = UILabel(frame: CGRect.zero)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 17)
        self.addSubview(nameLabel)
    }
    
    func addNameLabelBackground(){
        let blurEffect = UIBlurEffect(style: .regular)
        nameLabelBackground = UIVisualEffectView(effect: blurEffect)
        self.insertSubview(nameLabelBackground, belowSubview: nameLabel)
    }
    
    func setupNameLabelConstraints(){
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.top)
            make.leading.equalTo(imageView.snp.leading)
            make.trailing.equalTo(imageView.snp.trailing)
        }
    }
    
    func setupNameLabelBackgroundConstraints(){
        nameLabelBackground.snp.makeConstraints { (make) in
            make.edges.equalTo(nameLabel.snp.edges)
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
