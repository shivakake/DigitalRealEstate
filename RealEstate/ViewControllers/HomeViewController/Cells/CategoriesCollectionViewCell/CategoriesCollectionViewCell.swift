//
//  CategoriesCollectionViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 16/05/23.
//

import UIKit
import ComponentUI

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackGroundView: UIView!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    let styleLibrary = StyleLibrary()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    fileprivate func setupCell() {
        cellBackGroundView.layer.backgroundColor = UIColor.white.cgColor
        cellBackGroundView.layer.cornerRadius = 20
        categoriesLabel.showStyle(with: .content, weight: .medium)
    }
    
    func configureCell(model: CategoriesDataModel?) {
        categoriesLabel.text = model?.title
        cellBackGroundView.layer.borderWidth = 1.5
        cellBackGroundView.layer.borderColor = styleLibrary.appColor.cgColor
        if model?.isSelected == true {
            cellBackGroundView.layer.backgroundColor = styleLibrary.appColor.cgColor
            categoriesLabel.textColor = UIColor.white
        } else {
            cellBackGroundView.layer.backgroundColor = UIColor.white.cgColor
            categoriesLabel.textColor = styleLibrary.appColor
        }
    }
}


