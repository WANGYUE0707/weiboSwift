//
//  FoundationExtension.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/12/17.
//  Copyright © 2015年 望月. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func descriptionWithLocale(locale: AnyObject?) -> String {
        var str = "{\n"
        
        for (key, obj) in self.enumerate() {
            str += "\t\(key) = \(obj)\n"
        }
        str += "}"
        
        if let range = str.rangeOfString(",", options: .BackwardsSearch) {
            str.removeRange(range)
        }
        
        return str
    }
}
