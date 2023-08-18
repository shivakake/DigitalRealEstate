//
//  InstallmentsFilterTableViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 12/05/23.
//

import UIKit

class InstallmentsFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var filterTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func setupCell() {
        checkImageView.image = UIImage(systemName: "square")
        filterTitleLabel.showStyle(with: .content, weight: .regular)
    }
    
    func configureCell(model: CategoriesDataModel?) {
        filterTitleLabel.text = model?.title
        if model?.isSelected == true {
            checkImageView.image = UIImage(systemName: "checkmark.square.fill")
        } else {
            checkImageView.image = UIImage(systemName: "square")
        }
    }
}
