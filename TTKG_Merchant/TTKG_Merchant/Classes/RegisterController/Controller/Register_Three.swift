//
//  Register_Three.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/31.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
class Register_Three: UIViewController {
    var registerModel :RegisterModel!
    let topImageView = UIImageView()
    var address = ""
    var phoneNums = ""
    var areaID = Int()
    let contentView1 = UIView()
    let setCode = UILabel()
    let textFiled1 = UITextField()
    
    let contentView2 = UIView()
    let sureCode = UILabel()
    let textFiled2 = UITextField()
    
    
    let countryLabel = UILabel()
    
    let addressLabel = UILabel()
    let detailAddress = UITextField()
    
    let tuiJianLabel = UILabel()
    let tuiJianCode = UITextField()
    
    let sureBtn = UIButton()
    func setNavBar(){
        
        self.title = "注册"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(Register_Three.backUpController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    func backUpController(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.view.backgroundColor = UIColor(red: 238 / 255, green: 239 / 255, blue: 241 / 255, alpha: 1)
        
        //背景图
        self.view.addSubview(topImageView)
        topImageView.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(0)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(48)
        }
         topImageView.image = UIImage(named:"R3" )
    
        /*****************************************************************/
        contentView1.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(contentView1)
        contentView1.snp_makeConstraints { (make) in
            make.top.equalTo(topImageView.snp_bottom).offset(1)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(40)
        }
        
        //设置密码label
        setCode.text = "设置密码:"
        setCode.font = UIFont.systemFontOfSize(14)
        self.contentView1.addSubview(setCode)
        setCode.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(8)
            make.left.equalTo(0).offset(8)
            make.width.equalTo(70)
            make.height.equalTo(21)
        }
        
        //密码输入框
        textFiled1.backgroundColor = UIColor.whiteColor()
        self.contentView1.addSubview(textFiled1)
        textFiled1.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(4)
            make.left.equalTo(setCode.snp_right).offset(8)
            make.right.equalTo(0).offset(-8)
            make.height.equalTo(30)
        }
        textFiled1.secureTextEntry = true
        textFiled1.placeholder = "请输入密码"
        textFiled1.tag = 100
        textFiled1.addTarget(self, action: #selector(Register_Three.getTextStr(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        //确认密码label
        sureCode.text = "确认密码:"
        sureCode.font = UIFont.systemFontOfSize(14)
        self.contentView2.addSubview(sureCode)
        sureCode.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(8)
            make.left.equalTo(0).offset(8)
            make.width.equalTo(70)
            make.height.equalTo(21)
        }

