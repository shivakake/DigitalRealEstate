//
//  VisitsViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 11/05/23.
//

import UIKit
import ComponentUI

class VisitsViewController: UIViewController {
    
    @IBOutlet weak var visitsTitleLabel: UILabel!
    @IBOutlet weak var monthsListCollectionView: UICollectionView!
    @IBOutlet weak var visitsDetailsListColletionView: UICollectionView!
    @IBOutlet weak var addVisitsButtonView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var addVisitsButton: UIButton!
    
    var monthsListArray = [CategoriesDataModel(title: "JAN", isSelected: false),
                           CategoriesDataModel(title: "FEB", isSelected: false),
                           CategoriesDataModel(title: "MAR", isSelected: true),
                           CategoriesDataModel(title: "APRIL", isSelected: false),
                           CategoriesDataModel(title: "MAY", isSelected: false),
                           CategoriesDataModel(title: "JUN", isSelected: false),
                           CategoriesDataModel(title: "JUL", isSelected: false),
                           CategoriesDataModel(title: "AUG", isSelected: false),
                           CategoriesDataModel(title: "SEP", isSelected: false),
                           CategoriesDataModel(title: "OCT", isSelected: false),
                           CategoriesDataModel(title: "NOV", isSelected: false),
                           CategoriesDataModel(title: "DEC", isSelected: false)]
    
    let visitDetailsArray = [
        VisitsDetailsDataModel(visitName: "Precious homes", visitDateAndTime: "23rd Aug, Mon 10:30 am", checked: true),
        VisitsDetailsDataModel(visitName: "Horvath homes", visitDateAndTime: "16th Aug, Wed 40:30 pm", checked: false),
        VisitsDetailsDataModel(visitName: "Western Building", visitDateAndTime: "10th Aug, Tus 04:30 pm", checked: false),
        VisitsDetailsDataModel(visitName: "Northen Homes", visitDateAndTime: "01st Aug, Wed 04:30 pm", checked: false),
        VisitsDetailsDataModel(visitName: "Southern Homes", visitDateAndTime: "30th July, Wed 03:30 pm", checked: false),
        VisitsDetailsDataModel(visitName: "Precious homes", visitDateAndTime: "23rd Aug, Mon 10:30 am", checked: false),
        VisitsDetailsDataModel(visitName: "Horvath homes", visitDateAndTime: "16th Aug, Wed 40:30 pm", checked: false),
        VisitsDetailsDataModel(visitName: "Western Building", visitDateAndTime: "10th Aug, Tus 04:30 pm", checked: false),
        VisitsDetailsDataModel(visitName: "Northen Homes", visitDateAndTime: "01st Aug, Wed 04:30 pm", checked: false),
        VisitsDetailsDataModel(visitName: "Southern Homes", visitDateAndTime: "30th July, Wed 03:30 pm", checked: false)
    ]
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        monthsListCollectionView.collectionViewLayout.invalidateLayout()
        visitsDetailsListColletionView.collectionViewLayout.invalidateLayout()
    }
    
    fileprivate func commonMethods() {
        setupUI()
        registerColletionViewCellAndDelegate()
    }
    
    func setupUI() {
        view.backgroundColor = styleLibrary.appColor
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.layer.cornerRadius = 20.0
        addVisitsButtonView.layer.backgroundColor = styleLibrary.appColor.cgColor
        addVisitsButton.tintColor = .white
        addVisitsButtonView.layer.cornerRadius = addVisitsButtonView.frame.size.height / 2
        visitsTitleLabel.showStyle(with: .content, weight: .semibold, color: .white)
    }
    
    public func registerColletionViewCellAndDelegate(){
        monthsListCollectionView.register(UINib(nibName: "VisitMonthsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VisitMonthsCollectionViewCell")
        monthsListCollectionView.delegate = self
        monthsListCollectionView.dataSource = self
        
        visitsDetailsListColletionView.register(UINib(nibName: "VisitsDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VisitsDetailsCollectionViewCell")
        visitsDetailsListColletionView.delegate = self
        visitsDetailsListColletionView.dataSource = self
    }
    
    fileprivate func selectedTab(month: String?) {
        for (index, item) in monthsListArray.enumerated() {
            monthsListArray[index].isSelected = item.title == month
        }
        self.monthsListCollectionView.reloadData()
    }
    
    @IBAction func calenderButtonTapped(_ sender: UIButton) {
        //        let controller = InstallmentsFilterViewController()
        //        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func addVisitsButtonTapped(_ sender: UIButton) {
        let controller = BookVisitViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension VisitsViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == monthsListCollectionView ? monthsListArray.count : visitDetailsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == monthsListCollectionView {
            if let cell = monthsListCollectionView.dequeueReusableCell(withReuseIdentifier: "VisitMonthsCollectionViewCell", for: indexPath) as? VisitMonthsCollectionViewCell {
                cell.configureCell(model: monthsListArray[indexPath.row])
                return cell
            }
        } else {
            if let cell = visitsDetailsListColletionView.dequeueReusableCell(withReuseIdentifier: "VisitsDetailsCollectionViewCell", for: indexPath) as? VisitsDetailsCollectionViewCell {
                cell.configureCell(model: visitDetailsArray[indexPath.row])
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}

extension VisitsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == monthsListCollectionView {
            let month = monthsListArray[indexPath.row].title
            selectedTab(month: month)
        }
    }
}

extension VisitsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView == monthsListCollectionView ? CGSize(width: monthsListCollectionView.frame.width / 5, height: 45) : CGSize(width: visitsDetailsListColletionView.frame.width - 10, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == monthsListCollectionView ? 5 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == monthsListCollectionView ? 5 : 0
    }
}
