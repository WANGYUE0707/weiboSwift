//
//  DZSearchBar.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/8/28.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZSearchBar: UITextField {
    
       
    // 创建自定义的searchBar
    class func searchBar() -> UITextField {
        
        let searchBar = UITextField()
        searchBar.background = UIImage(named: "searchbar_textfield_background")
        searchBar.placeholder = "请输入要搜索的内容"
        searchBar.font = UIFont.systemFontOfSize(14)
        let imageView = UIImageView(image: UIImage(named: "searchbar_textfield_search_icon"))
        imageView.frame.size = CGSizeMake(30, 30)
        imageView.contentMode = UIViewContentMode.Center
        searchBar.leftView = imageView
        searchBar.leftViewMode = UITextFieldViewMode.Always
        
        return searchBar
    }
   
  }
