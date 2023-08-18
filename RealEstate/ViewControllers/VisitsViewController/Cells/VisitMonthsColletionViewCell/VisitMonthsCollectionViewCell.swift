//
//  VisitMonthsCollectionViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 13/05/23.
//

import UIKit
import ComponentUI

class VisitMonthsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackGroundView: UIView!
    @IBOutlet weak var monthNameLabel: UILabel!
    
    let styleLibrary = StyleLibrary()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    fileprivate func setupCell() {
        cellBackGroundView.layer.cornerRadius = 10
        monthNameLabel.showStyle(with: .content, weight: .semibold, color: .white)
    }
    
    func configureCell(model: CategoriesDataModel?) {
        monthNameLabel.text = model?.title
        if model?.isSelected == true {
            cellBackGroundView.layer.backgroundColor = UIColor.white.cgColor
            monthNameLabel.textColor = styleLibrary.appColor
        } else {
            cellBackGroundView.layer.backgroundColor = UIColor.clear.cgColor
            monthNameLabel.textColor = .white
        }
    }
}
