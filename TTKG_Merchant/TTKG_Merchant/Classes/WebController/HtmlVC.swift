//
//  HtmlVC.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/13.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

class HtmlVC: UIViewController {

    var HUD:MBProgressHUD?
    
    //需要加载的html字符串
    var htmlStr:String? {
        didSet{
            webView.loadHTMLString(htmlStr!, baseURL: nil)
        }
    }
    //需要加载的网页链接
    var htmlUrl:String?{
        didSet{
            // 发送网络请求
            let url:NSURL = NSURL(string:htmlUrl!)!
            let request:NSURLRequest = NSURLRequest(URL:url)
            webView.loadRequest(request)
        }
    }
    
    private var webView = UIWebView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.view.addSubview(webView)
        webView.delegate = self
        webView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        HUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        HUD!.mode = MBProgressHUDMode.Indeterminate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //导航栏左边返回按钮
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HtmlVC.back))
    }

    
    func back()  {
//        self.navigationController?.popViewControllerAnimated(true)
    }
}


extension HtmlVC:UIWebViewDelegate{
    // 该方法是在UIWebView在开发加载时调用
    func webViewDidStartLoad(webView: UIWebView) {
        let message = "努力加载中"
        HUD!.label.text = message
    }
    // 该方法是在UIWebView加载完之后才调用
    func webViewDidFinishLoad(webView: UIWebView) {
        HUD?.hideAnimated(true)
    }
    // 该方法是在UIWebView请求失败的时候调用
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        let message = "网络好像不给力哦！！！"
        HUD!.label.text = message
        HUD!.hideAnimated(true, afterDelay: 1)
    }
   
}











