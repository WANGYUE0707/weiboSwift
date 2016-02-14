//
//  DZNewFeatureViewController.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/17.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit

class DZNewFeatureViewController: UIViewController, UIScrollViewDelegate {

    var newFeatureCount = 4
    private var pageControl: UIPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupScrollerView()
        setupPageControl()
        
    }
    
    // 初始化ScrollerView
    func setupScrollerView() {
        let scrollerView = UIScrollView(frame: self.view.bounds)
        let scrollH = scrollerView.height
        let scrollW = scrollerView.width
        
        for i in 0..<newFeatureCount {
            let imageName = "new_feature_" + "\(i + 1)"
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.width = scrollW
            imageView.height = scrollH
            imageView.x = CGFloat(i) * scrollW
            if i == newFeatureCount - 1 {
                setupImageView(imageView)
            }
            scrollerView.addSubview(imageView)
        }
        
        scrollerView.contentSize = CGSizeMake(CGFloat(newFeatureCount) * scrollW, CGFloat())
        
        view.addSubview(scrollerView)
        scrollerView.pagingEnabled = true
        scrollerView.bounces = false
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.showsVerticalScrollIndicator = false
        scrollerView.delegate = self
    }
    
    func setupPageControl() {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = newFeatureCount
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl.centerX = view.centerX
        pageControl.centerY = view.height - 50
        self.pageControl = pageControl
        view.addSubview(pageControl)
    }
    
    func setupImageView(imageView: UIImageView) {
        imageView.userInteractionEnabled = true
        
        setupShareBtn(imageView)
        setupStarBtn(imageView)
        
    }
    
    func setupShareBtn(imageView: UIImageView) {
        let shareBtn = UIButton()
        shareBtn.setImage(UIImage(named: "new_feature_share_false"), forState: .Normal)
        shareBtn.setImage(UIImage(named: "new_feature_share_true"), forState: .Selected)
        shareBtn.setTitle("分享给大家", forState: .Normal)
        shareBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        shareBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        shareBtn.addTarget(self, action: "shareBtnClick:", forControlEvents: .TouchUpInside)
        
        shareBtn.width = 150
        shareBtn.height = 50
        shareBtn.centerX = imageView.width * 0.5
        shareBtn.centerY = imageView.height * 0.65
        
        shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        imageView.addSubview(shareBtn)

    }
    
    func setupStarBtn(imageView: UIImageView) {
        let starBtn = UIButton()
        starBtn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: .Normal)
        starBtn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: .Highlighted)
        starBtn.setTitle("开始微博", forState: .Normal)
        
        starBtn.width = 100
        starBtn.height = 30
        starBtn.centerX = imageView.width * 0.5
        starBtn.centerY = imageView.height * 0.73
        
        starBtn.addTarget(self, action: "starBtnClick", forControlEvents: .TouchUpInside)
        imageView.addSubview(starBtn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shareBtnClick(btn: UIButton) {
        btn.selected = !btn.selected
    }
    
    func starBtnClick() {
        let window = UIApplication.sharedApplication().keyWindow
        window?.rootViewController = DZTabBarViewController()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageControl?.currentPage = Int((scrollView.contentOffset.x / view.bounds.width) + 0.5)
    }
}


