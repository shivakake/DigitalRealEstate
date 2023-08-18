//
//  LikedCollectionViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 11/05/23.
//

import UIKit
import ComponentUI

class LikedCollectionViewCell: UICollectionViewCell {
    
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
    var comingFrom = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    fileprivate func setupCell() {
        cellBackGroundView.styleWithShadow()
        profileImageView.layer.cornerRadius = 10
        likeImageView.tintColor = styleLibrary.likeFillColor
        nameLabel.showStyle(with: .content, weight: .medium)
        addressLabel.showStyle(with: .small, color: .lightGray)
        sqftLabel.showStyle(with: .small, color: .lightGray)
        priceLabel.showStyle(with: .small, weight: .medium, color: styleLibrary.appColor)
    }
    
    func configureCell(model: LikedListDataModel?) {
        profileImageView.image = UIImage(named: model?.profileImage ?? "")
        nameLabel.text = model?.name
        addressLabel.text = model?.address
        sqftLabel.text = model?.sqft
        priceLabel.text = model?.price
        
        if model?.liked == true {
            likeImageView.image = UIImage(systemName: "heart.fill")
        } else {
            likeImageView.image = UIImage(systemName: "heart")
        }
        
        if comingFrom == "Home"{
            likeImageView.isHidden = true
            priceLabel.isHidden = true
            starImageView.isHidden = true
            ratingLabel.text = model?.price
            ratingLabel.showStyle(with: .small, weight: .semibold, color: styleLibrary.appColor)
        } else {
            ratingLabel.text = model?.rating
            ratingLabel.showStyle(with: .content)
        }
    }
}
