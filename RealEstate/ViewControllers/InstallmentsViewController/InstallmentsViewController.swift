//
//  InstallmentsViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 11/05/23.
//

import UIKit
import ComponentUI

class InstallmentsViewController: UIViewController {
    
    @IBOutlet weak var installmentsTitleLabel: UILabel!
    @IBOutlet private weak var noInstallmentsDataAvailableLabel: UILabel!
    @IBOutlet weak var installmentsListCollectionView : UICollectionView!
    
    var installmentsListArray = [
        InstallmentDataModel(title: "#0", dateTitle: "Paid Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: true, outstanding: false, paymentType: "Paid"),
        InstallmentDataModel(title: "#1023", dateTitle: "Due Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: false, outstanding: false, paymentType: "Pending"),
        InstallmentDataModel(title: "#2046", dateTitle: "Paid Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: true, outstanding: false, paymentType: "Paid"),
        InstallmentDataModel(title: "#3069", dateTitle: "Due Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: false, outstanding: false, paymentType: "Pending"),
        InstallmentDataModel(title: "#1046", dateTitle: "Paid Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: true, outstanding: false, paymentType: "Paid"),
        InstallmentDataModel(title: "#2069", dateTitle: "Due Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: false, outstanding: false, paymentType: "Pending"),
        InstallmentDataModel(title: "#2069", dateTitle: "Due Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: false, outstanding: true, paymentType: "Outstanding"),
        InstallmentDataModel(title: "#2069", dateTitle: "Due Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: false, outstanding: true, paymentType: "Outstanding"),
        InstallmentDataModel(title: "#2069", dateTitle: "Due Date", dateDetails: "26th Aug, Mon 10:30 am", price: "₹50000000", paymentStatus: false, outstanding: true, paymentType: "Outstanding")
    ]
    var filteredList = [InstallmentDataModel]()
    var selectedFiler = "All"
    var isFiltered: Bool = false
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        installmentsListCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    public func setupUI() {
        view.backgroundColor = styleLibrary.screenBackGroundColor
        installmentsTitleLabel.showStyle(with: .content, weight: .semibold)
        noInstallmentsDataAvailableLabel.isHidden = true
        registerColletionViewCellAndDelegate()
    }
    
    public func registerColletionViewCellAndDelegate(){
        installmentsListCollectionView.register(UINib(nibName: "InstallmentsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InstallmentsCollectionViewCell")
        installmentsListCollectionView.delegate = self
        installmentsListCollectionView.dataSource = self
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
        let controller = InstallmentsFilterViewController()
        controller.filterNameCallBack = { [weak self] filetrId in
            controller.isFilterSelected = true
            guard let _self = self else { return }
            _self.selectedFiler = filetrId
            if filetrId == "All"{
                _self.filteredList = _self.installmentsListArray
            } else {
                _self.filteredList = _self.installmentsListArray.filter { filetrName in
                    return (filetrName.paymentType?.localizedCaseInsensitiveContains(filetrId) ?? false)
                }
            }
            _self.isFiltered = true
            _self.installmentsListCollectionView.reloadData()
        }
        controller.selectedFilter = self.selectedFiler
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension InstallmentsViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered == false{
            return installmentsListArray.count
        }else{
            return filteredList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = installmentsListCollectionView.dequeueReusableCell(withReuseIdentifier: "InstallmentsCollectionViewCell", for: indexPath) as? InstallmentsCollectionViewCell {
            
            if isFiltered == false {
                cell.configureCell(model: installmentsListArray[indexPath.row])
            } else {
                cell.configureCell(model: filteredList[indexPath.row])
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension InstallmentsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = installmentsListArray[indexPath.row]
        print(model)
    }
}

extension InstallmentsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colletionViewWidth = installmentsListCollectionView.frame.size.width
        if isFiltered == false {
            if installmentsListArray[indexPath.row].paymentStatus == true {
                return CGSize(width: (colletionViewWidth), height: 150)
            } else {
                return CGSize(width: (colletionViewWidth), height: 200)
            }
        } else {
            if filteredList[indexPath.row].paymentStatus == true {
                return CGSize(width: (colletionViewWidth), height: 150)
            } else {
                return CGSize(width: (colletionViewWidth), height: 200)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
