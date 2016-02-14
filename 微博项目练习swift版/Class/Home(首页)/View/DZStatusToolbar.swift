//
//  DZStatusToolbar.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/22.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZStatusToolbar: UIView {
    
    // 转发
    private var repostsBtn: UIButton?
    // 评论数
    private var commentsBtn: UIButton?
    // 表态数
    private var attitudesBtn: UIButton?
    
    // 存放btn数组
    private lazy var btnArray: Array<AnyObject> = {
        var array = []
        return array as Array<AnyObject>
    }()
    
    // 存放分割线数组
    private lazy var dividerArray: Array<AnyObject> = {
        var array = []
        return array as Array<AnyObject>
    }()
    
    var status:DZStatus? {
        willSet {
            setupBtn(newValue?.reposts_count, btn: repostsBtn!, title: "转发")
            setupBtn(newValue?.comments_count, btn: commentsBtn!, title: "评论")
            setupBtn(newValue?.attitudes_count, btn: attitudesBtn!, title: "赞")
        }
    }
    
    override init(frame: CGRect) {
//        repostsBtn = UIButton()
//        commentsBtn = UIButton()
//        attitudesBtn = UIButton()
        super.init(frame: frame)
        repostsBtn = setupBtn(title: "转发", icon: "timeline_icon_retweet")
        commentsBtn = setupBtn(title: "评论", icon: "timeline_icon_comment")
        attitudesBtn = setupBtn(title: "赞", icon: "timeline_icon_unlike")
        
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBtn(count: NSNumber?, btn: UIButton, var title: String) {
        if count != nil {
            if Int(count!) >= 10000 {
                let wan = Double(count!) / 10000.0
                title = wan.format(f: ".1") + "万"
                title = title.stringByReplacingOccurrencesOfString(".0", withString: "") // 对特殊字符进行替换
            } else {
                title = "\(count!)"
            }
        }
        btn.setTitle(title, forState: .Normal)
    }
}

extension DZStatusToolbar {
    func setupBtn(title title: String, icon: String) ->UIButton {
        let btn = UIButton()
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.setImage(UIImage(named: icon), forState: .Normal)
        btn.setTitle(title, forState: .Normal)
        addSubview(btn)
        btnArray.append(btn)
        return btn
    }
    
    func addDivider() {
        let divider = UIImageView(image: UIImage(named: "timeline_card_bottom_line"))
        addSubview(divider)
        dividerArray.append(divider)
    }
    
  }

// MARK: -布局
extension DZStatusToolbar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnCount = btnArray.count
        let btnY: CGFloat = 0
        let btnW = width / CGFloat(btnCount)
        let btnH = height
        
        // 遍历按钮数组
        for i in 0..<btnCount {
            let btn = subviews[i]
            btn.x = CGFloat(i) * btnW
            btn.y = btnY
            btn.width = btnW
            btn.height = btnH
        }
        
        // 遍历分割线数组
        let dividerCount = dividerArray.count
        for i in 0..<dividerCount {
            let divider = dividerArray[i] as! UIImageView
            divider.width = CGFloat(1)
            divider.height = btnH
            divider.x = CGFloat(i + 1) * btnW
            divider.y = 0
        }
    }
}
