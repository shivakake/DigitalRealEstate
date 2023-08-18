//
//  SignInViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 15/05/23.
//

import UIKit
import ComponentUI

class SignInViewController: UIViewController {
    
    @IBOutlet var niceToMeetYouLabel: [UILabel]!
    @IBOutlet var dontHaveAccountLabel: [UILabel]!
    @IBOutlet weak var leftGreenView: UIView!
    @IBOutlet weak var topGreenView: UIView!
    @IBOutlet var signupButton: [UIButton]!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var emailViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lostPasswordButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonMethods()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func commonMethods() {
        setupUI()
        screenRotated()
        makeNotificationForOrientationChange()
        configureTextFields()
    }
    
    fileprivate func setupUI() {
        signinButton.showStyle(with: .subtitle, weight: .bold, textColor: .white, bgColor: styleLibrary.appColor, needCircularCorners: true)
        lostPasswordButton.showStyle(with: .meta, weight: .semibold, textColor: styleLibrary.appColor, bgColor: nil, needCircularCorners: false)
        for label in niceToMeetYouLabel {
            label.showStyle(with: .headline, weight: .medium, color: .black)
        }
        for label in dontHaveAccountLabel {
            label.showStyle(with: .meta, weight: .semibold, color: .darkGray)
        }
        for button in signupButton {
            button.showStyle(with: .meta, weight: .semibold, textColor: styleLibrary.appColor, bgColor: nil, needCircularCorners: false)
        }
    }
    
    fileprivate func configureTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func makeNotificationForOrientationChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(screenRotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func screenRotated() {
        if Device.orientation == .portrait {
            leftGreenView.isHidden = true
            topGreenView.isHidden = false
            if !Device.isPhone {
                emailViewTopConstraint.constant = 50
            }
        } else {
            leftGreenView.isHidden = false
            topGreenView.isHidden = true
            if !Device.isPhone {
                emailViewTopConstraint.constant = view.frame.height / 4
            }
        }
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
        let controller = TabBarViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let controller = SignupViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func lostPasswordButtonTapped(_ sender: UIButton) { }
}

extension SignInViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
