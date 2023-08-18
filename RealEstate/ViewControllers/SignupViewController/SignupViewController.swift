//
//  SignupViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 15/05/23.
//

import UIKit
import ComponentUI

class SignupViewController: UIViewController {
    
    @IBOutlet weak var leftGreenView: UIView!
    @IBOutlet var createYourAccountLabel: [UILabel]!
    @IBOutlet var alreadyHaveAccountLabel: [UILabel]!
    @IBOutlet weak var topGreenView: UIView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signupTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var signinButton: [UIButton]!
    
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
        signupButton.showStyle(with: .subtitle, weight: .bold, textColor: .white, bgColor: styleLibrary.appColor, needCircularCorners: true)
        for label in createYourAccountLabel {
            label.showStyle(with: .headline, weight: .medium, color: .black)
        }
        for label in alreadyHaveAccountLabel {
            label.showStyle(with: .meta, weight: .semibold, color: .darkGray)
        }
        for button in signinButton {
            button.showStyle(with: .meta, weight: .semibold, textColor: styleLibrary.appColor, bgColor: nil, needCircularCorners: false)
        }
    }
    
    fileprivate func configureTextFields() {
        usernameTextField.delegate = self
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
            } else {
                emailViewTopConstraint.constant = 30
                signupTopConstraint.constant = 100
            }
        } else {
            leftGreenView.isHidden = false
            topGreenView.isHidden = true
            if !Device.isPhone {
                emailViewTopConstraint.constant = view.frame.height / 4
            } else {
                emailViewTopConstraint.constant = 20
                signupTopConstraint.constant = 50
            }
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        let controller = TabBarViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
        let controller = SignInViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SignupViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
