//
//  Register_Two.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/31.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class Register_Two: UIViewController {
    var phoneNum = ""
    var backImage = UIImageView()      //返回箭头
    var textInputView = UIView()       //输入框
    var textStrLabel = UILabel()
    var phoneText = UITextField()
    var againBtn = UIButton()          //重新获取按钮
    var timeLabel = UILabel()          //倒计时
    var selectAddressBtn = UIButton()  //选择区域按钮
    var nextBtn = UIButton()           //提交验证码按钮
    
    var verifyModel : VerifyCodeRootClass!
    var areaModel : ListProvinceModel!
    var addressTemp = ""
    var areaIDTemp = Int()
    
    
    var timers = NSTimer()
    var myTimer : NSTimer!
    var Countdown = 10             //倒计时时间
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Register_Two.selectAddressProcess(_:)), name: "selectAddress", object: nil)
        self.edgesForExtendedLayout = .None
        self.view.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1.0)
        
        //加载控件
        createUI()
        setNavBar()
        textStrLabel.text = "短信验证码已经发送到手机\(phoneNum)"
        myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Register02.reduceMyClock), userInfo: nil, repeats: true)
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
    
    //MARK:Getter
    func setNavBar(){
        
        self.title = "注册"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 50/255, green: 133/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(Register_Two.backUpController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
    }
    func createUI(){
        
        //返回箭头
        self.view.addSubview(backImage)
        backImage.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(42)
        }
        backImage.image = UIImage(named: "R2")
        
        //
        self.view.addSubview(textStrLabel)
        textStrLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(backImage.snp_bottom)
            make.height.equalTo(15)
        }
        textStrLabel.text = "验证码已经发送到你的手机上了"
        textStrLabel.font = UIFont.systemFontOfSize(12)
        
        //输入框背景
        self.view.addSubview(textInputView)
        textInputView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(textStrLabel.snp_bottom)
            make.height.equalTo(42)
        }
        textInputView.backgroundColor = UIColor.whiteColor()
        
        //Label
        let phoneLabel = UILabel()
        textInputView.addSubview(phoneLabel)
        phoneLabel.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(64)
        }
        phoneLabel.text = "验证码:"
        
        //重新获取验证码按钮
        textInputView.addSubview(againBtn)
        againBtn.snp_makeConstraints { (make) in
            make.right.top.bottom.equalTo(0)
            make.width.equalTo(60)
        }
        againBtn.setTitle("重新获取", forState: UIControlState.Normal)
        againBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
        againBtn.titleLabel?.textAlignment = .Left
        againBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        againBtn.addTarget(self, action: #selector(Register_Two.onecAgainVerifyCode), forControlEvents: UIControlEvents.TouchUpInside)
        
        //倒计时
        textInputView.addSubview(timeLabel)
        timeLabel.snp_makeConstraints { (make) in
            make.right.equalTo(againBtn.snp_left)
            make.top.bottom.equalTo(0)
            make.width.equalTo(30)
        }
        timeLabel.text = "(10)"
        timeLabel.font = UIFont.systemFontOfSize(12)
        
        //验证码输入框
        textInputView.addSubview(phoneText)
        phoneText.snp_makeConstraints { (make) in
            make.left.equalTo(phoneLabel.snp_right).offset(1)
            make.top.bottom.equalTo(0)
            make.right.equalTo(timeLabel.snp_left)
        }
        phoneText.placeholder = "请输入验证码"
        phoneText.clearButtonMode = .WhileEditing
        phoneText.addTarget(self, action: #selector(Register_Two.getPhoneText(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        //选择区域
        self.view.addSubview(selectAddressBtn)
        selectAddressBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.top.equalTo(textInputView.snp_bottom).offset(30)
            make.height.equalTo(35)
        }
        
        selectAddressBtn.setTitle("选择店铺所在区域", forState: UIControlState.Normal)
        selectAddressBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        selectAddressBtn.backgroundColor = UIColor.whiteColor()
        selectAddressBtn.addTarget(self, action: #selector(Register_Two.selectAddress), forControlEvents: UIControlEvents.TouchUpInside)
        
        //提交验证码按钮
        self.view.addSubview(nextBtn)
        nextBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.top.equalTo(selectAddressBtn.snp_bottom).offset(30)
            make.height.equalTo(30)
        }
        
        nextBtn.setTitle("提交验证码", forState: UIControlState.Normal)
        nextBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        nextBtn.backgroundColor = UIColor.grayColor()
        nextBtn.addTarget(self, action: #selector(Register_Two.comfirmVerifyCode), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func backUpController(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:Event Response
    func onecAgainVerifyCode(){
        self.Countdown = 10
        
        timers = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Register_Two.reduceMyClock), userInfo: nil, repeats: true)
        timers.fire()
    }
    
    func selectAddress(){
        let selectArea01VC = SelectAreaOneVC()
        selectArea01VC.areaData = self.areaModel.data
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: selectArea01VC)
        
        self.presentViewController(nvc1, animated: false) { () -> Void in
            
        }
    }
    
    func getPhoneText(textStr:UITextField){
        self.phoneText.text = textStr.text
    }
    
    func reduceMyClock(){
        againBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        if Countdown > 0 {
            Countdown -= 1
            timeLabel.text = "(\(Countdown))"
            againBtn.userInteractionEnabled = false
            nextBtn.userInteractionEnabled = true
        }else{
            myTimer.invalidate()
            timers.invalidate()
            timeLabel.text = ""
            againBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            againBtn.userInteractionEnabled = true
            nextBtn.userInteractionEnabled = true
        }
    }
    
    
    func comfirmVerifyCode(){
        if  self.verifyModel.data.vcode ==  phoneText.text! {
            let register03 = Register_Three()
            register03.address = self.addressTemp
            register03.phoneNums = self.phoneNum
            register03.areaID = self.areaIDTemp
            self.navigationController?.pushViewController(register03, animated: true)
        
        }else{
            let alert = UIAlertView(title: "提示", message: "请输入正确的验证码", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
          }
    
    func selectAddressProcess(notice:NSNotification)  {
        let address = notice.object!["address"] as? String
        let areaid = notice.object!["areaID"] as? Int
        
        selectAddressBtn.setTitle(address, forState: UIControlState.Normal)
        addressTemp = address!
        areaIDTemp = areaid!
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

//验证码请求接口
extension Register_Two {
    func RequestVerifyCode(mobile:String)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/merchant/code"
        let parameters = ["phone":mobile,"sign":MD5_time,"timespan":timeTemp.description]
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
                    NSLog("self.verifyModel= \(self.verifyModel.data.vcode)")
                case .Failure(let error):
                    print(error)
                }
        }
        
    }
    
    //地区请求接口
    func RequestAllAreaList(){
        let url = serverUrl + "/merchant/arealist"
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let parameters = ["sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.GET, url, parameters: parameters)
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
