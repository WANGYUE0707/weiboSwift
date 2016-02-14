//
//  DZOAuthViewController.swift
//  微博项目练习swift版
//
//  Created by 望月 on 15/11/19.
//  Copyright © 2015年 望月. All rights reserved.
//

import UIKit
import Alamofire

class DZOAuthViewController: UIViewController, UIWebViewDelegate {
    
    private let client_id = "225326342"
    private let client_secret = "5133b7d9ca70777f97a23366a132adf4"
    private let redirect_uri = "http://www.baidu.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView()
        let url = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)")
        let request = NSURLRequest(URL: url!)
        
        webView.frame = view.bounds
        webView.delegate = self
        view.addSubview(webView)
        webView.loadRequest(request)
    }
    
    // MARK: - 网页代理方法
    func webViewDidStartLoad(webView: UIWebView) {
        MBProgressHUD.showMessage("请稍后。。。")
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        MBProgressHUD.hideHUD()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        MBProgressHUD.hideHUD()
    }
    
    // 拦截请求
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.URL?.absoluteString
        
        if let codeRange: Range = url?.rangeOfString("code=") { // 回调
            let fromIndex = codeRange.endIndex
            let code = url?.substringFromIndex(fromIndex)
            
            accessTokenWithCode(code!)
            return false // 已经拿到code就不用再次回调了
        }
        
        return true
    }
}

extension DZOAuthViewController {
    /** 通过code换取Token */
    func accessTokenWithCode(code: String) {
        let param = [
            "client_id" : client_id,
            "client_secret" : client_secret,
            "grant_type" : "authorization_code",
            "code" : code,
            "redirect_uri" : redirect_uri
        ]
        
        // TODO: 返回错误信息怎么办？
        Alamofire.request(.POST, "https://api.weibo.com/oauth2/access_token", parameters: param, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            
            switch Response.result {
            case .Success(let json):
                
                    let account = DZAccount(dict: json as! NSDictionary) // 字典转模型
                    debugPrint(account.expires_in)
                    // 归档
                    DZAccountTool.save(account)
                    let windows = UIApplication.sharedApplication().keyWindow
                    windows?.swichKeyWindow()

            case .Failure(let error):
                print(error)
                
            }
            
        }
    }
}

