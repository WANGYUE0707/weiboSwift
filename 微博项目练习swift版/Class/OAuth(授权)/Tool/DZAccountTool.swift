//
//  DZAccountTool.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/20.
//  Copyright © 2015年 望月. All rights reserved.
//

import Foundation

class DZAccountTool: NSObject {
    private static let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last?.stringByAppendingString("/access.data")
    
    static func save(account: DZAccount) {
        
        NSKeyedArchiver.archiveRootObject(account, toFile: path!)
    }
    
    static func account() -> DZAccount? {
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as? DZAccount
        
        // 获取当前时间
        let nowDate = NSDate()
        // 获取过期时间
        let expiresTime = account?.creat_time?.dateByAddingTimeInterval(Double((account?.expires_in)!))
        
        // 比较是否过期
        if expiresTime?.compare(nowDate) != .OrderedDescending {
            return nil
        }
        return account
    }
    
}
