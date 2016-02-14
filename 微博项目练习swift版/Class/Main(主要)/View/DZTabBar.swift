//
//  DZTabBar.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/14.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit


// TODO: 扩展代理?
//extension UITabBarControllerDelegate {
//
//
//}

// 暂时这么处理
protocol DZTabBarDelegate: UITabBarDelegate {
    func tabBar(tabBar: DZTabBar)
}

class DZTabBar: UITabBar {
    
    let plusButton = UIButton()
    
    // 为什么不能这么写？？？？？？？
//    var delegate: DZTabBarDelegate?
    
    var clickDelegate: DZTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.delegate = self
        let plusBtn = plusButton
        plusBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        plusBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        plusBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        plusBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        
        plusBtn.addTarget(self, action: "btnClick", forControlEvents: .TouchUpInside)
        plusBtn.size = (plusBtn.currentBackgroundImage?.size)!
        self.addSubview(plusBtn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: 按钮点击事件
    func btnClick() {        
        if ((self.delegate?.respondsToSelector("tabBar:")) != nil) {
            self.clickDelegate!.tabBar(self)
        }
    }
}

// MARK: - 布局
extension DZTabBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        plusButton.centerX = self.width * 0.5
        plusButton.centerY = self.height * 0.5
        
        let count = self.subviews.count
        var tabBarIndex = 0
        
        for var i = 0; i < count; i++ {
            let child = self.subviews[i]
            
            if child.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                child.width = self.width / 5
                child.x = child.width * CGFloat(tabBarIndex)
                tabBarIndex++
                
                if tabBarIndex == 2 {
                    tabBarIndex++
                }
            }
        }
    }
    
    
    

}
