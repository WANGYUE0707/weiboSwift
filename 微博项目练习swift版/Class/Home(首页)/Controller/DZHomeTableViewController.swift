//
//  DZHomeTableViewController.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/8/28.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit
import Alamofire
import MJExtension

class DZHomeTableViewController: UITableViewController {

    lazy var StatuseFrames: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavi()
        
        // 获取用户信息
        setupUserInfo()
        
        // 加载微博
        setupRefresh()
        
        }
    
    // MARK: -设置导航栏
    func setupNavi() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.item(self, anction: "friendSearch", imageName: "navigationbar_friendsearch", selectedImageName: "navigationbar_friendsearch_highlighted")
        navigationItem.rightBarButtonItem = UIBarButtonItem.item(self, anction: "pop", imageName: "navigationbar_pop", selectedImageName: "navigationbar_pop_highlighted")
        
        // 添加中间标题
        addtitleViw()
    }
    
    func addtitleViw() {
        let titBtn = DZTitleButton(type: .Custom)
        titBtn.setTitle("首页", forState: .Normal)
        titBtn.frame.size = CGSizeMake(150, 30)
        titBtn.addTarget(self, action: "dropDownMenu:", forControlEvents: .TouchUpInside)
        
        navigationItem.titleView = titBtn
    }
    
    func dropDownMenu(button: UIButton) {
        
        let dropDownMenu = DZDropDownMenuView()
        
        let dropDownMenuVC = DZDropDownMenuTableViewController()
        dropDownMenuVC.view.height = 44 * 3
        dropDownMenuVC.view.width = 200
        dropDownMenu.contentController = dropDownMenuVC

        dropDownMenu.showFrom(button)
    }
    
    func friendSearch() {
        print("搜索朋友")
    }
    
    func pop() {
        print("公共")
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StatuseFrames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = DZStatusCell.cell(tableView)
        cell?.statusFrame = StatuseFrames[indexPath.row] as? DZStatusFrame

        return cell!
    }
    


}

// MARK: -获取用户信息
extension DZHomeTableViewController {
    func setupUserInfo() {
        
        let account = DZAccountTool.account()
        debugPrint(account?.access_token!)
        let param: [String: AnyObject]? = [
            "access_token" : (account?.access_token)!,
            "uid" : (account?.uid)!
        ]
        
        Alamofire.request(.GET, "https://api.weibo.com/2/users/show.json", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                // 字典转模型
                let user = DZUser.mj_objectWithKeyValues(json)
                let titleBtn = self.navigationItem.titleView as? UIButton
                titleBtn?.setTitle(user.name, forState: .Normal)
                account?.name = user.name
                DZAccountTool.save(account!)
                
            case .Failure(let error):
                debugPrint(error)
            }
            
            
        }
    }
}

// 加载微博信息
extension DZHomeTableViewController {
    
    /** 上拉刷新 */
    func setupRefresh() {
        let control = UIRefreshControl()
        control.addTarget(self, action: "refreshNewStatuses:", forControlEvents: .ValueChanged)
        view.addSubview(control)
        control.beginRefreshing() // 开始刷新
        
        refreshNewStatuses(control) // 手动调用
    }
    
    /** 下拉刷新 */
    func setupFooterRefresh() {
    
    }
    
    /** 刷新微博 */
    func refreshNewStatuses(control: UIRefreshControl) {
        
        let param: [String: AnyObject] = [
            "access_token" : (DZAccountTool.account()?.access_token)!,
            "count" : 2
        ]
        
        Alamofire.request(.GET, "https://api.weibo.com/2/statuses/friends_timeline.json", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                debugPrint(json)
                // TODO: 字典转模型
                let newStatuses = DZStatus.mj_objectArrayWithKeyValuesArray(json["statuses"])
                let newS = newStatuses[0] as? DZStatus
                debugPrint(newS?.pic_urls)
                // status模型转化为Frame模型
                let newStatusFrames = self.statusFrame(newStatuses)
                
                // 获取范围
                let range = NSMakeRange(0, newStatusFrames.count)
                let set = NSIndexSet(indexesInRange: range)
                
                self.StatuseFrames.insertObjects(newStatusFrames as [AnyObject], atIndexes: set)
                self.tableView.reloadData()
                control.endRefreshing()
            case .Failure(let error):
                debugPrint(error)
                control.endRefreshing()
            }
        }
    }
    
    func statusFrame(statuses: NSMutableArray) -> NSArray {
        let frames = NSMutableArray()
        for status in statuses {
            let f = DZStatusFrame()
            f.status = status as? DZStatus
            frames.addObject(f)
        }
        return frames
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let statusFrame = StatuseFrames[indexPath.row] as? DZStatusFrame
//        debugPrint(statusFrame?.status?.user?.name)
        return (statusFrame?.cellHeight)!
    }
    
}
