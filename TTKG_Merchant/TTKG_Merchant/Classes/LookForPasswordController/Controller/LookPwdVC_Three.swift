//
//  LookPwdVC_Three.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/22.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class LookPwdVC_Three: UIViewController {

    var imageV = UIImageView()
    var textView = UIView()
    var setPwdLabel = UILabel()
    var surePwdLabel = UILabel()
    var setPwdText = UITextField()
    var surePwdText = UITextField()
    var sureBtn = UIButton()
    var phoneText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "找回密码"
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor(red: 237/255, green: 239/255, blue: 247/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        createUI()
    }

    func createUI() {
        self.view.addSubview(imageV)
       self.view.addSubview(textView)
        self.view.addSubview(sureBtn)
        let lineView = UIView()
        textView.addSubview(setPwdLabel)
        textView.addSubview(setPwdText)
        textView.addSubview(surePwdLabel)
        textView.addSubview(surePwdText)
        textView.addSubview(lineView)
        imageV.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        imageV.image = UIImage(named: "R3")
        imageV.contentMode = .ScaleAspectFit
        
        textView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(imageV.snp_bottom)
            make.height.equalTo(88)
        }
        textView.backgroundColor = UIColor.whiteColor()
        
        setPwdLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(2)
            make.top.equalTo(0).offset(5)
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
        setPwdLabel.text = "设置密码："
        setPwdLabel.font = UIFont.systemFontOfSize(13)
        
        setPwdText.snp_makeConstraints { (make) in
            make.left.equalTo(setPwdLabel.snp_right).offset(2)
            make.right.equalTo(0)
            make.top.equalTo(0).offset(5)
            make.height.equalTo(35)
        }
        setPwdText.tag = 100
        setPwdText.addTarget(self, action: #selector(LookPwdVC_Three.getPwdText(_:)), forControlEvents: UIControlEvents.AllEvents)
        setPwdText.placeholder = "请输入新密码"
        setPwdText.secureTextEntry = true
        
        lineView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(setPwdLabel.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        lineView.backgroundColor = UIColor.grayColor()
        
        surePwdLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(2)
            make.top.equalTo(lineView.snp_bottom).offset(5)
            make.height.equalTo(35)
            make.width.equalTo(70)
        }
        
        surePwdLabel.text = "确认密码："
        surePwdLabel.font = UIFont.systemFontOfSize(13)
        
        surePwdText.snp_makeConstraints { (make) in
            make.left.equalTo(surePwdLabel.snp_right).offset(2)
            make.right.equalTo(0)
            make.top.equalTo(lineView.snp_bottom).offset(5)
            make.height.equalTo(35)
        }
        surePwdText.tag == 200
        surePwdText.addTarget(self, action: #selector(LookPwdVC_Three.getPwdText(_:)), forControlEvents: UIControlEvents.AllEvents)
        surePwdText.placeholder = "请确认新密码"
        surePwdText.secureTextEntry = true
        
        sureBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(5)
            make.top.equalTo(textView.snp_bottom).offset(10)
            make.right.equalTo(0).offset(-5)
            make.height.equalTo(35)
        }
        
        sureBtn.setTitle("确认修改", forState: UIControlState.Normal)
        sureBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        sureBtn.backgroundColor = UIColor.grayColor()
        sureBtn.addTarget(self, action: #selector(LookPwdVC_Three.confirmCommitSetPwd), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    internal func getPwdText(text:UITextField){
        if text.tag == 100 {
            self.setPwdText.text = text.text!
        }
        if text.tag == 200 {
            self.surePwdText.text = text.text!
        }
    }
    
    internal func confirmCommitSetPwd(){
        if (self.setPwdText.text == self.surePwdText.text) {
            
            if onlineState {
                
                requestGetPhoneNumberClassifyCode(self.phoneText, password: self.setPwdText.text!)
                
            }else{
                let msg = "无网络连接"
                self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                self.view.dodo.style.bar.locationTop = false
                self.view.dodo.warning(msg)
            }
            
            
        }else{
            let msg = "两次密码不匹配！"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.error(msg)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension LookPwdVC_Three {
    func requestGetPhoneNumberClassifyCode(phone:String,password:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        //let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        //HUD.mode = MBProgressHUDMode.Indeterminate
        
        //HUD.label.text = "重置密码中,请稍等！"
        //HUD.hideAnimated(true, afterDelay: 1)
        //HUD.showAnimated(true)
        
        
        let url = serverUrl + "/merchant/resetpwd"
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
                    
                    if (dict!["code"] as! Int == 0){
                        
                        let HUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                        
                        HUD.mode = MBProgressHUDMode.Indeterminate
                        HUD.hideAnimated(true)
                        HUD.label.text = "重置密码成功！"
                        
                        HUD.hideAnimated(true, afterDelay: 3)
                        
                        
                        
//                        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
//                        self.view.dodo.style.bar.locationTop = false
//                        self.view.dodo.success("重置密码成功")
                        sleep(3)
                        self.dismissViewControllerAnimated(true, completion: { 
                            
                        })
                        
                    }else{
                        let HUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                        
                        HUD.mode = MBProgressHUDMode.Indeterminate
                        HUD.hideAnimated(true)
                        HUD.label.text = "重置密码失败！"
                        
                        HUD.hideAnimated(true, afterDelay: 3)
                        
//                        let msg = "重置密码失败！"
//                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
//                        self.view.dodo.style.bar.locationTop = false
//                        self.view.dodo.error(msg)
                    }
                    
                case .Failure(let error):
                    print(error)
                    let msg = "重置密码失败！"
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.error(msg)
                }
        }
        
    }
}
