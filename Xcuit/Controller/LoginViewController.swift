//
//  LoginViewController.swift
//  Xcuit
//
//  Created by jgonzalez on 8/7/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var badgeAlertEmail: UIImageView!
    @IBOutlet weak var badgeAlertPassword: UIImageView!
    
    private let kCornerRadius: CGFloat = 3
    private let kPaddingTextField: CGFloat = 10
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        emailTextField.delegate = self
        emailTextField.layer.cornerRadius = kCornerRadius
        emailTextField.setLeftPadding(kPaddingTextField)
        passwordTextField.delegate = self
        passwordTextField.layer.cornerRadius = kCornerRadius
        passwordTextField.setLeftPadding(kPaddingTextField)
        logInButton.layer.cornerRadius = kCornerRadius
    }
    
    private func resignTextFields() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: IBActions Methods
    
    @IBAction func logIn(sender: UIButton) {
        UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: [.CurveEaseOut], animations: {
            sender.transform = CGAffineTransformMakeScale(1.05, 1.05)
        }) { (Bool) in
        }
        
        UIView.animateWithDuration(0.25, delay: 1.0, options: .CurveEaseIn, animations: {
            sender.transform = CGAffineTransformIdentity
        }) { (_) in
        }
        
        UIView.animateWithDuration(0.25, delay: 1.25, options: [], animations: {
            //sender.alpha = 0
        }) { (Bool) in
            let hud = UIActivityIndicatorView(frame: sender.frame)
            hud.activityIndicatorViewStyle = .Gray
            //self.loginStackView.addSubview(hud)
            hud.startAnimating()
        }
        
        resignTextFields()
        
        badgeAlertEmail.hidden = true
        badgeAlertPassword.hidden = true
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        guard !email.isEmpty else {
            badgeAlertEmail.popUp()
            return
        }
        
        guard email.isValidEmail() else {
            badgeAlertEmail.popUp()
            return
        }
        
        guard !password.isEmpty else {
            badgeAlertPassword.popUp()
            return
        }
        
        Utils.register(user: email, andPassword: password)
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        let identifier = textField.accessibilityIdentifier!
        switch identifier {
        case emailTextField.accessibilityIdentifier!:
            badgeAlertEmail.hidden = true
        case passwordTextField.accessibilityIdentifier!:
            badgeAlertPassword.hidden = true
        default:
            break
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            logIn(logInButton)
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}