//
//  DZStatus.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/22.
//  Copyright © 2015年 望月. All rights reserved.
//

import Foundation

class DZStatus: NSObject {
    /** 微博ID */
    var idstr: String?
    /** 正文 */
    var text: String?
    /** 用户 */
    var user: DZUser?
    /** 来源 */
    var source: String?
    /** 创建时间 */
    var created_at: String?
    /** 配图 */
    var pic_urls: NSArray?
    /** 被转发微博 */
    var retweeted_status: DZStatus?
    /** 转发数 */
    var reposts_count: NSNumber?
    /** 评论数 */
    var comments_count: NSNumber?
    /** 表态数 */
    var attitudes_count: NSNumber?
    
    class func objectClassInArray() -> NSDictionary {
        return ["pic_urls": DZPhoto.classForCoder()]
    }
}

