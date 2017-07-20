//
//  Register_One.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/30.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class Register_One: UIViewController {

    var backImage = UIImageView()
    var textInputView = UIView()      //输入框背景视图
    var phoneText = UITextField()     //手机号输入框
    var nextBtn = UIButton()          //下一步按钮
    
    
    func backUpController(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1.0)
        createUI()
        setNavBar()
    }
    
    func setNavBar(){
        
        self.title = "注册"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(Register_One.backUpController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
    }

    //MARK:加载控件
    func createUI(){
        self.view.addSubview(backImage)
        backImage.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(42)
        }
        backImage.image = UIImage(named: "R1")
        
        //输入框背景图
        self.view.addSubview(textInputView)
        textInputView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(backImage.snp_bottom)
            make.height.equalTo(42)
        }
        textInputView.backgroundColor = UIColor.whiteColor()
        
        //手机号Label
        let phoneLabel = UILabel()
        textInputView.addSubview(phoneLabel)
        phoneLabel.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(64)
        }
        phoneLabel.text = "手机号:"
        
        //手机号输入框
        textInputView.addSubview(phoneText)
        phoneText.snp_makeConstraints { (make) in
            make.left.equalTo(phoneLabel.snp_right).offset(1)
            make.top.right.bottom.equalTo(0)
        }
        phoneText.placeholder = "请输入手机号"
        phoneText.clearButtonMode = .WhileEditing
        phoneText.addTarget(self, action: #selector(Register_One.getPhoneText(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        //下一步按钮
        self.view.addSubview(nextBtn)
        nextBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(20)
            make.right.equalTo(0).offset(-20)
            make.top.equalTo(textInputView.snp_bottom).offset(20)
            make.height.equalTo(35)
        }
        
        nextBtn.setTitle("下一步", forState: UIControlState.Normal)
        nextBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        nextBtn.backgroundColor = UIColor(red: 156/255, green: 156/255, blue: 157/255, alpha: 1.0)
        nextBtn.addTarget(self, action: #selector(Register_One.clickNextBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    //MARK: Event Response
    func getPhoneText(textStr:UITextField){
        self.phoneText.text = textStr.text
        
        if CheckDataTools.checkForMobilePhoneNumber(textStr.text!){
            self.phoneText.text = textStr.text
            self.nextBtn.backgroundColor = UIColor.greenColor()
//                        self.NextBtn.userInteractionEnabled = true
        }else{
            self.nextBtn.backgroundColor = UIColor(red: 156/255, green: 156/255, blue: 157/255, alpha: 1.0)
            //            self.NextBtn.userInteractionEnabled = false
        }
    }
    
    func clickNextBtn(sender:UIButton){
        if CheckDataTools.checkForMobilePhoneNumber(self.phoneText.text!) {
            
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入正确的手机号", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        
        if onlineState {
            
            checkPhoneNumber(self.phoneText.text!)
            
        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }

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

}

extension Register_One {
    func checkPhoneNumber(tel:String)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/merchant/checkphone"
        let parameters = ["phone":tel,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.POST, url, parameters: parameters)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        let code = dict!["code"]! as? Int
                        let message = dict!["msg"]! as? String
                        
                        if code  == 1 {
                            let alert = UIAlertView(title: "提示", message: message, delegate: nil, cancelButtonTitle: "确定")
                            alert.show()
                        }else{
                            let register02 = Register_Two()
                            register02.phoneNum = self.phoneText.text!
                            self.navigationController?.pushViewController(register02, animated: true)
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
