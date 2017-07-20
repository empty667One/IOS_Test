//
//  New_LoginVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/30.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class New_LoginVC: UIViewController,UIAlertViewDelegate{
    
//    var checkUpdate:CheckUpdateModel!
    var loginModel :TLoginModel!
    var backImage = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh))  //背景图
    var textInputVIew = UIView()    //输入框背景
    var LogoView = UIImageView()    //logo标记
    var userText  = UITextField()   //账号输入框
    var pwdText = UITextField()     //密码输入框
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backImage.image = UIImage(named: "背景")
        self.view.addSubview(backImage)
        createUI()
        
        
    }
    
    //MARK:Getter
    func createUI(){
        self.backImage.addSubview(LogoView)
        self.view.addSubview(textInputVIew)
        
        //添加约束
        LogoView.snp_makeConstraints { (make) in
            make.centerX.equalTo(backImage.snp_centerX)
            make.width.equalTo(200)
            make.top.equalTo(0).offset(64)
            make.height.equalTo(84)
        }
        
        LogoView.image = UIImage(named: "LOGO")
        LogoView.contentMode = .ScaleAspectFit
        
        textInputVIew.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(LogoView.snp_bottom).offset(40)
            make.height.equalTo(75)
        }
        textInputVIew.backgroundColor = UIColor.whiteColor()
        //定义属性
        let userName = UILabel()
        let lineView = UIView()
        let pwdLabel = UILabel()
        let securityBtn = UIButton()
        
        
        textInputVIew.addSubview(userName)
        textInputVIew.addSubview(userText)
        textInputVIew.addSubview(lineView)
        textInputVIew.addSubview(pwdLabel)
        textInputVIew.addSubview(pwdText)
        textInputVIew.addSubview(securityBtn)
        
        //账号输入框
        userName.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(1)
            make.top.equalTo(textInputVIew.snp_top).offset(1)
            make.width.equalTo(46)
            make.height.equalTo(28)
        }
        userName.text = "账号:"
        userText.snp_makeConstraints { (make) in
            make.left.equalTo(userName.snp_right).offset(1)
            make.top.equalTo(0).offset(1)
            make.right.equalTo(0)
            make.height.equalTo(28)
        }
        userText.clearButtonMode = .WhileEditing
        userText.tag = 100
        userText.addTarget(self, action: #selector(New_LoginVC.getTextContent(_:)), forControlEvents: UIControlEvents.AllEvents)
        userText.placeholder = "请输入手机号"
        
        //分割线
        lineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(userText.snp_bottom).offset(8)
            make.height.equalTo(1)
        }
        
        lineView.backgroundColor = UIColor.grayColor()
        
        //密码输入框
        pwdLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(1)
            make.top.equalTo(lineView.snp_bottom).offset(5)
            make.width.equalTo(46)
            make.height.equalTo(28)
        }
        pwdLabel.text = "密码:"
        
        securityBtn.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-8)
            make.top.equalTo(lineView.snp_bottom).offset(5)
            make.width.height.equalTo(22)
        }
        securityBtn.setImage(UIImage(named: "显示密码"), forState: UIControlState.Normal)
        securityBtn.addTarget(self, action: #selector(New_LoginVC.lookPwdText(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        pwdText.snp_makeConstraints { (make) in
            make.left.equalTo(pwdLabel.snp_right).offset(1)
            make.top.equalTo(lineView.snp_top).offset(5)
            make.right.equalTo(securityBtn.snp_left).offset(-5)
            make.height.equalTo(28)
        }
        pwdText.clearButtonMode = .WhileEditing
        pwdText.secureTextEntry = true
        pwdText.placeholder = "请输入密码"
        pwdText.tag = 200
        pwdText.addTarget(self, action: #selector(New_LoginVC.getTextContent(_:)), forControlEvents: UIControlEvents.AllEvents)
        
        //登陆按钮
        let LoginBtn = UIButton()
        self.view.addSubview(LoginBtn)
        LoginBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(30)
            make.right.equalTo(0).offset(-30)
            make.top.equalTo(textInputVIew.snp_bottom).offset(35)
            make.height.equalTo(34)
        }
        LoginBtn.setTitle("登录", forState: UIControlState.Normal)
        LoginBtn.backgroundColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1.0)
        LoginBtn.addTarget(self, action: #selector(New_LoginVC.clickLoginBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
        //找回密码按钮
        let LookPwdBtn = UIButton()
        self.view.addSubview(LookPwdBtn)
        LookPwdBtn.snp_makeConstraints { (make) in
            make.top.equalTo(LoginBtn.snp_bottom).offset(5)
            make.right.equalTo(0).offset(-10)
            make.width.equalTo(64)
            make.height.equalTo(30)
        }
        LookPwdBtn.setTitle("找回密码", forState: UIControlState.Normal)
        LookPwdBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        LookPwdBtn.setTitleColor(UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1.0), forState: UIControlState.Normal)
        LookPwdBtn.addTarget(self, action: #selector(New_LoginVC.clickLookPwdBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
        //注册按钮
        let registerBtn = UIButton()
        self.view.addSubview(registerBtn)
        registerBtn.snp_makeConstraints { (make) in
            make.centerX.equalTo(backImage.snp_centerX)
            make.top.equalTo(LoginBtn.snp_bottom).offset(55)
            make.width.equalTo(200)
            make.height.equalTo(35)
        }
        
        registerBtn.setImage(UIImage(named: "d_03"), forState: UIControlState.Normal)
        registerBtn.addTarget(self, action: #selector(New_LoginVC.clickRegisterBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    //MARK:Event Response
    func  getTextContent(textStr:UITextField){
        if textStr.tag == 100 {
            self.userText.text = textStr.text
        }
        if textStr.tag == 200 {
            self.pwdText.text = textStr.text
        }
    }
    
    //点击登录按钮点击事件
    func clickLoginBtn(){
        //NSLog("xxxxxxxx")
        if CheckDataTools.checkForMobilePhoneNumber(userText.text!){
            
            if CheckDataTools.checkForPasswordWithShortest(6, longest: 16, pwd: pwdText.text!){
                
                
                if onlineState {
                    
                    RequestForLogin(userText.text!, password: pwdText.text!)
                    
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
    
    //找回密码按钮点击事件
    func clickLookPwdBtn(){
        NSLog("look")
        let lookPwdVC = LookPwdVC_One()
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: lookPwdVC)
        
        self.presentViewController(nvc1, animated: false) { () -> Void in
            
        }
    }
    
    //注册按钮
    func clickRegisterBtn(){
        NSLog("reG")
        let registerVC =  Register_One()
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: registerVC)
        
        self.presentViewController(nvc1, animated: false) { () -> Void in
            
        }
    }

    //显示密码右侧图片
    func lookPwdText(sender:UIButton){
        if sender.selected {
            pwdText.secureTextEntry = true
            sender.selected = !sender.selected
        }else{
            pwdText.secureTextEntry = false
            sender.selected = !sender.selected
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //存用户名和密码
    override func viewWillAppear(animated: Bool) {
        GetNetWorkTime().requestNetWorkTime()
        let username = NSUserDefaults.standardUserDefaults().objectForKey("username")
        let userpwd = NSUserDefaults.standardUserDefaults().objectForKey("userpwd")
        
        if username != nil {
            self.userText.text = username as? String
            self.pwdText.text = userpwd as? String
        }
        
        
//        // 得到当前应用的版本号
//        let infoDictionary = NSBundle.mainBundle().infoDictionary
//        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
//        NSLog("currentAppVersion==\(currentAppVersion)")
//        
//        
//        requestCheckUpdate(currentAppVersion)
        
        
    }
    

}


extension New_LoginVC {
    //获取客服电话并拨打
    func requestTelphone() {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let para = ["sign":MD5_time,"timespan":timeTemp.description]
        let url = serverUrl + "/platform/contact"
        Alamofire.request(.GET, url, parameters:para )
            .responseString { response -> Void in
                
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        if dict!["code"] as! Int == 0{
                            
                            let dic = dict!["data"] as! NSDictionary
                            if let tel = dic["tel"] as? String {
                                UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(tel)")!)
                            }
                            
                        }
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    
                case .Failure(let error): break
                    
                }
                
        } 
        
    }
    
    //请求登录接口
    func RequestForLogin(phone:String,password:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        HUD.mode = MBProgressHUDMode.Indeterminate
        HUD.label.text = "登陆中,请稍等！"
        
        let url = serverUrl + "/merchant/login"
        let parameters = ["phone":phone,"password":password,"sign":MD5_time,"timespan":timeTemp.description]
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
                    //self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    //self.view.dodo.style.bar.locationTop = false
                    
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
                        if let temp = ptmc {
                            userInfo_Global.ptmc = temp
                        }

                        
                        userInfo_Global.password = self.pwdText.text!
                        
                        
                        self.view.dodo.success(self.loginModel.msg)
                        NSUserDefaults.standardUserDefaults().setObject(self.userText.text!, forKey: "username")
                        NSUserDefaults.standardUserDefaults().setObject(self.pwdText.text!, forKey: "userpwd")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        if userInfo_Global.roleid == 4 {//配送商
                            NSNotificationCenter.defaultCenter().postNotificationName("notifyPeiSongTabbar", object: nil)
                        }else{//零售商,测试员
                            NSNotificationCenter.defaultCenter().postNotificationName("notifyControllerVC", object: nil)
                        }
                        
                        
                        
                        NSNotificationCenter.defaultCenter().postNotificationName("postAdView", object: nil)
                    }else{
                        
                        if self.loginModel.msg == "用户未审核" {
                            self.view.dodo.style.bar.locationTop = false
                            self.view.dodo.style.leftButton.image = UIImage(named: "phone")
                            self.view.dodo.style.leftButton.hideOnTap = true
                            self.view.dodo.style.leftButton.tintColor = DodoColor.fromHexString("#FFFFFF")
                            
                            self.view.dodo.style.leftButton.onTap = {
                                self.requestTelphone()
                            }
                            self.view.dodo.style.bar.hideAfterDelaySeconds = 5
                            self.view.dodo.success("点击左边联系客服(账号没有被审核通过)")
                        }else{
                            self.view.dodo.style.bar.hideAfterDelaySeconds = 3
                            self.view.dodo.style.leftButton.image = nil
                            self.view.dodo.style.bar.locationTop = false
                            self.view.dodo.error(self.loginModel.msg)
                        }
                        
                        
                        HUD.hideAnimated(true, afterDelay: 1)
                    }
                    
                    
                    
                case .Failure(let error):
                    print(error)
                    HUD.hideAnimated(true, afterDelay: 1)
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 3
                    self.view.dodo.style.leftButton.image = nil
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.error("网络故障")
                }
        }
        
    }
    
    
//    func requestCheckUpdate(version:String){
//        let url = "https://upgrade.ttkgmall.com/appInformation/check"
//        let parameters = ["version":version,"type":"4"]
//        Alamofire.request(.GET, url, parameters: parameters)
//            .responseString { response -> Void in
//                
//                switch response.result {
//                case .Success:
//                    let dict:NSDictionary?
//                    do {
//                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
//                    }catch _ {
//                        dict = nil
//                    }
//                    NSLog("dict == \(dict?.allKeys)--\(dict?.allValues)")
//                    self.checkUpdate = CheckUpdateModel.init(fromDictionary: dict!)
//                    if (self.checkUpdate.success == true) && (self.checkUpdate.state == 4){
//                        let alert = UIAlertView(title: self.checkUpdate.msg, message: self.checkUpdate.descriptionField, delegate: self, cancelButtonTitle: "去更新")
//                        alert.tag = 100
//                        alert.show()
//                    }
//                    
//                    if (self.checkUpdate.success == true) && (self.checkUpdate.state == 1){
//                        let alert = UIAlertView(title: self.checkUpdate.msg, message: self.checkUpdate.descriptionField, delegate: self, cancelButtonTitle: "去更新",otherButtonTitles: "取消")
//                        alert.tag = 200
//                        alert.show()
//                    }
//                    
//                case .Failure(_): break
//                    
//                }
//        
//        }
//
//    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if alertView.tag == 100{
        
            UIApplication.sharedApplication().openURL(NSURL(string: "https://upgrade.ttkgmall.com/app/index")!)
        }
        
        if alertView.tag == 200 {
            if buttonIndex == 0 {
                NSLog("xxxxx")
                UIApplication.sharedApplication().openURL(NSURL(string: "https://upgrade.ttkgmall.com/app/index")!)
            }else{
                NSLog("ccccc")
            }
        }
        
    }
    
    
}
