//
//  DZAccount.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/20.
//  Copyright © 2015年 望月. All rights reserved.
//

import Foundation

class DZAccount: NSObject, NSCoding {
    /** 用于调用access_token，接口获取授权后的access token */
    var access_token: String?
    /** access_token的生命周期，单位是秒数 */
    var expires_in: NSNumber?
    /** 当前授权用户的UID */
    var uid: String?
    /** access_token创建时间 */
    var creat_time: NSDate?
    /** 用户名 */
    var name: String?
    
    init(dict: NSDictionary) {
        access_token = dict["access_token"] as? String
        uid = dict["uid"] as? String
        expires_in = dict["expires_in"] as? NSNumber
        
        creat_time = NSDate()
        
    }
    
    // 归档
    func encodeWithCoder(enCoder: NSCoder) {
        enCoder.encodeObject(access_token, forKey: "access_token")
        enCoder.encodeObject(uid, forKey: "uid")
        enCoder.encodeObject(creat_time, forKey: "creat_time")
        enCoder.encodeObject(name, forKey: "name")
        enCoder.encodeObject(expires_in, forKey: "expires_in")
    }
    
    // 读档
     required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        uid = aDecoder.decodeObjectForKey("uid") as? String
        creat_time = aDecoder.decodeObjectForKey("creat_time") as? NSDate
        name = aDecoder.decodeObjectForKey("name") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        super.init()
    }
}
