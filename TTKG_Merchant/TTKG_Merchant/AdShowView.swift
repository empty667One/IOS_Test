//
//  AdShowView.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/24.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import WebKit

class AdShowView: UIView {
    private let ScreenWidth = UIScreen.mainScreen().bounds.size.width
    private let ScreenHeight  = UIScreen.mainScreen().bounds.size.height
    private let ScreenBounds = UIScreen.mainScreen().bounds
    var backGroundBtn : UIButton!
    var webView : WKWebView!
    
    var webStr = "" {
        didSet{
            webView.loadHTMLString(webStr, baseURL: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let current  = UIApplication.sharedApplication().keyWindow
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        current?.addSubview(self)
        backGroundBtn = UIButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight ))
        self.addSubview(backGroundBtn)
        backGroundBtn.addTarget(self, action: #selector(AdShowView.backGroundBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        webView = WKWebView(frame: self.frame)
        self.addSubview(webView)
        
        let btn = UIButton(frame: CGRect(x: 10, y: 10, width: 44, height: 44))
        btn.setImage(UIImage(named: "disMissBtnIcon"), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(AdShowView.dismissView), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(btn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(){
        let currentWindow = UIApplication.sharedApplication().keyWindow
        self.backgroundColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        currentWindow?.addSubview(self)
    }
    
    func dismissView(){
        self.removeFromSuperview()
    }

    func backGroundBtnClk(){
    
    }
    
}
