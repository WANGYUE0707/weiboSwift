//
//  DZDropDownMenuTableViewController.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/13.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZDropDownMenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let id = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(id)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: id)
        }
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "111"
        case 1:
            cell?.textLabel?.text = "222"
        case 2:
            cell?.textLabel?.text = "333"
        default: break
        }
        
        return cell!
    }
}
