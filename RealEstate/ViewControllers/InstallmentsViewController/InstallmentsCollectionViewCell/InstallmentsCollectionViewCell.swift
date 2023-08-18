//
//  InstallmentsCollectionViewCell.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 11/05/23.
//

import UIKit
import ComponentUI

class InstallmentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackGroundView: UIView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var paymentButtonView: UIView!
    @IBOutlet weak var installmentTitleLabel: UILabel!
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var dateDetailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var paymentStatusButton: UIButton!
    @IBOutlet weak var paymentStatusButtonWidth: NSLayoutConstraint!
    @IBOutlet weak var makePaymentButton: UIButton!
    
    let styleLibrary = StyleLibrary()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    fileprivate func setupCell() {
        detailsView.layer.backgroundColor = UIColor.clear.cgColor
        cellBackGroundView.styleWithShadow()
        paymentStatusButton.showStyle(with: .small, weight: .medium, textColor: .white, bgColor: styleLibrary.appColor, needCircularCorners: true)
        makePaymentButton.showStyle(with: .content, weight: .medium, textColor: .white, needCircularCorners: false)
        paymentButtonView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        paymentButtonView.layer.cornerRadius = 10.0
        
        installmentTitleLabel.showStyle(with: .content, weight: .semibold, color: .black)
        dateTitleLabel.showStyle(with: .meta, weight: .regular, color: .lightGray)
        dateDetailsLabel.showStyle(with: .small, weight: .regular, color: .black)
        priceLabel.showStyle(with: .title, weight: .semibold, color: styleLibrary.appColor)
    }
    
    func configureCell(model: InstallmentDataModel?) {
        installmentTitleLabel.text = model?.title
        dateTitleLabel.text = model?.dateTitle
        dateDetailsLabel.text = model?.dateDetails
        priceLabel.text = model?.price
        
        if model?.paymentStatus == true {
            paymentStatusButton.setTitle("Paid", for: UIControl.State.normal)
            paymentStatusButton.layer.backgroundColor = styleLibrary.appColor.cgColor
            paymentButtonView.isHidden = true
            paymentStatusButtonWidth.constant = 60
        } else {
            if model?.outstanding == false{
                paymentStatusButton.setTitle("Pending", for: UIControl.State.normal)
                paymentStatusButton.layer.backgroundColor = #colorLiteral(red: 0.9843569398, green: 0.5488320589, blue: 0, alpha: 1)
                paymentButtonView.isHidden = false
                paymentStatusButtonWidth.constant = 80
            } else {
                paymentStatusButton.setTitle("Outstanding", for: UIControl.State.normal)
                paymentStatusButton.layer.backgroundColor = #colorLiteral(red: 0.07178480178, green: 0.1468527019, blue: 0.242675513, alpha: 1)
                paymentButtonView.isHidden = false
                paymentStatusButtonWidth.constant = 110
            }
        }
    }
    
    @IBAction func paymentButtonTapped(_ sender: UIButton) {
        print("Payment Button Tapped")
    }
}
