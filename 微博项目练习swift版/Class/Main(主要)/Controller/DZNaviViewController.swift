//
//  DZNaviViewController.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/8/28.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit


class DZNaviViewController: UINavigationController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        
        let item = UIBarButtonItem.appearance()
        
        // 设置正常状态字体
        var textAtts = [String : AnyObject]()
        textAtts[NSForegroundColorAttributeName] = UIColor.orangeColor()
        textAtts[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        item.setTitleTextAttributes(textAtts, forState: UIControlState.Normal)
        
        // 设置不可用状态字体
        var selectedAtts = [String :AnyObject]()
        selectedAtts[NSForegroundColorAttributeName] = UIColor.lightGrayColor()
        selectedAtts[NSFontAttributeName] = UIFont.systemFontOfSize(14)
        item.setTitleTextAttributes(selectedAtts, forState: UIControlState.Disabled)
    }
    
    // 重写navi推出控制器方法来设置控制器
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        if self.viewControllers.count > 1 {
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.item(self, anction: "back", imageName: "navigationbar_back", selectedImageName: "navigationbar_back_highlighted")
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.item(self, anction: "more", imageName: "navigationbar_more", selectedImageName: "navigationbar_more_highlighted")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func back() {
        self.popViewControllerAnimated(true)
    
    }
    
    func more() {
        self.popToRootViewControllerAnimated(true)
    }

}
