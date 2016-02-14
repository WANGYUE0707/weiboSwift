//
//  DZIconView.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/12/10.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit
import Kingfisher

class DZIconView: UIImageView {
    enum DZUserVerifiedType: NSNumber {
        case None = -1
        case Personal = 0
        case Enterprice = 2
        case Media = 3
        case Website = 5
        case Daren = 220
        case Other = 7
    }
    
    lazy var verifiedView: UIImageView? = {
        let verifiedView = UIImageView()
        self.addSubview(verifiedView)
        return verifiedView
    }()
    
    var user: DZUser? {
        willSet {
           kf_setImageWithURL(NSURL(string: (newValue?.profile_image_url)!)!, placeholderImage: UIImage(named: "avatar_default"))
            
            let type = DZUserVerifiedType(rawValue: (newValue?.verified_type)!)
            switch type! {
            case .Personal: // 个人认证
                verifiedView?.hidden = false
                verifiedView?.image = UIImage(named: "avatar_enterprise_vip")
            case .Enterprice, .Media, .Website: // 官方认证
                verifiedView?.hidden = false
                verifiedView?.image = UIImage(named: "avatar_grassroot")
            case .Daren: // 达人
                verifiedView?.hidden = false
                verifiedView?.image = UIImage(named: "avatar_enterprise_vip")
            default:
                verifiedView?.hidden = true
            }
        }
    }
}

extension DZIconView {
    override func layoutSubviews() {
//        debugPrint(verifiedView!.image?.size)
        if let size = verifiedView!.image?.size {
        verifiedView?.size = size
        let scale: CGFloat = 0.6
        verifiedView?.x = width - (verifiedView?.width)! * scale
        verifiedView?.y = height - (verifiedView?.height)! * scale
        }
    }
}


