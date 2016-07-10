//
//  Utils.swift
//  Xcuit
//
//  Created by Josep Gonzalez Fernandez on 10/7/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    // MARK: Data Storage
    
    class func register(user user: String, andPassword password: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(user, forKey: "user")
        userDefaults.setObject(password, forKey: "password")
        userDefaults.synchronize()
    }
    
    class func cleanLogin() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject("", forKey: "user")
        userDefaults.setObject("", forKey: "password")
        userDefaults.synchronize()
    }
    
    class func isLoggedIn() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        guard let email = userDefaults.objectForKey("user") as? String,
        let password = userDefaults.objectForKey("password") as? String else {
            register(user: "", andPassword: "")
            return false
        }
        
        return !email.isEmpty && !password.isEmpty
    }
    
    // MARK: VC Presentation
    
    class func presentLoginVC(view: UIViewController, animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
        vc.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        view.presentViewController(vc, animated: animated, completion: nil)
    }
}

// MARK: UIImageView Extension
extension UIImageView {
    func popUp() {
        self.transform = CGAffineTransformMakeScale(0.05, 0.05)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .CurveEaseOut, animations: {
            self.hidden = false
            self.transform = CGAffineTransformIdentity
            }, completion: { (_) in
                
        })
    }
}

// MARK: UITextField extension

extension UITextField {
    
    func setLeftPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRectMake(0, 0, padding, self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.Always
    }
}

// MARK: String extension

extension String {
    func isValidEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}