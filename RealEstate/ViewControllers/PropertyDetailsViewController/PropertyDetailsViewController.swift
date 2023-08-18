//
//  PropertyDetailsViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 17/05/23.
//

import UIKit
import MapKit
import ComponentUI

class PropertyDetailsViewController: UIViewController {
    
    @IBOutlet weak var propertyImageView: UIImageView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var bookVisitButton: UIButton!
    @IBOutlet weak var propertyDescriptionLabel: UILabel!
    @IBOutlet weak var featuresTitleLabel: UILabel!
    @IBOutlet weak var seeAllFeaturesButton: UIButton!
    @IBOutlet weak var featuresCollectionView: UICollectionView!
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerAddressLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var featuresCollectionViewHeightConstraint: NSLayoutConstraint!
    
    let bannerListArray = [UIImage(named: "Flat_00"),
                           UIImage(named: "Flat_01"),
                           UIImage(named: "Flat_02"),
                           UIImage(named: "Flat_03"),
                           UIImage(named: "Flat_04"),
                           UIImage(named: "Flat_05"),
                           UIImage(named: "SplashScreen"),
                           UIImage(named: "Flat_00"),
                           UIImage(named: "Flat_01")]
    
    let featuresListArray = [FeaturesDataModel(title: "2145 sqft", image: "SplashScreen"),
                             FeaturesDataModel(title: "2 Car parking", image: "Flat_00"),
                             FeaturesDataModel(title: "Community Hall", image: "Flat_01"),
                             FeaturesDataModel(title: "3 Bedrooms", image: "Flat_02"),
                             FeaturesDataModel(title: "2 Pools", image: "Flat_03")
    ]
    let propertyDescription = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    let styleLibrary = StyleLibrary()
    var isBool = Bool()
    
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
        bannerCollectionView.collectionViewLayout.invalidateLayout()
        featuresCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func commonMethods() {
        setupView()
        registerColletionViewCellAndDelegate()
        propertyDescriptionConfigure()
    }
    
    func setupView() {
        likeImageView.setImageTintColor(styleLibrary.appColor)
        bookVisitButton.showStyle(with: .small, weight: .regular, textColor: .white, bgColor: styleLibrary.appColor, needCircularCorners: true)
        
        propertyNameLabel.showStyle(with: .content, weight: .medium)
        addressLabel.showStyle(with: .content, color: .lightGray)
        ratingLabel.showStyle(with: .content)
        priceLabel.showStyle(with: .content, weight: .medium)
        propertyDescriptionLabel.showStyle(with: .small, weight: .semibold, color: .lightGray)
        
        featuresTitleLabel.showStyle(with: .content, weight: .medium)
        seeAllFeaturesButton.showStyle(with: .content, weight: .medium, textColor: styleLibrary.appColor, bgColor: nil, needCircularCorners: false)
        locationTitleLabel.showStyle(with: .content, weight: .medium)
        getDirectionsButton.showStyle(with: .content, weight: .medium, textColor: styleLibrary.appColor, bgColor: nil, needCircularCorners: false)
        ownerNameLabel.showStyle(with: .content, weight: .regular, color: .lightGray)
        ownerAddressLabel.showStyle(with: .small, weight: .bold, color: styleLibrary.appColor)
        ownerImageView.makeImageCircle(ownerImageView, 1.0, .lightGray, CGFloat(ownerImageView.frame.size.height / 2))
        featuresCollectionViewHeightConstraint.constant = CGFloat(((((featuresListArray.count) * 40) / 2) + 25))
        mapView.layer.cornerRadius = 10
    }
    
    fileprivate func registerColletionViewCellAndDelegate() {
        bannerCollectionView?.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        bannerCollectionView?.delegate = self
        bannerCollectionView?.dataSource = self
        
        featuresCollectionView?.register(UINib(nibName: "FeaturesListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FeaturesListCollectionViewCell")
        featuresCollectionView?.delegate = self
        featuresCollectionView?.dataSource = self
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func propertyDescriptionConfigure() {
        propertyDescriptionLabel.text = propertyDescription
        propertyDescriptionLabel.appendReadmore(after: propertyDescriptionLabel?.text ?? "", trailingContent: .readmore)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        propertyDescriptionLabel.isUserInteractionEnabled = true
        propertyDescriptionLabel.addGestureRecognizer(tap)
    }
    
    @objc  func tapFunction(sender:UITapGestureRecognizer) {
        if isBool == true {
            propertyDescriptionLabel.appendReadmore(after: propertyDescription, trailingContent: .readmore)
        } else {
            propertyDescriptionLabel.appendReadLess(after: propertyDescription, trailingContent: .readless)
        }
        isBool = !isBool
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let text = "This is the text...."
        let image = UIImage(named: "like")
        let myWebsite = NSURL(string:"https://stackoverflow.com/users/4600136/mr-javed-multani?tab=profile")
        let shareAll = [text , image! , myWebsite ?? NSURL()] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            likeImageView.image = UIImage(systemName: "heart.fill")
            sender.tag = 1
        } else {
            likeImageView.image = UIImage(systemName: "heart")
            sender.tag = 0
        }
    }
    
    @IBAction func bookVisitButtonTapped(_ sender: UIButton) { }
    
    @IBAction func seeAllFeaturesButtonTapped(_ sender: UIButton) {
        let controller = FeaturesListViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        let controller = DirectionMapViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func dailCallButtonTapped(_ sender: UIButton) {
        callNumber(phoneNumber: "9052998993")
    }
    
    @IBAction func whatsupCallButtonTapped(_ sender: UIButton) { }
}

extension PropertyDetailsViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? bannerListArray.count : featuresListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bannerCollectionView {
            if let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell {
                cell.configureCell(imageName: bannerListArray[indexPath.row] ?? UIImage())
                return cell
            }
        } else {
            if let cell = featuresCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturesListCollectionViewCell", for: indexPath) as? FeaturesListCollectionViewCell {
                cell.configureCell(model: featuresListArray[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension PropertyDetailsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        guard let indexPath = indexPath.first?.item else { return }
        //        if indexPath != -1 {
        //            onItemClick?(indexPath)
        //        }
        //        collectionView.deselectItems(at: indexPaths)
    }
}

extension PropertyDetailsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == bannerCollectionView ? CGSize(width: 55, height: 55) : CGSize(width: ((featuresCollectionView.frame.width) / 2) - 10, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension PropertyDetailsViewController {
    //MARK:- Dial Function
    func dialNumber(number : String) {
        if let url = URL(string: "tel://\(number)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
        } else {
            showAlert("Invalid Number")
        }
    }
}

/*
 if likeImageView.image == UIImage(systemName: "heart") {
 likeImageView.image = UIImage(systemName: "heart.fill")
 } else {
 likeImageView.image = UIImage(systemName: "heart")
 }
 */
