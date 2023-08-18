//
//  VisitsDetailsCollectionViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 13/05/23.
//

import UIKit
import ComponentUI

class VisitsDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var statusLineView: UIView!
    @IBOutlet weak var statusCircelImageView: UIImageView!
    @IBOutlet weak var visitsDetailsView: UIView!
    @IBOutlet weak var visitsNameLabel: UILabel!
    @IBOutlet weak var visitCheckImageView: UIImageView!
    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var visitDateAndTimeLabel: UILabel!
    
    let styleLibrary = StyleLibrary()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    fileprivate func setupCell() {
        visitsDetailsView.styleWithShadow()
        visitsNameLabel.showStyle(with: .content, weight: .medium)
        visitDateAndTimeLabel.showStyle(with: .small, weight: .medium, color: .lightGray)
    }
    
    func configureCell(model: VisitsDetailsDataModel?) {
        visitsNameLabel.text = model?.name
        visitDateAndTimeLabel.text = model?.dateAndTime
        
        if model?.checked == true {
            visitCheckImageView.image = UIImage(named: "alert")
            statusCircelImageView.tintColor = styleLibrary.appColor
            statusLineView.layer.backgroundColor = styleLibrary.appColor.cgColor
        }
    }
}
