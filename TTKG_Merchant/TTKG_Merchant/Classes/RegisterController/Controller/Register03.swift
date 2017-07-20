//
//  Register03.swift
//  TTKG_Custmer
//
//  Created by yd on 16/6/16.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class Register03: UIViewController {
    
    var registerModel :RegisterModel!
    
    
    var phoneNums = ""
    var address = ""
    var areaID = Int()
    
    @IBOutlet var TuiJianCodeText: UITextField!
    @IBOutlet var DetailAddressText: UITextField!
    
    @IBOutlet var AddressLabel: UILabel!
    
    @IBOutlet var SetPassWord: UITextField!

    @IBOutlet var OnceAgainSetPwd: UITextField!
    
    @IBOutlet var ConfirmBtn: UIButton!
    
    @IBAction func ConfirmBtnClick(sender: AnyObject) {
        
        if CheckDataTools.checkForNumbberAndStringWithLength("6", longLongth: "16", string: SetPassWord.text!){
            if CheckDataTools.checkForNumbberAndStringWithLength("6", longLongth: "16", string: OnceAgainSetPwd.text!){
                
                if SetPassWord.text == OnceAgainSetPwd.text {
                    
                    if onlineState {
                        
                        requetForRegister(self.phoneNums, pwd: self.SetPassWord.text!, areaid: areaID, address: address + self.DetailAddressText.text!, orangekey: self.TuiJianCodeText.text!)
                        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "注册"
        
        setNavBar()
        self.AddressLabel.text = address
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        SetPassWord.addTarget(self, action: #selector(Register03.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        SetPassWord.tag = 100
        OnceAgainSetPwd.addTarget(self, action: #selector(Register03.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        OnceAgainSetPwd.tag = 200
        
        DetailAddressText.addTarget(self, action: #selector(Register03.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        DetailAddressText.tag = 500
        
        TuiJianCodeText.addTarget(self, action: #selector(Register03.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        TuiJianCodeText.tag = 600
        
        
    }

    func setNavBar(){
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(Register03.backUpController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    func backUpController(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func textFieldDidChange(text:UITextField){
        
        
        if text.tag == 100 {
            self.SetPassWord.text = text.text
        }
        
        if text.tag == 200 {
            self.OnceAgainSetPwd.text = text.text
        }
        
        if text.tag == 500 {
            self.DetailAddressText.text = text.text
        }
        
        if text.tag == 600 {
            self.TuiJianCodeText.text = text.text
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
// MARK: - 注册
extension Register03 {
    func requetForRegister(phone:String,pwd:String,areaid:Int,address:String,orangekey:String)  {
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.show("注册中")
        
        let url =  serverUrl + "/merchant/register"
        let parameters = ["phone":phone,"pwd":pwd,"areaid":areaid,"address":address,"orangekey":orangekey]
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    }catch _ {
                        dict = nil
                    }
                    
                    self.registerModel = RegisterModel.init(fromDictionary: dict!)
                    
                    let message = self.registerModel.msg
                    if (self.registerModel.code == 0) {
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.success(message)
                        
                        self.dismissViewControllerAnimated(true, completion: { 
                            
                        })
                        
                    }else{
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.error(message)
                    }
                    
                    
                case .Failure(let error):
                    print(error)
                }
        }
    }
}


