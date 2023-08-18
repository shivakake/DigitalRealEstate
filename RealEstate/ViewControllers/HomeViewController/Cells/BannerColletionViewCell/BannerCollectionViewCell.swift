//
//  BannerCollectionViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 16/05/23.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    fileprivate func setupCell() {
        bannerImageView.layer.cornerRadius = 10
    }
    
    func configureCell(imageName: UIImage) {
        bannerImageView.image = imageName
    }
}
