//
//  FeaturesListViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 18/05/23.
//

import UIKit
import ComponentUI

class FeaturesListViewController: UIViewController {
    
    @IBOutlet weak var featuresTitleLabel: UILabel!
    @IBOutlet weak var featuresCollectionView: UICollectionView!
    
    let featuresListArray = [FeaturesDataModel(title: "2145 sqft", image: ""),
                             FeaturesDataModel(title: "2 Car parking", image: ""),
                             FeaturesDataModel(title: "Community Hall", image: ""),
                             FeaturesDataModel(title: "3 Bedrooms", image: ""),
                             FeaturesDataModel(title: "2 Pools", image: ""),
                             FeaturesDataModel(title: "2 Rooms Booking", image: "")]
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonMethods()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        featuresCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func commonMethods() {
        featuresTitleLabel.showStyle(with: .content, weight: .semibold)
        registerColletionViewCellAndDelegate()
    }
    
    fileprivate func registerColletionViewCellAndDelegate() {
        featuresCollectionView?.register(UINib(nibName: "FeaturesListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturesListCollectionViewCell")
        featuresCollectionView?.delegate = self
        featuresCollectionView?.dataSource = self
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FeaturesListViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuresListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = featuresCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesListCollectionViewCell", for: indexPath) as? FeaturesListCollectionViewCell {
            cell.configureCell(model: featuresListArray[indexPath.row])
            cell.backgroundView?.backgroundColor = .clear
            cell.cellBackGroundView.layer.cornerRadius = 10
            cell.cellBackGroundView.layer.borderWidth = 1
            cell.cellBackGroundView.layer.borderColor = UIColor.lightGray.cgColor
            cell.featureTitleLabel.showStyle(with: .content, weight: .semibold)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension FeaturesListViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension FeaturesListViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: featuresCollectionView.frame.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
