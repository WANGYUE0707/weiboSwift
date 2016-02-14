//
//  DZStatusCell.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/22.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZStatusCell: UITableViewCell {

    /** 原创微博 */
    var originalView: UIView?
    /** 头像 */
    var iconView: DZIconView?
    /** 会员图标 */
    var vipView: UIImageView?
    /** 配图 */
    var photosView: DZStatusPhotosView?
    /** 昵称 */
    var nameLabel: UILabel?
    /** 时间 */
    var timeLabel: UILabel?
    /** 来源 */
    var sourceLabel: UILabel?
    /** 正文 */
    var contentLabel: UILabel?
    /** 转发微博整体 */
    var retweetView: UIView?
    /** 转发昵称 + 正文 */
    var retweetContentLabel: UILabel?
    /** 转发配图 */
    var retweetPhototsView: DZStatusPhotosView?
    /** 工具条 */
    var toolBar: DZStatusToolbar?
    /** 微博frame模型 */
    var statusFrame: DZStatusFrame? {
        willSet {
            let status = newValue?.status
            let user = status?.user
            // 微博尺寸
            originalView?.frame = (newValue?.originalViewF)!
            // 头像
            iconView?.frame = (newValue?.iconViewF)!
            iconView?.user = user
            
            // 会员图标
            if user?.vip == true {
                vipView?.hidden = false
                vipView?.frame = (newValue?.vipViewF)!
                vipView?.image = UIImage(named: "common_icon_membership_level" + "\((user?.mbrank)!)")
                vipView?.contentMode = .Center
                nameLabel?.textColor = UIColor.orangeColor()
            } else {
                vipView?.hidden = true
                nameLabel?.textColor = UIColor.blackColor()
            }
            
            // 配图
            if status?.pic_urls?.count != 0 {
                photosView?.frame = (newValue?.photosViewF)!
                photosView?.photos = status?.pic_urls
                photosView?.hidden = false
            } else {
                photosView?.hidden = true
            }
            
            // 昵称
            nameLabel?.frame = (newValue?.nameLabelF)!
            nameLabel?.text = user?.name
            nameLabel?.font = statusCellNameFont
            
            // 时间
            let time = (status?.created_at)! as NSString
            let timeX = newValue?.nameLabelF?.origin.x
            let timeY = CGRectGetMaxY((newValue?.nameLabelF)!) + statusCellBorderW
            let timeSize = time.size(statusCellTimeFont)
            timeLabel?.frame = CGRect(origin: CGPoint(x: timeX!, y: timeY), size: timeSize)
            timeLabel?.textColor = UIColor.orangeColor()
            timeLabel?.text = time as String
            timeLabel?.font = statusCellTimeFont

            // 来源
            let sourceX = CGRectGetMaxX((newValue?.timeLabelF)!) + statusCellBorderW
            let sourceY = timeY
            let sourceSize = ((status?.source)! as NSString).size(statusCellSourceFont)
            sourceLabel?.frame = CGRect(origin: CGPoint(x: sourceX, y: sourceY), size: sourceSize)
            sourceLabel?.text = status?.source
            sourceLabel?.font = statusCellSourceFont
            
            contentLabel?.frame = (newValue?.contentLabelF)!
            contentLabel?.text = status?.text
            contentLabel?.numberOfLines = 0
            
            /* 转发微博 */
            if let retweet_status = status?.retweeted_status { // 如果有转发微博
                let retweet_status_user = retweet_status.user
                retweetView?.hidden = false
                // 被转发微博整体
                retweetView?.frame = (newValue?.retweetViewF)!
                // 被转发微博正文
                retweetContentLabel?.frame = (newValue?.retweetContentLabelF)!
                retweetContentLabel?.text = "@" + "\((retweet_status_user?.name)!)" + ":" + "\((retweet_status.text)!)"
                
                // 是否有配图
                if retweet_status.pic_urls?.count != 0 {
                    retweetPhototsView?.frame = (newValue?.retweetPhototsViewF)!
                    retweetPhototsView?.photos = retweet_status.pic_urls
                    retweetPhototsView?.hidden = false
                } else {
                    retweetPhototsView?.hidden = true
                }
            } else {
                retweetView?.hidden = true
            }
            
            toolBar?.frame = (newValue?.toolBarF)!
            toolBar?.status = status
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    class func cell(tableView: UITableView) -> DZStatusCell? {
        
        let ID = "status"
        var cell = tableView.dequeueReusableCellWithIdentifier(ID)
        if cell == nil {
            cell = DZStatusCell(style: .Subtitle, reuseIdentifier: ID)
        }
        return cell as? DZStatusCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        // 添加子控件
        // 初始化原创微博
        setupOriginal()
        // 初始化被转发微博
        setupRetweet()
        // 初始化工具条
        setupToolBar()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension DZStatusCell {
    /**
     初始化原创微博
     */
    func setupOriginal() {
        // 原创微博
        let originalView = UIView()
        addSubview(originalView)
        self.originalView = originalView
        originalView.backgroundColor = UIColor.whiteColor()
        
        // 头像
        let iconView = DZIconView()
        originalView.addSubview(iconView)
        self.iconView = iconView
        
        // 会员
        let vipView = UIImageView()
        originalView.addSubview(vipView)
        self.vipView = vipView
        
        // 配图
        let photosView = DZStatusPhotosView()
        originalView.addSubview(photosView)
        self.photosView = photosView
        
        // 昵称
        let nameLabel = UILabel()
        originalView.addSubview(nameLabel)
        self.nameLabel = nameLabel
        
        // 时间
        let timeLabel = UILabel()
        originalView.addSubview(timeLabel)
        self.timeLabel = timeLabel
        
        // 来源
        let sourceLabel = UILabel()
        originalView.addSubview(sourceLabel)
        self.sourceLabel = sourceLabel
        
        // 内容
        let contentLabel = UILabel()
        originalView.addSubview(contentLabel)
        self.contentLabel = contentLabel
        contentLabel.font = statusCellContentFont
    }
    /**
     初始化转发微博
     */
    func setupRetweet() {
        // 被转发微博整体
        let retweetView = UIView()
        contentView.addSubview(retweetView)
        self.retweetView = retweetView
        retweetView.backgroundColor = UIColor.userColor(247, green: 247, blue: 247)
        
        // 转发的昵称 + 正文
        let retweetContentLabel = UILabel()
        retweetView.addSubview(retweetContentLabel)
        self.retweetContentLabel = retweetContentLabel
        retweetContentLabel.numberOfLines = 0
        retweetContentLabel.font = statusCellRetweetContentFont
        
        // 转发配图
        let retweetPhototsView = DZStatusPhotosView()
        retweetView.addSubview(retweetPhototsView)
        self.retweetPhototsView = retweetPhototsView
    }
    /**
     初始化工具条
     */
    func setupToolBar() {
        toolBar = DZStatusToolbar()
        toolBar?.backgroundColor = UIColor(patternImage: UIImage(named: "timeline_card_bottom_background")!)
        contentView.addSubview(toolBar!)
    }
    
    
}
