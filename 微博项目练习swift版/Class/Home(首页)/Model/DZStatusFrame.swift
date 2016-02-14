//
//  DZStatusFrame.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/22.
//  Copyright © 2015年 望月. All rights reserved.
//

import Foundation

// 昵称字体
let statusCellNameFont = UIFont.systemFontOfSize(15)
// 时间字体
let statusCellTimeFont = UIFont.systemFontOfSize(12)
// 来源字体
let statusCellSourceFont = UIFont.systemFontOfSize(12)
// 正文字体
let statusCellContentFont = UIFont.systemFontOfSize(15)
// 被转发正文字体
let statusCellRetweetContentFont = UIFont.systemFontOfSize(15)
// 边距
let statusCellBorderW: CGFloat = 10
// cell之间的间距
let statusCellMargin: CGFloat = 15

class DZStatusFrame: NSObject {

    
    /** 原创微博 */
    var originalViewF: CGRect?
    /** 头像 */
    var iconViewF: CGRect?
    /** 会员图标 */
    var vipViewF: CGRect?
    /** 配图 */
    var photosViewF: CGRect?
    /** 昵称 */
    var nameLabelF: CGRect?
    /** 时间 */
    var timeLabelF: CGRect?
    /** 来源 */
    var sourceLabelF: CGRect?
    /** 正文 */
    var contentLabelF: CGRect?
    /** 转发微博整体 */
    var retweetViewF: CGRect?
    /** 转发昵称 + 正文 */
    var retweetContentLabelF: CGRect?
    /** 转发配图 */
    var retweetPhototsViewF: CGRect?
    /** 工具条 */
    var toolBarF: CGRect?
    /** 单元格行高 */
    var cellHeight: CGFloat?
    
    /** 微博模型 */
    var status: DZStatus? {
        willSet {
            let user = newValue?.user
            let cellW = UIScreen.mainScreen().bounds.width
            /** 原创微博 */
             /* 头像 */
            let iconWH: CGFloat = 30.0
            let iconX = statusCellBorderW
            let iconY = statusCellBorderW
            iconViewF = CGRect(x: iconX, y: iconY, width: iconWH, height: iconWH)
            
            /* 昵称 */
            let nameX: CGFloat = CGRectGetMaxX(iconViewF!) + statusCellBorderW
            let nameY: CGFloat = iconY
            // 通过字符串计算label的尺寸
            let nameSize = NSString(string: (user?.name)!).size(statusCellNameFont)
            nameLabelF = CGRect(origin: CGPoint(x: nameX, y: nameY), size: nameSize)
            
            /* 会员 */
            if user?.vip == true {
                let vipX = CGRectGetMaxX(nameLabelF!) + statusCellBorderW
                let vipY = statusCellBorderW
                let vipH = nameSize.height
                let vipW: CGFloat = 14
                vipViewF = CGRect(x: vipX, y: vipY, width: vipW, height: vipH)
            }
            
            /* 时间 */
            let timeX = nameX
            let timeY = CGRectGetMaxY(nameLabelF!) + statusCellBorderW
            debugPrint(newValue?.created_at)
            let timeSize = NSString(string: (newValue?.created_at)!).size(statusCellTimeFont)
            timeLabelF = CGRect(origin: CGPoint(x: timeX, y: timeY), size: timeSize)
            
            /* 来源 */
            let sourceX = CGRectGetMaxX(timeLabelF!) + statusCellBorderW
            let sourceY = timeY
            let sourceSize = NSString(string: (newValue?.source)!).size(statusCellSourceFont)
            sourceLabelF = CGRect(origin: CGPoint(x: sourceX, y: sourceY), size: sourceSize)
            
            /* 正文 */
            let contentX = iconX
            let contentY = max(CGRectGetMaxY(iconViewF!), CGRectGetMaxY(timeLabelF!))
            let contentW = cellW - 2 * contentX
            let contentSize = NSString(string: (newValue?.text)!).size(statusCellContentFont, maxW: contentW)
            contentLabelF = CGRect(origin: CGPoint(x: contentX, y: contentY), size: contentSize)
            
            /* 配图 */
            var originalH: CGFloat = 0
            if newValue?.pic_urls?.count != 0 {
                let photosX = contentX
                let photosY = CGRectGetMaxY(contentLabelF!) + statusCellBorderW
                let photosSize = DZStatusPhotosView.size(count: CGFloat((newValue?.pic_urls!.count)!))
                photosViewF = CGRect(origin: CGPoint(x: photosX, y: photosY), size: photosSize)
                originalH = CGRectGetMaxY(photosViewF!) + statusCellBorderW
            } else {
                originalH = CGRectGetMaxY(contentLabelF!) + statusCellBorderW
            }
            
            /* 原创微博整体 */
            let originalX: CGFloat = 0
            let originalY = statusCellMargin
            let originalW = cellW
            originalViewF = CGRect(x: originalX, y: originalY, width: originalW, height: originalH)
            
            /* 被转发微博 */
            var retweetH: CGFloat = 0
            var toolBarY: CGFloat = 0
            
            if let retweet_status = newValue?.retweeted_status { // 有被转发微博
                let retweet_status_user = newValue?.user
                
                /* 被转正文 */
                let retweetContentX = statusCellBorderW
                let retweetContentY = statusCellBorderW
                let retweetContent = "\(retweet_status_user?.name)" + "\(retweet_status.text)"
                let retweetContentSize = NSString(string: retweetContent).size(statusCellRetweetContentFont, maxW: contentW)
                retweetContentLabelF = CGRect(origin: CGPoint(x: retweetContentX, y: retweetContentY), size: retweetContentSize)
                
                /* 被转微博配图 */
                if retweet_status.pic_urls?.count != 0 { // 有配图
                    let retweetphotosX = contentX
                    let retweetphotosY = CGRectGetMaxY(retweetContentLabelF!) + statusCellBorderW
                    let retweetphotosSize = DZStatusPhotosView.size(count: CGFloat(retweet_status.pic_urls!.count))
                    retweetPhototsViewF = CGRect(origin: CGPoint(x: retweetphotosX, y: retweetphotosY), size: retweetphotosSize)
                    retweetH = CGRectGetMaxY(retweetPhototsViewF!) + statusCellBorderW
                } else {
                    retweetH = CGRectGetMaxY(retweetContentLabelF!) + statusCellBorderW
                }
                
                /* 被转微博整体 */
                let retweetX: CGFloat = 0
                let retweetY = CGRectGetMaxY(originalViewF!)
                let retweetW = cellW
                retweetViewF = CGRect(x: retweetX, y: retweetY, width: retweetW, height: retweetH)
                
                toolBarY = CGRectGetMaxY(retweetViewF!)
                
            } else {
                toolBarY = CGRectGetMaxY(originalViewF!)
            }
            
            /* 工具条 */
            let toolBarX: CGFloat = 0
            let toolBarW = cellW
            let toolBarH: CGFloat = 35
            toolBarF = CGRect(x: toolBarX, y: toolBarY, width: toolBarW, height: toolBarH)
            
            /* cell的高度 */
            cellHeight = CGRectGetMaxY(toolBarF!)
        }
    }

}
