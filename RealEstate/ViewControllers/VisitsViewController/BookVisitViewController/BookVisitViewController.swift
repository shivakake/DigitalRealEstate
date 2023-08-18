//
//  BookVisitViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 11/05/23.
//

import UIKit
import ComponentUI

class BookVisitViewController: UIViewController {
    
    @IBOutlet weak var visiterNameView: UIView!
    @IBOutlet weak var visiterNameTextField: UITextField!
    @IBOutlet weak var visiterPhoneNumberView: UIView!
    @IBOutlet weak var visiterPhoneNumberTextField: UITextField!
    @IBOutlet weak var visitPlaceView: UIView!
    @IBOutlet weak var visitPlaceTextField: UITextField!
    @IBOutlet weak var visiterIntimeView: UIView!
    @IBOutlet weak var visiterIntimeTextField: UITextField!
    @IBOutlet weak var visitDateView: UIView!
    @IBOutlet weak var visitDateTextField: UITextField!
    @IBOutlet weak var bookVisitButton: UIButton!
    @IBOutlet var subTitlesLabels: [UILabel]!
    
    let dateFormatForUI = "dd-MMM-yyyy"
    let dateFormatForAPI = "yyyy-MM-dd"
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = styleLibrary.screenBackGroundColor
        for label in subTitlesLabels {
            label.showStyle(with: .small, weight: .medium)
        }
        bookVisitButton.showStyle(with: .subtitle, weight: .bold, textColor: .white, bgColor: styleLibrary.appColor, needCircularCorners: true)
        visiterNameTextField.showStyle(with: .content, weight: .regular)
        visiterPhoneNumberTextField.showStyle(with: .content, weight: .regular)
        visitPlaceTextField.showStyle(with: .content, weight: .regular)
        visiterIntimeTextField.showStyle(with: .content, weight: .regular)
        visitDateTextField.showStyle(with: .content, weight: .regular)
        visiterNameView.colorAndCornerRadiusToView()
        visiterPhoneNumberView.colorAndCornerRadiusToView()
        visitPlaceView.colorAndCornerRadiusToView()
        visiterIntimeView.colorAndCornerRadiusToView()
        visitDateView.colorAndCornerRadiusToView()
        configureTextFields()
    }
    
    fileprivate func configureTextFields() {
        visiterIntimeTextField.delegate = self
        visitDateTextField.delegate = self
        visiterNameTextField.delegate = self
        visitPlaceTextField.delegate = self
        visiterPhoneNumberTextField.delegate = self
    }
    
    func showTimePicker(_ incomingTextField: UITextField) {
        self.view.endEditing(true)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        showActionSheetWithCustomView(alertTitle: "Schedule Time", customView: datePicker, actionTitle: "Done", prefferedActionStyle: UIAlertController.Style.actionSheet, iPadPopupSourceView: incomingTextField, customViewHeight: 200, alertHeight: 320) {
            let strTime = datePicker.date.getFormattedStringFromDate(format: "hh:mm a")
            incomingTextField.text = strTime
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func helpButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookVisitButtonTapped(_ sender: UIButton) { }
    
    @IBAction func inTimeButtonTapped(_ sender: UIButton) {
        showTimePicker(visiterIntimeTextField)
    }
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        let datePicker = HomeDatePickerView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatForUI
        datePicker.getSelectedDate = { [weak self] selectedDate in
            guard let weakSelf = self else { return }
            let dateString = dateFormatter.string(from: selectedDate)
            weakSelf.visitDateTextField.text = dateString
        }
        view.addViewThroughConstraints(for: datePicker, in: view)
    }
}

extension BookVisitViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
