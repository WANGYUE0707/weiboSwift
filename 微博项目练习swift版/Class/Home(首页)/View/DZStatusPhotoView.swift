//
//  DZStatusPhotoView.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/24.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZStatusPhotoView: UIImageView {

    var photo: DZPhoto? {
        willSet {
            contentMode = .ScaleAspectFill
            clipsToBounds = true
            kf_showIndicatorWhenLoading = true
            kf_setImageWithURL(NSURL(string: (newValue?.thumbnail_pic)!)!, placeholderImage: UIImage(named: "timeline_image_placeholder"))
        }
    }

    lazy var gifView: UIImageView? = {
        let gifview = UIImageView(image: UIImage(named: "timeline_image_gif"))
        self.addSubview(gifview)
        return gifview
    }()
    
}
