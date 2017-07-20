//
//  LookPwdVC_One.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/22.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
class LookPwdVC_One: UIViewController {

    var imageV = UIImageView()     //顶端图片
    var textView = UIView()        //输入框背景图
    var phoneLabel = UILabel()     //手机号Label
    var phoneText = UITextField()  //输入框
    var nextBtn = UIButton()       //下一步按钮
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "找回密码"
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor(red: 237/255, green: 239/255, blue: 247/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(LookPwdVC_One.backUpController))
        
        createUI()
        
    }
    
    internal func backUpController(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    //MARK:加载控件
    func createUI(){
        self.view.addSubview(imageV)
        self.view.addSubview(textView)
        self.view.addSubview(nextBtn)
        textView.addSubview(phoneLabel)
        textView.addSubview(phoneText)
        
        ////顶端图片
        imageV.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        imageV.image = UIImage(named: "R1")
        imageV.contentMode = .ScaleAspectFit
        
        //输入框背景图
        textView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(imageV.snp_bottom).offset(10)
            make.height.equalTo(44)
        }
        textView.backgroundColor = UIColor.whiteColor()
        
        //下一步按钮
        nextBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(4)
            make.right.equalTo(0).offset(-4)
            make.top.equalTo(textView.snp_bottom).offset(10)
            make.height.equalTo(30)
        }
        nextBtn.setTitle("下一步", forState: UIControlState.Normal)
        nextBtn.backgroundColor = UIColor.grayColor()
        nextBtn.addTarget(self, action: #selector(LookPwdVC_One.nextOneController), forControlEvents: UIControlEvents.TouchUpInside)
        
        //手机号label
        phoneLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(5)
            make.top.equalTo(0).offset(7)
            make.width.equalTo(64)
            make.height.equalTo(30)
        }
        phoneLabel.text = "手机号："
        phoneLabel.font = UIFont.systemFontOfSize(14)
        
        //手机号输入框
        phoneText.snp_makeConstraints { (make) in
            make.left.equalTo(phoneLabel.snp_right).offset(1)
            make.top.equalTo(0).offset(7)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        phoneText.placeholder = "请输入手机号码"
        phoneText.addTarget(self, action: #selector(LookPwdVC_One.getPhoneText(_:)), forControlEvents: UIControlEvents.AllEvents)
        
        
        
    }
    
    //MARK:Event Response
    func nextOneController() {
       
        if onlineState {
            
            requestCheckPhoneNumberExsit(self.phoneText.text!)
            
        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
    }
    
    
    func getPhoneText(text:UITextField){
        
        if CheckDataTools.checkForMobilePhoneNumber(text.text!){
            
            self.phoneText.text = text.text
            self.nextBtn.backgroundColor = UIColor.greenColor()
            self.nextBtn.userInteractionEnabled = true
            
        }else{
            
            self.nextBtn.backgroundColor = UIColor.grayColor()
            self.nextBtn.userInteractionEnabled = false
        }
    }

}

//MARK:LoadData
extension LookPwdVC_One {
    func requestCheckPhoneNumberExsit(phone:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/merchant/checkphone"
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
                    
                    if (dict!["code"] as! Int == 1){
                        let nextControllerVC = LookPwdVC_Two()
                        nextControllerVC.phoneText = phone
                        self.navigationController?.pushViewController(nextControllerVC, animated: true)
                    }else{
                        let msg = "不存在该账号~！"
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

