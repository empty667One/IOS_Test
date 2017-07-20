//
//  Register02.swift
//  TTKG_Custmer
//
//  Created by yd on 16/6/15.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class Register02: UIViewController {
    
    private let http  = RegisterAPI.shareInstance
    var phoneNum = ""//手机号码
    var verifyModel : VerifyCodeRootClass!
    var areaModel : ListProvinceModel!
    var addressTemp = ""
    var areaIDTemp = Int()
    
    
    var timers = NSTimer()
    var myTimer : NSTimer!
    var Countdown = 10
    @IBAction func OnceAgainCodeBtn(sender: AnyObject) {
        self.Countdown = 10
        
        timers = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Register02.reduceMyClock), userInfo: nil, repeats: true)
        timers.fire()
        
        
    }
    @IBOutlet var SelectAreaBtn: UIButton!
    @IBOutlet var CommitCode: UIButton!
    @IBOutlet var OnceAgain: UIButton!
    @IBOutlet var VerificationCode: UITextField!
    @IBOutlet var MessageText: UILabel!
    
    @IBOutlet var textCode: UILabel!
    
    @IBAction func SelectAreaBtnClickBtn(sender: AnyObject) {
        
        let selectArea01VC = SelectAreaOneVC()
        selectArea01VC.areaData = self.areaModel.data
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: selectArea01VC)
        
        self.presentViewController(nvc1, animated: false) { () -> Void in
            
        }
        
        
        
    }
    
    @IBAction func CommitCodeBtn(sender: AnyObject) {
        
        if  self.verifyModel.data.vcode ==  VerificationCode.text! {
            let register03 = Register03()
            register03.address = self.addressTemp
            register03.phoneNums = self.phoneNum
            register03.areaID = self.areaIDTemp
            self.navigationController?.pushViewController(register03, animated: true)
            
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入正确的验证码", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Register02.selectAddressProcess(_:)), name: "selectAddress", object: nil)
        self.edgesForExtendedLayout = UIRectEdge.None
        MessageText.text = "短信验证码已经发送到手机\(phoneNum)"
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Register02.reduceMyClock), userInfo: nil, repeats: true)
//        VerificationCode.addTarget(self, action: #selector(Register02.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
//        myTimer.invalidate()
        if onlineState {
            
            myTimer.fire()
            RequestVerifyCode(self.phoneNum)
            RequestAllAreaList()
            
        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
    }
    
    func setNavBar(){
        
        self.title = "注册"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(Register02.backUpController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    
    
    func reduceMyClock(){
        OnceAgain.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        if Countdown > 0 {
            Countdown -= 1
            textCode.text = "(\(Countdown))"
            OnceAgain.userInteractionEnabled = false
            CommitCode.userInteractionEnabled = true
        }else{
            myTimer.invalidate()
            timers.invalidate()
            textCode.text = ""
            OnceAgain.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            OnceAgain.userInteractionEnabled = true
            CommitCode.userInteractionEnabled = true
        }
    }
    
    func backUpController(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    func selectAddressProcess(notice:NSNotification)  {
        let address = notice.object!["address"] as? String
        let areaid = notice.object!["areaID"] as? Int
        
        SelectAreaBtn.setTitle(address, forState: UIControlState.Normal)
        addressTemp = address!
        areaIDTemp = areaid!
    }

    override func viewWillAppear(animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension Register02 {
    func RequestVerifyCode(mobile:String)  {
        let url = serverUrl + "/merchant/code"
        let parameters = ["phone":mobile]
        Alamofire.request(.POST, url,parameters: parameters)
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
                    self.verifyModel = VerifyCodeRootClass.init(fromDictionary: dict!)
                    
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    
    func RequestAllAreaList(){
        let url = serverUrl + "/merchant/arealist"
        
        Alamofire.request(.GET, url, parameters: nil)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    }catch _ {
                        dict = nil
                    }
                    self.areaModel = ListProvinceModel.init(fromDictionary: dict!)
                    
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    
    
    
}


