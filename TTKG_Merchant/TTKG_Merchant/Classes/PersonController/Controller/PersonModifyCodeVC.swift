//
//  PersonModifyCodeVC.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/18.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class PersonModifyCodeVC: UIViewController {

    let textFiled1 = UITextField()
    let textFiled2 = UITextField()
    let textFiled3 = UITextField()
    
    let btn = UIButton()
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    
   

    
    override func viewDidLoad() {
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationItem.title = "修改密码"
        creatUI()
    }
    
    
    
    func creatUI()  {
        
        textFiled1.placeholder = "请输入旧密码"
        textFiled1.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(textFiled1)
        textFiled1.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.right.equalTo(0).offset(-15)
            make.top.equalTo(0).offset(30)
            make.height.equalTo(35)
        }
        
        textFiled2.placeholder = "请输入新密码"
        textFiled2.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(textFiled2)
        textFiled2.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.right.equalTo(0).offset(-15)
            make.top.equalTo(textFiled1.snp_bottom).offset(15)
            make.height.equalTo(35)
        }
        
        textFiled3.placeholder = "确认密码"
        textFiled3.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(textFiled3)
        textFiled3.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.right.equalTo(0).offset(-15)
            make.top.equalTo(textFiled2.snp_bottom).offset(15)
            make.height.equalTo(35)
        }
        
        btn.backgroundColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(self.btnClick), forControlEvents: UIControlEvents.TouchUpInside)
        btn.setTitle("提交修改", forState: UIControlState.Normal)
        self.view.addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.right.equalTo(0).offset(-15)
            make.top.equalTo(textFiled3.snp_bottom).offset(20)
            make.height.equalTo(35)
        }
    }
    
    func btnClick()  {
        
        if textFiled2.text == textFiled3.text {
            if onlineState{
                
                requestModifyCode(userInfo_Global.loginid, password: textFiled1.text!, newpassword: textFiled2.text!)
            }

        }else
        {
            let msg = "请确认新密码"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
        
        
    }
}

extension PersonModifyCodeVC{
    
    //请求修改密码
    func requestModifyCode(phone:String, password:String, newpassword:String) {
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        
        let parameters = ["phone":phone, "password":password, "newpassword":newpassword,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/merchant/changepwd"
        
        Alamofire.request(.POST, url, parameters:parameters  )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
     
                        if dict!["code"] as! Int == 0{
                            
                            let message = "请重新登录"
                            
                            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                            self.view.dodo.style.bar.locationTop = false
                            self.view.dodo.warning(message)
                            
                            let time: NSTimeInterval = 0.5
                            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                            dispatch_after(delay, dispatch_get_main_queue()) {
                                
                                let notice = NSNotification(name: "toLoginVC", object: nil)
                                NSNotificationCenter.defaultCenter().postNotification(notice)
                            }
                            
                            
                            
                        }else
                        {
                            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                            self.view.dodo.style.bar.locationTop = false
                            self.view.dodo.warning(dict!["msg"] as! String)
                        }

                        
                    }catch _ {
                        let msg = "无网络连接"
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.warning(msg)
                    }
                    
                    
                case .Failure(let error):
                    let msg = "无网络连接"
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.warning(msg)
                }
                
        }
        
    }

}
