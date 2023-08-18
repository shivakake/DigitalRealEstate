//
//  LikedViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 11/05/23.
//

import UIKit
import ComponentUI

class LikedViewController: UIViewController {
    
    @IBOutlet weak var likedTitleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var noLikedDataAvailableLabel: UILabel!
    @IBOutlet weak var likedListCollectionView : UICollectionView!
    
    weak var searchTime: Timer?
    let likedListArray = [LikedListDataModel(name: "Platinum Villa", profileImage: "people", liked: true, address: "Whitefield, 2.0 km away", sqft: "2145 sqft", rating: "4.5", price: "₹1.25 Cr"),
                          LikedListDataModel(name: "Daimonas Flats", profileImage: "SplashScreen", liked: false, address: "Whitefield, 5.0 km away", sqft: "1600 sqft", rating: "4.0", price: "₹1.25 Lac"),
                          LikedListDataModel(name: "Petals", profileImage: "Flat_00", liked: true, address: "Whitefield, 3.0 km away", sqft: "2150 sqft", rating: "4.2", price: "₹1.30 Lac"),
                          LikedListDataModel(name: "Lotus Garden", profileImage: "Flat_01", liked: false, address: "Whitefield, 6.0 km away", sqft: "3000 sqft", rating: "4.5", price: "₹1.25 Cr"),
                          LikedListDataModel(name: "Platinum Villa", profileImage: "Flat_02", liked: true, address: "Whitefield, 2.0 km away", sqft: "2145 sqft", rating: "4.0", price: "₹1.25 Lac"),
                          LikedListDataModel(name: "Daimonas Flats", profileImage: "Flat_03", liked: false, address: "Whitefield, 5.0 km away", sqft: "1600 sqft", rating: "4.0", price: "₹1.25 Lac"),
                          LikedListDataModel(name: "Petals", profileImage: "Flat_04", liked: true, address: "Whitefield, 3.0 km away", sqft: "2150 sqft", rating: "4.2", price: "₹1.30 Lac"),
                          LikedListDataModel(name: "Lotus Garden", profileImage: "Flat_04", liked: false, address: "Whitefield, 6.0 km away", sqft: "3000 sqft", rating: "4.5", price: "₹1.25 Cr")]
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonMethods()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        likedListCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    public func commonMethods() {
        setupUI()
    }
    
    public func setupUI(){
        likedTitleLabel.showStyle(with: .content, weight: .semibold)
        searchBar.delegate = self
        likedListCollectionView?.register(UINib(nibName: "LikedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LikedCollectionViewCell")
        likedListCollectionView?.delegate = self
        likedListCollectionView?.dataSource = self
        noLikedDataAvailableLabel.isHidden = true
    }
}

extension LikedViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return likedListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = likedListCollectionView.dequeueReusableCell(withReuseIdentifier: "LikedCollectionViewCell", for: indexPath) as? LikedCollectionViewCell {
            cell.configureCell(model: likedListArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension LikedViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = likedListArray[indexPath.row]
        print(model)
        //        if model.datastatus != "queue" {
        //            caseLogic.caseDetailsModel = model
        //            let controller = CaseDetailsTabbarController(caseLogic: caseLogic, caseDelegate: self, communityId: communityId)
        //            controller.modalPresentationStyle = .fullScreen
        //            present(controller, animated: true, completion: nil)
        //        }
    }
}

extension LikedViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: likedListCollectionView.frame.width - 10, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension LikedViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
