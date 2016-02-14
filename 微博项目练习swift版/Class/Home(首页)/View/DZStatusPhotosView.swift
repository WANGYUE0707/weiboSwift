//
//  DZStatusPhotosView.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/24.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

let statusPhotoWH: CGFloat = 70
let statusMargin: CGFloat = 10

// 显示列数
func statusMaxCols(count: CGFloat) -> CGFloat {
    return count == 4 ? 2 : 3
}

class DZStatusPhotosView: UIView {
    
    var photoView: DZStatusPhotoView?
    
    var photos: NSArray? {
        willSet {
            let photoCount = newValue?.count
            debugPrint("图片的张数\(photoCount)")
            // 创建足够的控制器
            while subviews.count < photoCount {
                let photoView = DZStatusPhotoView()
                photoView.backgroundColor = UIColor.redColor()
                debugPrint("====")
                self.addSubview(photoView)
            }
            
            // 控制图片隐藏和显示
            for i in 0..<subviews.count {
                let photoView = subviews[i] as! DZStatusPhotoView
                if i < photoCount {
                    
                    photoView.photo = newValue![i] as? DZPhoto
                    debugPrint("====\(photoView.photo?.thumbnail_pic)")
                    
                    photoView.hidden = false
                } else {
                    photoView.hidden = true
                }
            }
        }
    }
    
    class func size(count count: CGFloat) -> CGSize {
        let maxCols: CGFloat = statusMaxCols(count)
        let cols = (count >= maxCols) ? maxCols : count
        let photosW = cols * statusPhotoWH + (cols - 1) * statusMargin
        
        let rows = (count + maxCols - 1) / maxCols
        let photosH = rows * statusPhotoWH + (rows - 1) * statusMargin
        
        return CGSize(width: photosW, height: photosH)
    }
    
}

// MARK: - 布局
extension DZStatusPhotosView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let photoCount = (photos?.count)!
        
        for i in 0..<photoCount {
            let photoView = subviews[i] as! DZStatusPhotoView
            photoView.height = statusPhotoWH
            photoView.width = statusPhotoWH
            
            let col = CGFloat(i) % statusMaxCols(CGFloat(photoCount))
            photoView.x = CGFloat(Int(col)) * (statusPhotoWH + statusMargin)
            
            let row = CGFloat(i) / statusMaxCols(CGFloat(photoCount))
            photoView.y = CGFloat(Int(row)) * (statusPhotoWH + statusMargin)
            photoView.backgroundColor = UIColor.redColor()
            debugPrint("-----\(photoView.frame)")
            
        }
        
    }
}
