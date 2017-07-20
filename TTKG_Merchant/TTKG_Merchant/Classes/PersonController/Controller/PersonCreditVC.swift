//
//  PersonCreditVC.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/23.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class PersonCreditVC: UIViewController {

    var CreditInfoModel : creditInfoModel!
    var CreditInfoData : creditInfoData!
    
    let creditView = UIView()
    
    let verticalView = UIView()
    
    let seperateView = UIView()
    
    //爽够额度
    let creditLabel = UILabel()
    
    //总额度
    let totallabel = UILabel()
    var totalCredit = UILabel()

    
    //可用额度
    let amountLabel = UILabel()
    var creditamount = UILabel()

    
    //已使用额度
    let alreadyLabel = UILabel()
    var alreadyCredit = UILabel()
    
    //剩余额度
    let availabel = UILabel()
    var creditavailable = UILabel()

    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if onlineState {
            requestInfo(userInfo_Global.keyid)
        }else
        {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
    }
    
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.translucent = false
        self.title = "我的爽够"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        creditView.backgroundColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.view.addSubview(creditView)
        creditView.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(0)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(150)
        }
        
        creditLabel.text = "爽够额度"
        creditLabel.font = UIFont.systemFontOfSize(20)
        creditLabel.textAlignment = NSTextAlignment.Center
        creditLabel.textColor = UIColor.whiteColor()
        self.creditView.addSubview(creditLabel)
        creditLabel.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(35)
            make.centerX.equalTo(0).offset(0)
            make.width.equalTo(100)
           
        }
        
        totallabel.text = "总额度(元)"
        totallabel.font = UIFont.systemFontOfSize(17)
        totallabel.textColor = UIColor.whiteColor()
        self.creditView.addSubview(totallabel)
        totallabel.snp_makeConstraints { (make) in
            make.top.equalTo(creditLabel.snp_bottom).offset(15)
            make.left.equalTo(0).offset(45)
            
        }
        
        //总额度
        totalCredit.text = "¥0.00"
        totalCredit.font = UIFont.systemFontOfSize(17)
        totalCredit.textColor = UIColor.whiteColor()
        self.creditView.addSubview(totalCredit)
        totalCredit.snp_makeConstraints { (make) in
            make.centerX.equalTo(totallabel.snp_centerX).offset(0)
            make.top.equalTo(totallabel.snp_bottom).offset(8)
            
        }

        amountLabel.text = "授信额度(元)"
        amountLabel.font = UIFont.systemFontOfSize(17)
        amountLabel.textColor = UIColor.whiteColor()
        self.creditView.addSubview(amountLabel)
        amountLabel.snp_makeConstraints { (make) in
            make.top.equalTo(creditLabel.snp_bottom).offset(15)
            make.right.equalTo(0).offset(-40)
            
        }
        
        //可用额度
        creditamount.text = "¥0.00"
        creditamount.font = UIFont.systemFontOfSize(17)
        creditamount.textColor = UIColor.whiteColor()
        self.creditView.addSubview(creditamount)
        creditamount.snp_makeConstraints { (make) in
            make.centerX.equalTo(amountLabel.snp_centerX).offset(0)
            make.top.equalTo(amountLabel.snp_bottom).offset(8)
        }
        
        //分割竖线
        verticalView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(verticalView)
        verticalView.snp_makeConstraints { (make) in
            make.centerX.equalTo(creditView.snp_centerX).offset(0)
            make.top.equalTo(creditView.snp_bottom).offset(16)
            make.height.equalTo(60)
            make.width.equalTo(2)
        }
        
        //分割横线
        seperateView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(seperateView)
        seperateView.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.top.equalTo(verticalView.snp_bottom).offset(16)
            make.height.equalTo(1)

        }
        
        //剩余使用额度
        availabel.text = "剩余额度(元)"
        availabel.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(availabel)
        availabel.snp_makeConstraints { (make) in
            make.top.equalTo(creditView.snp_bottom).offset(25)
            make.centerX.equalTo(amountLabel.snp_centerX).offset(0)

        }
        creditavailable.text = "¥0.00"
        creditavailable.textColor = UIColor.redColor()
        creditavailable.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(creditavailable)
        creditavailable.snp_makeConstraints { (make) in
            make.top.equalTo(availabel.snp_bottom).offset(8)
            make.centerX.equalTo(amountLabel.snp_centerX).offset(0)
            
        }
        
        //已使用额度
        alreadyLabel.text = "已使用额度(元)"
        alreadyLabel.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(alreadyLabel)
        alreadyLabel.snp_makeConstraints { (make) in
            make.top.equalTo(creditView.snp_bottom).offset(25)
            make.centerX.equalTo(totallabel.snp_centerX).offset(0)
            
        }
        alreadyCredit.text = "¥0.00"
        alreadyCredit.textColor = UIColor.redColor()
        alreadyCredit.font = UIFont.systemFontOfSize(16)
        self.view.addSubview(alreadyCredit)
        alreadyCredit.snp_makeConstraints { (make) in
            make.top.equalTo(alreadyLabel.snp_bottom).offset(8)
            make.centerX.equalTo(totallabel.snp_centerX).offset(0)
            
        }

    }
}

extension PersonCreditVC{
    
    func requestInfo(userid:Int) {
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        
        let parameters = ["userid":userid,"usertype":1,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/merchant/creditstate"
        Alamofire.request(.GET, url, parameters:parameters as? [String : AnyObject] )
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        
                        if dict!["code"] as! Int == 0{
                            
                            self.CreditInfoModel = creditInfoModel(fromDictionary: dict!)
                            self.CreditInfoData = self.CreditInfoModel.data
                            self.totalCredit.text = String(format: "¥%.2f", self.CreditInfoData.totalloan)
                            self.creditavailable.text = String(format: "¥%.2f", self.CreditInfoData.creditavailable)
                            self.creditamount.text = String(format: "¥%.2f", self.CreditInfoData.creditamount)
                            self.alreadyCredit.text = String(format: "¥%.2f", self.CreditInfoData.creditamount - self.CreditInfoData.creditavailable)
                            
                        }else
                        {
                            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                            self.view.dodo.style.bar.locationTop = false
                            self.view.dodo.warning(dict!["msg"] as! String)
                        }
                        
                    }catch _ {
                        let msg = "无网络连接"
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.warning(msg)
                    }
     
                    
                case .Failure(let error):
                    let msg = "无网络连接"
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.warning(msg)
                }
                
        }
        
    }

}
