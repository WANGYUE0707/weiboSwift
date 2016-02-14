//
//  DZUser.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/21.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZUser: NSObject {
    
    /** 字符串类型的用户id */
    var idstr: String?
    /** 好友显示名称 */
    var name: String?
    /** 用户图像地址 */
    var profile_image_url: String?
    /** 会员类型 */
    var mbtype: NSNumber? {
        willSet {
            if Int(newValue!) > 2 {
                vip = true
            }
        }
    }
    /** 会员等级 */
    var mbrank: NSNumber?
    /** 是否会员 */
    var vip: Bool?
    /** 认证类型 */
    var verified_type: NSNumber?
  }
