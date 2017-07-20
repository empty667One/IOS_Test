//
//  Register01.swift
//  TTKG_Custmer
//
//  Created by yd on 16/6/15.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Register01: UIViewController{
    
    var  checkModel : VerifyCodeData!
    
    
    @IBOutlet var PhoneNum: UITextField!

    @IBOutlet var NextBtn: UIButton!
    
    
    @IBAction func NextStepBtnClick(sender: AnyObject) {
        
        if CheckDataTools.checkForMobilePhoneNumber(self.PhoneNum.text!) {
            
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入正确的手机号", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            return
        }
        
        
        if onlineState {
            
            checkPhoneNumber(self.PhoneNum.text!)
            
        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        
        PhoneNum.addTarget(self, action: #selector(Register01.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        self.edgesForExtendedLayout = UIRectEdge.None
    }

    
    func setNavBar(){
        
        self.title = "注册"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(Register01.backUpController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
    }
    
    func backUpController(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    
    
    func textFieldDidChange(text:UITextField){
        
        
        self.PhoneNum.text = text.text
        
        if CheckDataTools.checkForMobilePhoneNumber(text.text!){
            self.PhoneNum.text = text.text
            self.NextBtn.backgroundColor = UIColor.greenColor()
            //            self.NextBtn.userInteractionEnabled = true
        }else{
            self.NextBtn.backgroundColor = UIColor.grayColor()
            //            self.NextBtn.userInteractionEnabled = false
        }
        
        
        
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}


extension Register01 {
    
    func checkPhoneNumber(tel:String)  {
        let url = serverUrl + "/merchant/checkphone"
        let parameters = ["phone":tel]
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
                            let register02 = Register02()
                            register02.phoneNum = self.PhoneNum.text!
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

