//
//  DZDropDownMenuView.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/13.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZDropDownMenuView: UIView {

    var content: UIView? = nil {
        willSet {
            newValue!.x = 10
            newValue!.y = 15
            contentView.width = CGRectGetMaxX(newValue!.frame) + 10
            contentView.height = CGRectGetMaxY(newValue!.frame) + 15
            contentView.addSubview(newValue!)
        }
    }
    
    var contentController: UIViewController? = nil {
        willSet {
            content = newValue!.view
        }
    }
    
    // 内容View
    lazy var contentView: UIImageView = {
        let contentView = UIImageView()
        contentView.image = UIImage(named: "popover_background")
        contentView.width = 217
        contentView.height = 217
        contentView.userInteractionEnabled = true
        self.addSubview(contentView)
        return contentView
    }()
    
   // 显示方法
    func showFrom(fromView: UIView) {
        let window = UIApplication.sharedApplication().windows.last
        self.frame = (window?.bounds)!
        
        // 转化坐标系
        let newFrame = fromView.convertRect(fromView.bounds, toView: window)        
        contentView.centerX = CGRectGetMidX(newFrame)
        contentView.y = CGRectGetMaxY(newFrame)
        print(contentView)
        window?.addSubview(self)
    }
    
    // 销毁方法
    func dismiss() {
        print("销毁")
        self.removeFromSuperview()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismiss()
    }
    
}
