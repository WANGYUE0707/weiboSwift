//
//  DZTabBarViewController.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/8/28.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZTabBarViewController: UITabBarController, DZTabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 首页
        let home = DZHomeTableViewController()
        self.addChildViewController(home, title: "首页", imageName: "tabbar_home", selectedImageName: "tabbar_home_selected")
        
        // 消息中心
        let messageCenter = DZMessageCenterTableViewController()
        self.addChildViewController(messageCenter, title: "消息中心", imageName: "tabbar_message_center", selectedImageName: "tabbar_message_center_selected")
        
        // 发现
        let discover = DZDiscoverTableViewController()
        self.addChildViewController(discover, title: "发现", imageName: "tabbar_discover", selectedImageName: "tabbar_discover_selected")
        
        // 我
        let profile = DZProfileTableViewController()
        self.addChildViewController(profile, title: "我", imageName: "tabbar_profile_selected", selectedImageName: "tabbar_profile")
        
        let tabBar = DZTabBar()
        tabBar.clickDelegate = self
        self.setValue(tabBar, forKeyPath: "tabBar")
        
        
        
    }
    
    /**
    添加子控制器
    
    :param: child             子控制器
    :param: title             标题
    :param: imageName         图片
    :param: selectedImageName 选中图片
    */
    func addChildViewController(child: UIViewController, title: String, imageName: String, selectedImageName: String) {
        
        child.title = title
        child.tabBarItem.image = UIImage(named: imageName)
        child.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        // 设置正常状态字体
        var textAtts = [String : AnyObject]()
        textAtts[NSForegroundColorAttributeName] = UIColor(red: (123/255.0), green: (123/255.0), blue: (123/255.0), alpha: 1)
        child.tabBarItem.setTitleTextAttributes(textAtts, forState: UIControlState.Normal)
        
        // 设置选中状态下的字体
        var selectTextAtts = [String : AnyObject]()
        selectTextAtts[NSForegroundColorAttributeName] = UIColor.orangeColor()
        child.tabBarItem.setTitleTextAttributes(selectTextAtts, forState: UIControlState.Selected)
        
        
        let navi = DZNaviViewController(rootViewController: child)
        
        self.addChildViewController(navi)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBar(tabBar: DZTabBar) {
        let compose = UIViewController()
        compose.view.backgroundColor = UIColor.redColor()
        let navi = UINavigationController(rootViewController: compose)
        self.presentViewController(navi, animated: true, completion: nil)
        
    }
    
    
    
}
