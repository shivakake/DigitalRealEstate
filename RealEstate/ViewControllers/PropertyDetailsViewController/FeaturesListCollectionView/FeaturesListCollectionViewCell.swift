//
//  FeaturesListCollectionViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 17/05/23.
//

import UIKit

class FeaturesListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackGroundView: UIView!
    @IBOutlet weak var featureImageView: UIImageView!
    @IBOutlet weak var featureTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    fileprivate func setupCell() {
        featureImageView.layer.cornerRadius = 5
        featureImageView.contentMode = .scaleAspectFill
        featureTitleLabel.showStyle(with: .content, color: .lightGray)
    }
    
    func configureCell(model: FeaturesDataModel) {
        featureImageView.image = UIImage(named: model.featureImage ?? "")
        featureTitleLabel.text = model.featureTitle ?? ""
    }
}
