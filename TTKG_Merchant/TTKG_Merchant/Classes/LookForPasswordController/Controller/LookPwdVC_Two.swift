//
//  LookPwdVC_Two.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/22.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import  SnapKit
import Alamofire

class LookPwdVC_Two: UIViewController {

    var timers = NSTimer()
    var myTimer : NSTimer!
    var Countdown = 10
    var imageV = UIImageView()     //顶端图片
    var messageLabel = UILabel()   //message   Label
    var textView = UIView()        //输入框底部背景
    var codeLabel = UILabel()      //验证码label
    var textLabel = UITextField()  //验证码输入框
    var againBtn = UIButton()      //重新获取按钮
    var countdownTemp = UILabel()   //倒计时label
    
    
    var postCodeBtn = UIButton()
    var phoneText = ""
    private var verifyCode = ""
    var verifyCodeTemp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor(red: 237/255, green: 239/255, blue: 247/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LookPwdVC_Two.reduceMyClock), userInfo: nil, repeats: true)
        
        createUI()
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if onlineState {
            
            requestGetPhoneNumberClassifyCode(self.phoneText)
            
        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
    }
    
    //MARK:加载控件
    func createUI() {
        self.view.addSubview(imageV)
        self.view.addSubview(messageLabel)
        self.view.addSubview(textView)
        self.view.addSubview(postCodeBtn)
        textView.addSubview(codeLabel)
        textView.addSubview(textLabel)
        textView.addSubview(countdownTemp)
        
        textView.addSubview(againBtn)
        imageV.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        imageV.image = UIImage(named: "R2")
        imageV.contentMode = .ScaleAspectFit
        
        messageLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(imageV.snp_bottom)
            make.height.equalTo(25)
        }
        messageLabel.text = "短信验证码已经发送到手机" + phoneText
        messageLabel.font = UIFont.systemFontOfSize(12)
        
        
        textView.snp_makeConstraints { (make) in
            make.top.equalTo(messageLabel.snp_bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(44)
        }
        textView.backgroundColor = UIColor.whiteColor()
        
        codeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(2)
            make.top.equalTo(0).offset(7)
            make.width.equalTo(64)
            make.height.equalTo(30)
        }
        codeLabel.text = "验证码："
        codeLabel.font = UIFont.systemFontOfSize(14)
        countdownTemp.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-5)
            make.top.equalTo(0).offset(7)
            make.width.equalTo(18)
            make.height.equalTo(30)
        }
        countdownTemp.textColor = UIColor.redColor()
        countdownTemp.font = UIFont.systemFontOfSize(12)
        countdownTemp.textAlignment = .Center
        againBtn.snp_makeConstraints { (make) in
            make.right.equalTo(countdownTemp.snp_left)
            make.top.equalTo(0).offset(7)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        againBtn.setTitle("重新获取", forState: UIControlState.Normal)
        againBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        againBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        againBtn.addTarget(self, action: #selector(LookPwdVC_Two.onceAgainCodeBtn), forControlEvents: UIControlEvents.TouchUpInside)
        

        
        textLabel.snp_makeConstraints { (make) in
            make.left.equalTo(codeLabel.snp_right)
            make.right.equalTo(againBtn.snp_left)
            make.top.equalTo(0).offset(7)
            make.height.equalTo(30)
        }
        
        textLabel.addTarget(self, action: #selector(LookPwdVC_Two.getPhoneVerifyCode(_:)), forControlEvents: UIControlEvents.AllEvents)
        
        postCodeBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(5)
            make.right.equalTo(0).offset(-5)
            make.top.equalTo(textView.snp_bottom).offset(10)
            make.height.equalTo(35)
            
        }
        postCodeBtn.setTitle("提交验证码", forState: UIControlState.Normal)
        postCodeBtn.backgroundColor = UIColor.grayColor()
        postCodeBtn.addTarget(self, action: #selector(LookPwdVC_Two.nextToController), forControlEvents: UIControlEvents.TouchUpInside)
    }

    
    internal func nextToController(){
        
        
        if self.verifyCode == self.verifyCodeTemp {
            let nextVC = LookPwdVC_Three()
            nextVC.phoneText = self.phoneText
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else{
            let msg = "验证码不正确！"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.error(msg)
        }
        
    }
    
    internal func onceAgainCodeBtn(){
        
        if onlineState {
            
            self.Countdown = 10
            timers = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LookPwdVC_Two.reduceMyClock), userInfo: nil, repeats: true)
            timers.fire()
            requestGetPhoneNumberClassifyCode(self.phoneText)
            
        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
        
        
        
    }
    
    internal func reduceMyClock(){
        againBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        if Countdown > 0 {
            Countdown -= 1
            self.countdownTemp.text = "(\(Countdown))"
            againBtn.userInteractionEnabled = false
            postCodeBtn.userInteractionEnabled = true
        }else{
            myTimer.invalidate()
            timers.invalidate()
            self.countdownTemp.text = ""
            againBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            againBtn.userInteractionEnabled = true
            postCodeBtn.userInteractionEnabled = true
        }
    }

    
    func getPhoneVerifyCode(text:UITextField){
        if CheckDataTools.checkForNumberWithLength("4", number: text.text!) && CheckDataTools.checkForNumber(text.text!) {
            self.verifyCode = text.text!
            self.postCodeBtn.backgroundColor = UIColor.greenColor()
            self.postCodeBtn.userInteractionEnabled = true
        }else{
            self.postCodeBtn.backgroundColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1.0)
            self.postCodeBtn.userInteractionEnabled = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension LookPwdVC_Two {
    func requestGetPhoneNumberClassifyCode(phone:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/merchant/code"
        let parameters = ["phone":phone,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.POST, url, parameters: parameters)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    if (dict!["code"] as! Int == 0){
                        let vcode = dict!["data"]!["vcode"] as! String
                        
                        self.verifyCodeTemp = vcode
                        
                    }else{
                        let msg = "获取验证码失败！"
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.error(msg)
                    }
                    
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
}
