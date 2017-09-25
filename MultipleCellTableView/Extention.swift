//
//  Extention.swift
//  MultipleCellTableView
//
//  Created by Chung Tran on 9/25/17.
//  Copyright © 2017 Chung Tran. All rights reserved.
//

import UIKit

fileprivate class Keys {
    static let TOP_BORDER = "top-border"
    static let TOP_BORDER_VIEW = "top-border-view"
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var topBorder: Bool {
        get {
            if self.layer.value(forKey: Keys.TOP_BORDER) != nil {
                return self.layer.value(forKey: Keys.TOP_BORDER) as! Bool
            }
            
            return false
        }
        set {
            self.layer.setValue(newValue, forKey: Keys.TOP_BORDER)
        }
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
}
