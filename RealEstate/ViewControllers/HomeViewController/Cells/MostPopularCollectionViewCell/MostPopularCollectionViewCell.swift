//
//  MostPopularCollectionViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 16/05/23.
//

import UIKit
import ComponentUI

class MostPopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackGroundView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var sqftLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    let styleLibrary = StyleLibrary()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    fileprivate func setupCell() {
        cellBackGroundView.styleWithShadow()
        profileImageView.layer.cornerRadius = 10
        profileImageView.contentMode = .scaleToFill
        likeImageView.tintColor = .white
        starImageView.tintColor = .orange
        nameLabel.showStyle(with: .content, weight: .medium)
        addressLabel.showStyle(with: .content, color: .lightGray)
        sqftLabel.showStyle(with: .content, color: .lightGray)
        ratingLabel.showStyle(with: .content)
        priceLabel.showStyle(with: .content, weight: .medium)
    }
    
    func configureCell(model: LikedListDataModel?) {
        profileImageView.image = UIImage(named: model?.profileImage ?? "")
        if model?.liked == true {
            likeImageView.image = UIImage(systemName: "heart")
        } else {
            likeImageView.image = UIImage(systemName: "heart.fill")
        }
        nameLabel.text = model?.name
        addressLabel.text = model?.address
        sqftLabel.text = model?.sqft
        ratingLabel.text = model?.rating
        priceLabel.text = model?.price
    }
}
