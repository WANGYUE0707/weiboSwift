//
//  UIColorExtension.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/12/12.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func userColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
       return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
}
