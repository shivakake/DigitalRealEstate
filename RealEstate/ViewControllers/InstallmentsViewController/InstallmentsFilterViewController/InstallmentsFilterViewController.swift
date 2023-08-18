//
//  InstallmentsFilterViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 12/05/23.
//

import UIKit
import ComponentUI

class InstallmentsFilterViewController: UIViewController {
    
    @IBOutlet weak var filterTitleLabel: UILabel!
    @IBOutlet weak var installmentsFilterTableViewOutlet : UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    var filterListArray = [CategoriesDataModel]()
    var selectedFilter: String?
    var filterNameCallBack : ((String) -> Void)?
    var isFilterSelected: Bool = false
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    func commonMethods() {
        view.backgroundColor = styleLibrary.screenBackGroundColor
        setupTable()
        filterTitleLabel.showStyle(with: .content, weight: .semibold)
        doneButton.showStyle(with: .subtitle, weight: .bold, textColor: .white, bgColor:styleLibrary.appColor, needCircularCorners: true)
        setList(selectedFilter)
    }
    
    func setupTable(){
        installmentsFilterTableViewOutlet.separatorStyle = .none
        installmentsFilterTableViewOutlet.showsHorizontalScrollIndicator = false
        installmentsFilterTableViewOutlet.showsVerticalScrollIndicator = false
        installmentsFilterTableViewOutlet.dataSource = self
        installmentsFilterTableViewOutlet.delegate = self
        installmentsFilterTableViewOutlet.register(UINib(nibName: "InstallmentsFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "InstallmentsFilterTableViewCell")
    }
    
//    func updateTable(){
//        DispatchQueue.main.async {
//            self.installmentsFilterTableViewOutlet.reloadData()
//        }
//    }
    
    func setList(_ filterName: String?) {
        if filterName == "Paid" {
            filterListArray = [CategoriesDataModel(title: "All", isSelected: false),
                               CategoriesDataModel(title: "Paid", isSelected: true),
                               CategoriesDataModel(title: "Outstanding", isSelected: false),
                               CategoriesDataModel(title: "Pending", isSelected: false)]
        } else if filterName == "Outstanding" {
            filterListArray = [CategoriesDataModel(title: "All", isSelected: false),
                               CategoriesDataModel(title: "Paid", isSelected: false),
                               CategoriesDataModel(title: "Outstanding", isSelected: true),
                               CategoriesDataModel(title: "Pending", isSelected: false)]
        } else if filterName == "Pending" {
            filterListArray = [CategoriesDataModel(title: "All", isSelected: false),
                               CategoriesDataModel(title: "Paid", isSelected: false),
                               CategoriesDataModel(title: "Outstanding", isSelected: false),
                               CategoriesDataModel(title: "Pending", isSelected: true)]
        } else {
            filterListArray = [CategoriesDataModel(title: "All", isSelected: true),
                               CategoriesDataModel(title: "Paid", isSelected: false),
                               CategoriesDataModel(title: "Outstanding", isSelected: false),
                               CategoriesDataModel(title: "Pending", isSelected: false)]
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension InstallmentsFilterViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = installmentsFilterTableViewOutlet.dequeueReusableCell(withIdentifier: "InstallmentsFilterTableViewCell", for: indexPath) as? InstallmentsFilterTableViewCell{
            if isFilterSelected == true{
                cell.configureCell(model: filterListArray[indexPath.row])
            } else {
                cell.configureCell(model: filterListArray[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension InstallmentsFilterViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filterNameCallBack?(filterListArray[indexPath.row].title ?? "All")
        setList(filterListArray[indexPath.row].title ?? "All")
        tableView.reloadTableView()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
