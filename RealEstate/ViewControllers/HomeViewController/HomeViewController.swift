//
//  HomeViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 11/05/23.
//

import UIKit
import ComponentUI

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileAddressLabel: UILabel!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var nearPropertiesCollectionView: UICollectionView!
    @IBOutlet weak var nearPropertiesCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    @IBOutlet weak var mostPopularTitleLabel: UILabel!
    @IBOutlet weak var mostPopularSeeAllButton: UIButton!
    @IBOutlet weak var nearbyPropertyFilterButton: UIButton!
    @IBOutlet weak var nearbyPropertyTitleLabel: UILabel!
    
    let styleLibrary = StyleLibrary()
    let bannerListArray = [UIImage(named: "SplashScreen"),
                           UIImage(named: "Flat_00"),
                           UIImage(named: "Flat_01"),
                           UIImage(named: "Flat_02"),
                           UIImage(named: "Flat_03"),
                           UIImage(named: "Flat_04"),
                           UIImage(named: "Flat_05"),
                           UIImage(named: "SplashScreen"),
                           UIImage(named: "Flat_00")]
    
    var categoriesListArray = [CategoriesDataModel(title: "All", isSelected: true),
                               CategoriesDataModel(title: "Villa", isSelected: false),
                               CategoriesDataModel(title: "Flats", isSelected: false),
                               CategoriesDataModel(title: "Plots", isSelected: false)]
    
    let mostPopularListArray = [
        LikedListDataModel(name: "Platinum Villa", profileImage: "Flat_00", liked: true, address: "Whitefield, 2.0 km away", sqft: "2145 sqft", rating: "4.5", price: "₹1.25 Cr"),
        LikedListDataModel(name: "Daimonas Flats", profileImage: "Flat_01", liked: false, address: "Whitefield, 5.0 km away", sqft: "1600 sqft", rating: "4.0", price: "₹1.25 Lac"),
        LikedListDataModel(name: "Petals", profileImage: "Flat_02", liked: true, address: "Whitefield, 3.0 km away", sqft: "2150 sqft", rating: "4.2", price: "₹1.30 Lac"),
        LikedListDataModel(name: "Lotus Garden", profileImage: "Flat_03", liked: false, address: "Whitefield, 6.0 km away", sqft: "3000 sqft", rating: "4.5", price: "₹1.25 Cr"),
        LikedListDataModel(name: "Platinum Villa", profileImage: "Flat_04", liked: true, address: "Whitefield, 2.0 km away", sqft: "2145 sqft", rating: "4.0", price: "₹1.25 Lac"),
        LikedListDataModel(name: "Daimonas Flats", profileImage: "Flat_05", liked: false, address: "Whitefield, 5.0 km away", sqft: "1600 sqft", rating: "4.0", price: "₹1.25 Lac"),
        LikedListDataModel(name: "Petals", profileImage: "SplashScreen", liked: true, address: "Whitefield, 3.0 km away", sqft: "2150 sqft", rating: "4.2", price: "₹1.30 Lac"),
        LikedListDataModel(name: "Lotus Garden", profileImage: "Flat_00", liked: false, address: "Whitefield, 6.0 km away", sqft: "3000 sqft", rating: "4.5", price: "₹1.25 Cr")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nearPropertiesCollectionViewHeightConstraint.constant = CGFloat(CGFloat(((mostPopularListArray.count) * 230)) + 40)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bannerCollectionView.collectionViewLayout.invalidateLayout()
        categoriesCollectionView.collectionViewLayout.invalidateLayout()
        nearPropertiesCollectionView.collectionViewLayout.invalidateLayout()
        popularCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func commonMethods() {
        setupUI()
        registerColletionViewCellAndDelegate()
        autoScrollBannerColletionView()
    }
    
    func setupUI() {
        profileImageView.makeImageCircle(profileImageView, 1.0, .lightGray, Device.isPhone ? 25 : 30)
        profileNameLabel.showStyle(with: .content, weight: .medium, color: .lightGray)
        profileAddressLabel.showStyle(with: .content, weight: .semibold, color: styleLibrary.appColor)
        mostPopularTitleLabel.showStyle(with: .content, weight: .medium)
        mostPopularSeeAllButton.showStyle(with: .content, weight: .medium, textColor: styleLibrary.appColor, bgColor: nil, needCircularCorners: false)
        nearbyPropertyTitleLabel.showStyle(with: .content, weight: .medium)
        nearbyPropertyFilterButton.showStyle(with: .content, weight: .medium, textColor: styleLibrary.appColor, bgColor: nil, needCircularCorners: false)
    }
    
    func registerColletionViewCellAndDelegate(){
        
        bannerCollectionView?.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        bannerCollectionView?.delegate = self
        bannerCollectionView?.dataSource = self
        
        categoriesCollectionView?.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        categoriesCollectionView?.delegate = self
        categoriesCollectionView?.dataSource = self
        
        popularCollectionView?.register(UINib(nibName: "MostPopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MostPopularCollectionViewCell")
        popularCollectionView?.delegate = self
        popularCollectionView?.dataSource = self
        
        nearPropertiesCollectionView?.register(UINib(nibName: "NearbyPropertiesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NearbyPropertiesCollectionViewCell")
        nearPropertiesCollectionView?.delegate = self
        nearPropertiesCollectionView?.dataSource = self
    }
    
    fileprivate func autoScrollBannerColletionView() {
        bannerPageControl.numberOfPages = bannerListArray.count
        Timer.scheduledTimer(timeInterval: 3.0, target: self , selector:
                                #selector(startScrolling), userInfo: nil, repeats: true)
    }
    
    @objc func startScrolling() {
        if bannerPageControl.currentPage == bannerPageControl.numberOfPages - 1 {
            bannerPageControl.currentPage = 0
        } else {
            bannerPageControl.currentPage += 1
        }
        bannerCollectionView.scrollToItem(at: IndexPath(row: bannerPageControl.currentPage, section: 0), at: .right, animated: true)
    }
    
    fileprivate func selectedTab(category: String?) {
        for (index, item) in categoriesListArray.enumerated() {
            categoriesListArray[index].isSelected = item.title == category
        }
        categoriesCollectionView.reloadCollectionView()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let controller = HomeListSearchViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) { }
}

extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoriesCollectionView {
            return categoriesListArray.count
        } else if collectionView == popularCollectionView {
            return mostPopularListArray.count
        } else if collectionView == nearPropertiesCollectionView {
            return mostPopularListArray.count
        }else{
            return bannerListArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoriesCollectionView {
            if let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as? CategoriesCollectionViewCell {
                cell.configureCell(model: categoriesListArray[indexPath.row])
                return cell
            }
        } else if collectionView == popularCollectionView{
            if let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: "MostPopularCollectionViewCell", for: indexPath) as? MostPopularCollectionViewCell {
                cell.configureCell(model: mostPopularListArray[indexPath.row])
                return cell
            }
        } else if collectionView == nearPropertiesCollectionView{
            if let cell = nearPropertiesCollectionView.dequeueReusableCell(withReuseIdentifier: "NearbyPropertiesCollectionViewCell", for: indexPath) as? NearbyPropertiesCollectionViewCell {
                cell.configureCell(model: mostPopularListArray[indexPath.row])
                return cell
            }
        } else {
            if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell {
                cell.configureCell(imageName: bannerListArray[indexPath.row] ?? UIImage())
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let indexpath = indexPath.first else { return }
        if indexpath != -1 {
            if collectionView == categoriesCollectionView {
                let category = categoriesListArray[indexPath.row].title
                selectedTab(category: category)
            } else if collectionView == popularCollectionView{
                let controller = PropertyDetailsViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            } else if collectionView == nearPropertiesCollectionView {
                let controller = PropertyDetailsViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            } else {
                print(indexPath)
            }
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoriesCollectionView {
            return CGSize(width: 100, height: 50)
        } else if collectionView == popularCollectionView {
            if Device.isPhone {
                if Device.orientation == .portrait {
                    return CGSize(width: ((collectionView.frame.width) - 10) / 1.25, height: 300)
                } else {
                    return CGSize(width: ((collectionView.frame.width) - 10) / 2, height: 300)
                }
            } else {
                if Device.orientation == .portrait {
                    return CGSize(width: ((collectionView.frame.width) - 10) / 2.5, height: 300)
                } else {
                    return CGSize(width: ((collectionView.frame.width) - 10) / 3.5, height: 300)
                }
            }
        } else if collectionView == nearPropertiesCollectionView {
            return CGSize(width: ((collectionView.frame.width) - 10), height: 230)
        } else {
            return CGSize(width: (collectionView.frame.width), height: 160)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
