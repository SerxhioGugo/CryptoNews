//
//  UIColor.swift
//  CryptoNews
//
//  Created by Serxhio Gugo on 12/15/18.
//  Copyright © 2018 Serxhio Gugo. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int , green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0 , alpha: 1.0)
    }
    
    //Simple extension with initializer that allows using Hex code instead of RGB
    //Create a new static property and paste HEX value after 0x
    static var luckyPointColor: UIColor { return UIColor.init(rgb: 0x192a56)}
    static var myGrayColor: UIColor { return UIColor.init(rgb: 0x232323)}
    
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue : rgb & 0xFF
        )
    }
}
