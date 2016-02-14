//
//  DZTitleButton.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/21.
//  Copyright © 2015年 望月. All rights reserved.
//

import Foundation

class DZTitleButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DZTitleButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView?.x == 0 {
            titleLabel?.x = (imageView?.x)!
            imageView?.x = CGRectGetMaxX((titleLabel?.frame)!)
        }
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title, forState: state)
        sizeToFit()
    }
    
    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image, forState: state)
        sizeToFit()
    }
}