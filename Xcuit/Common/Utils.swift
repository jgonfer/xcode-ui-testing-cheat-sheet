//
//  Utils.swift
//  Xcuit
//
//  Created by Josep Gonzalez Fernandez on 10/7/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
}

// MARK: UITextField extension

extension UITextField {
    
    func setLeftPadding(padding: CGFloat) {
        let paddingView = UIView(frame: CGRectMake(0, 0, padding, self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.Always
    }
}