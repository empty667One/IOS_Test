//
//  LoginVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire


class LoginVC: UIViewController {
    var loginModel :TLoginModel!
    @IBOutlet var SecurityBtn: UIButton!
    @IBOutlet var UserTel: UITextField!
    
    @IBOutlet var UserPwd: UITextField!
    
    @IBOutlet var LoginBtn: UIButton!
    
    @IBOutlet var ForgotPwd: UIButton!
    
    @IBOutlet var RegisterBtn: UIButton!
    
    @IBAction func LookPwdBtn(sender: AnyObject) {
        if SecurityBtn.selected {
            UserPwd.secureTextEntry = true
            SecurityBtn.selected = !SecurityBtn.selected
        }else{
            UserPwd.secureTextEntry = false
            SecurityBtn.selected = !SecurityBtn.selected
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        UserPwd.secureTextEntry = true
        UserTel.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        UserPwd.tag = 100
        UserPwd.addTarget(self, action: #selector(LoginVC.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        UserPwd.tag = 200
//        测试合并----------123456
    }
    
    
    @IBAction func LoginBtnClick(sender: AnyObject) {
        if CheckDataTools.checkForMobilePhoneNumber(UserTel.text!){
            
            if CheckDataTools.checkForPasswordWithShortest(6, longest: 16, pwd: UserPwd.text!){
                
                
                if onlineState {
                    
                   RequestForLogin(UserTel.text!, password: UserPwd.text!)
                    
                }else{
                    let msg = "无网络连接"
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.warning(msg)
                }
                
                
                
            }else{
                let alert = UIAlertView(title: "提示", message: "请输入6到12位有效密码", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
            
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入正确的手机号", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    
    @IBAction func ForgotPwdClick(sender: AnyObject) {
        
        let lookPwdVC = LookPwdVC_One()
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: lookPwdVC)
        
        self.presentViewController(nvc1, animated: false) { () -> Void in
            
        }
        
        
    }
    
    @IBAction func RegisterBtnClick(sender: AnyObject) {
        
        let registerVC =  Register01()
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: registerVC)
        
        self.presentViewController(nvc1, animated: false) { () -> Void in
            
        }
        
    }
    
    func textFieldDidChange(text:UITextField){
        if text.tag == 100 {
            self.UserTel.text = text.text
        }
        if text.tag == 200 {
            self.UserPwd.text = text.text
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let username = NSUserDefaults.standardUserDefaults().objectForKey("username")
        let userpwd = NSUserDefaults.standardUserDefaults().objectForKey("userpwd")
        
        if username != nil {
            self.UserTel.text = username as? String
            self.UserPwd.text = userpwd as? String
        }
    }
    

}

extension LoginVC {
    
    func RequestForLogin(phone:String,password:String) {
        
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        HUD.mode = MBProgressHUDMode.Indeterminate
        HUD.label.text = "登陆中,请稍等！"
        
        let url = serverUrl + "/merchant/login"
        let parameters = ["phone":phone,"password":password]
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
                    
                    self.loginModel = TLoginModel.init(fromDictionary: dict!)
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    
                    if (self.loginModel.code == 0) {
                        
                        HUD.hideAnimated(true, afterDelay: 1)
                        let (address,areaid,keyid,loginid,name,picurl,roleid,shopname,tel,ptmc) = self.loginModel.data.getUserInfo()
                        
                        
                        if let temp = address {
                            userInfo_Global.address = temp
                        }
                        
                        if let temp = areaid {
                            userInfo_Global.areaid = temp
                        }
                        
                        if let temp = keyid {
                            userInfo_Global.keyid = temp
                        }
                        
                        if let temp = loginid {
                            userInfo_Global.loginid = temp
                        }
                        
                        if let temp = name {
                            userInfo_Global.name = temp
                        }
                        
                        if let temp = picurl {
                            userInfo_Global.picurl = temp
                        }
                        
                        if let temp = roleid {
                            userInfo_Global.roleid = temp
                        }
                        
                        
                        if let temp = shopname {
                            userInfo_Global.shopname = temp
                        }
                        
                        
                        if let temp = tel {
                            userInfo_Global.tel = temp
                        }
                        
                        userInfo_Global.password = self.UserPwd.text!
                        
                        
                        self.view.dodo.success(self.loginModel.msg)
                        NSUserDefaults.standardUserDefaults().setObject(self.UserTel.text!, forKey: "username")
                        NSUserDefaults.standardUserDefaults().setObject(self.UserPwd.text!, forKey: "userpwd")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        if userInfo_Global.roleid == 4 {//配送商
                            NSNotificationCenter.defaultCenter().postNotificationName("notifyPeiSongTabbar", object: nil)
                        }else{//零售商,测试员
                            NSNotificationCenter.defaultCenter().postNotificationName("notifyControllerVC", object: nil)
                        }
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("postAdView", object: nil)
                    }else{
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.error(self.loginModel.msg)
                        HUD.hideAnimated(true, afterDelay: 1)
                    }

                    
                    
                case .Failure(let error):
                    print(error)
                    HUD.hideAnimated(true, afterDelay: 1)
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.error("网络故障")
                }
        }
        
    }
    
    
    
    
}


