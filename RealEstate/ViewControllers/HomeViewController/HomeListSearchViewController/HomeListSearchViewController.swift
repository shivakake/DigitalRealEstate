//
//  HomeListSearchViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 18/05/23.
//

import UIKit
import ComponentUI

class HomeListSearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var propertyListCollectionView: UICollectionView!
    
    let likedListArray = [LikedListDataModel(name: "Platinum Villa", profileImage: "people", liked: true, address: "Whitefield, 2.0 km away", sqft: "2145 sqft", rating: "4.5", price: "₹1.25 Cr"),
                          LikedListDataModel(name: "Daimonas Flats", profileImage: "Flat_00", liked: false, address: "Whitefield, 5.0 km away", sqft: "1600 sqft", rating: "4.0", price: "₹1.25 Lac"),
                          LikedListDataModel(name: "Petals", profileImage: "Flat_01", liked: true, address: "Whitefield, 3.0 km away", sqft: "2150 sqft", rating: "4.2", price: "₹1.30 Lac"),
                          LikedListDataModel(name: "Lotus Garden", profileImage: "Flat_02", liked: false, address: "Whitefield, 6.0 km away", sqft: "3000 sqft", rating: "4.5", price: "₹1.25 Cr"),
                          LikedListDataModel(name: "Platinum Villa", profileImage: "Flat_03", liked: true, address: "Whitefield, 2.0 km away", sqft: "2145 sqft", rating: "4.0", price: "₹1.25 Lac"),
                          LikedListDataModel(name: "Daimonas Flats", profileImage: "Flat_04", liked: false, address: "Whitefield, 5.0 km away", sqft: "1600 sqft", rating: "4.0", price: "₹1.25 Lac"),
                          LikedListDataModel(name: "Petals", profileImage: "Flat_05", liked: true, address: "Whitefield, 3.0 km away", sqft: "2150 sqft", rating: "4.2", price: "₹1.30 Lac"),
                          LikedListDataModel(name: "Lotus Garden", profileImage: "SplashScreen", liked: false, address: "Whitefield, 6.0 km away", sqft: "3000 sqft", rating: "4.5", price: "₹1.25 Cr")]
    var filteredList = [LikedListDataModel]()
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        propertyListCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func commonMethods() {
        filteredList = likedListArray
        registerColletionViewCellAndDelegate()
        setupSearchBar()
    }
    
    fileprivate func registerColletionViewCellAndDelegate(){
        propertyListCollectionView?.register(UINib(nibName: "LikedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LikedCollectionViewCell")
        propertyListCollectionView?.delegate = self
        propertyListCollectionView?.dataSource = self
    }
    
    func setupSearchBar(){
        searchBar.delegate = self
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension HomeListSearchViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = propertyListCollectionView.dequeueReusableCell(withReuseIdentifier: "LikedCollectionViewCell", for: indexPath) as? LikedCollectionViewCell {
            cell.comingFrom = "Home"
            cell.configureCell(model: filteredList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeListSearchViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = PropertyDetailsViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeListSearchViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: propertyListCollectionView.frame.width - 10, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension HomeListSearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredList = searchText.count <= 0 ? likedListArray : likedListArray.filter { filetrName in
            (filetrName.name?.localizedCaseInsensitiveContains(searchText) ?? false) }
        propertyListCollectionView.reloadCollectionView()
    }
}

/*
 if searchText.count <= 0{
 filteredList = likedListArray
 } else {
 filteredList = likedListArray.filter { filetrName in
 (filetrName.name?.localizedCaseInsensitiveContains(searchText) ?? false)
 }
 }
 */