        //确认密码输入框
        textFiled2.backgroundColor = UIColor.whiteColor()
        self.contentView2.addSubview(textFiled2)
        textFiled2.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(4)
            make.left.equalTo(sureCode.snp_right).offset(8)
            make.right.equalTo(0).offset(-8)
            make.height.equalTo(30)
        }
        textFiled2.secureTextEntry = true
        textFiled2.placeholder = "再次输入密码"
        textFiled2.tag = 100
        textFiled2.addTarget(self, action: #selector(Register_Three.getTextStr(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        contentView2.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(contentView2)
        contentView2.snp_makeConstraints { (make) in
            make.top.equalTo(contentView1.snp_bottom).offset(1)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(40)
        }
        
        countryLabel.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(countryLabel)
        countryLabel.snp_makeConstraints { (make) in
            make.top.equalTo(contentView2.snp_bottom).offset(14)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(32)
        }
        countryLabel.text = self.address
        
        /**********************************************************/
        addressLabel.text = "详细地址"
        addressLabel.textAlignment = .Center
        addressLabel.backgroundColor = UIColor.whiteColor()
        addressLabel.font = UIFont.systemFontOfSize(14)
        self.view.addSubview(addressLabel)
        addressLabel.snp_makeConstraints { (make) in
            make.top.equalTo(countryLabel.snp_bottom).offset(16)
            make.left.equalTo(0).offset(0)
            make.width.equalTo(68)
            make.height.equalTo(30)
        }
        
        /***********************************************************/
        detailAddress.placeholder = "可选"
        detailAddress.tag = 300
        detailAddress.addTarget(self, action: #selector(Register_Three.getTextStr(_:)), forControlEvents: UIControlEvents.EditingChanged)
        detailAddress.backgroundColor = UIColor.whiteColor()
        detailAddress.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(detailAddress)
        detailAddress.snp_makeConstraints { (make) in
            make.top.equalTo(countryLabel.snp_bottom).offset(16)
            make.left.equalTo(addressLabel.snp_right).offset(0)
            make.right.equalTo(0).offset(-5)
            make.height.equalTo(30)
        }

        /*************************************************************/
        tuiJianLabel.text = "推荐码"
        tuiJianLabel.textAlignment = .Center
        tuiJianLabel.backgroundColor = UIColor.whiteColor()
        tuiJianLabel.font = UIFont.systemFontOfSize(14)
        self.view.addSubview(tuiJianLabel)
        tuiJianLabel.snp_makeConstraints { (make) in
            make.top.equalTo(addressLabel.snp_bottom).offset(16)
            make.left.equalTo(0).offset(0)
            make.width.equalTo(68)
            make.height.equalTo(30)
        }

        tuiJianCode.placeholder = "可选"
        tuiJianCode.backgroundColor = UIColor.whiteColor()
        tuiJianCode.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(tuiJianCode)
        tuiJianCode.snp_makeConstraints { (make) in
            make.top.equalTo(detailAddress.snp_bottom).offset(16)
            make.left.equalTo(tuiJianLabel.snp_right).offset(0)
            make.right.equalTo(0).offset(-5)
            make.height.equalTo(30)
        }
        tuiJianCode.tag = 400
        tuiJianCode.addTarget(self, action: #selector(Register_Three.getTextStr(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        /**
         
         确定按钮
         
        **/
        sureBtn.setTitle("确定", forState: UIControlState.Normal)
        sureBtn.backgroundColor = UIColor(red: 199 / 255, green: 201 / 255, blue: 202 / 255, alpha: 1)
        sureBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.view.addSubview(sureBtn)
        sureBtn.snp_makeConstraints { (make) in
            make.top.equalTo(tuiJianCode.snp_bottom).offset(38)
            make.left.equalTo(0).offset(8)
            make.right.equalTo(0).offset(-8)
            make.height.equalTo(40)
        }
        sureBtn.addTarget(self, action: #selector(Register_Three.commitRegisterInfo(_:)), forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    //MARK:Event Response
    func getTextStr(textStr:UITextField){
        if textStr.tag == 100 {
            self.textFiled1.text = textStr.text
        }
        if textStr.tag == 200 {
            self.textFiled2.text = textStr.text
        }
        if textStr.tag == 300 {
            self.detailAddress.text = textStr.text
        }
        if textStr.tag == 400 {
            self.tuiJianCode.text = textStr.text
        }
    }
    
    
    func commitRegisterInfo(sender:UIButton){
        if CheckDataTools.checkForNumbberAndStringWithLength("6", longLongth: "16", string: self.textFiled1.text!){
            if CheckDataTools.checkForNumbberAndStringWithLength("6", longLongth: "16", string: self.textFiled2.text!){
                
                if (self.textFiled1.text) == (textFiled2.text) {
                    
                    if onlineState {
                        
                        requetForRegister(self.phoneNums, pwd: self.textFiled1.text!, areaid: areaID, address: address + self.detailAddress.text!, orangekey: self.tuiJianCode.text!)
                        
                    }else{
                        let msg = "无网络连接"
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.warning(msg)
                    }
                    
                }else{
                    let alert = UIAlertView(title: "提示", message: "两次输入的密码不一致，请重新输入", delegate: nil, cancelButtonTitle: "确定")
                    alert.show()
                }
                
            }else{
                let alert = UIAlertView(title: "提示", message: "密码不能低于六位", delegate: nil, cancelButtonTitle: "确定")
                alert.show()
            }
        }else{
            let alert = UIAlertView(title: "提示", message: "密码不能低于六位", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }

    }
    
}


extension Register_Three {
    func requetForRegister(phone:String,pwd:String,areaid:Int,address:String,orangekey:String)  {
        //self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        //self.view.dodo.style.bar.locationTop = false
        //self.view.dodo.show("注册中")
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        
        let url =  serverUrl + "/merchant/register"
        let parameters = ["phone":phone,"pwd":pwd,"areaid":areaid,"address":address,"orangekey":orangekey,"sign":MD5_time,"timespan":timeTemp.description]
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.registerModel = RegisterModel.init(fromDictionary: dict!)
                        
                        let message = self.registerModel.msg
                        if (self.registerModel.code == 0) {
                            
                            //self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                            self.view.dodo.style.bar.locationTop = false
                            
                            self.view.dodo.style.leftButton.image = UIImage(named: "disMissBtnIcon")
                            self.view.dodo.style.leftButton.hideOnTap = true
                            self.view.dodo.style.leftButton.tintColor = DodoColor.fromHexString("#FFFFFF")
                            self.view.dodo.style.leftButton.onTap = {
                                self.dismissViewControllerAnimated(true, completion: {
                                    
                                })
                            }
                            self.view.dodo.success("点击左边去登录")
                            
                            
                        }else{
                            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                            self.view.dodo.style.bar.locationTop = false
                            self.view.dodo.error(message)
                        }
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    
                    
                    
                case .Failure(let error):
                    print(error)
                }
        }
    }
}




