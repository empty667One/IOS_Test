//
//  PersonModifyAddressVC.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/16.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class PersonModifyAddressVC: UIViewController {

    var tableView : UITableView!
    
    let saveBtn = UIButton()
    
    var name = String()
    var tel = String()
    var address = String()
    var addressid = Int()
    var country = String()
    var code = String()
    var sparetel = String()
    
    var noticeAddress = String()
    
    var areaModel : ListProvinceModel!
    var areaData = [ListData]()
   
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    
    override func viewDidLoad() {
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
        creatUI()
        
        self.navigationItem.title = "修改收货地址"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PersonModifyAddressVC.selectAddressProcess(_:)), name: "selectAddress", object: nil)
        
        RequestAllAreaList()
    }
    
    func creatUI() {
        
        tableView = UITableView(frame: CGRectMake(0, 0, screenWith, 240), style: .Plain)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.scrollEnabled = false
        tableView.rowHeight = 50
        
        self.view.addSubview(tableView)
        
        tableView.registerClass(PersonAddAddressCell.self, forCellReuseIdentifier: "add_cell")
        
        saveBtn.setTitle("保存", forState: UIControlState.Normal)
        saveBtn.addTarget(self, action: #selector(self.saveBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        saveBtn.backgroundColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        saveBtn.layer.cornerRadius = 5
        self.view.addSubview(saveBtn)
        saveBtn.snp_makeConstraints { (make) in
            make.top.equalTo(tableView.snp_bottom).offset(20)
            make.left.equalTo(0).offset(50)
            make.right.equalTo(0).offset(-50)
        }
    }
    
    func saveBtnClick()  {
        
        
        if onlineState{
            
            requestModifyAddress(userInfo_Global.keyid, name: name, addressid: addressid, phone: tel, address: address, country: country, code: code , sparetel: sparetel)
        }else{
            
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
        
        
          

    }
    
    //接受通知调用的方法
    func selectAddressProcess(notice:NSNotification)  {
        
        noticeAddress = (notice.object!["address"] as? String)!
        country = noticeAddress
        self.tableView.reloadData()
        
    }
}

extension PersonModifyAddressVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : PersonAddAddressCell = tableView.dequeueReusableCellWithIdentifier("add_cell") as! PersonAddAddressCell
        
        cell.textView.addTarget(self, action: #selector(PersonModifyAddressVC.didChangeText(_:)), forControlEvents: .EditingChanged)
        
        if indexPath.row == 0{
            cell.title.text = "收货人:"
            cell.textView.text = name
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 1 {
            cell.title.text = "手机号码:"
            cell.textView.text = tel
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 2 {
            cell.title.text = "所在地区:"
            cell.textView.text = country
            cell.textView.userInteractionEnabled = false
            cell.textView.tag = indexPath.row
            
            
        }
        if indexPath.row == 3 {
            cell.title.text = "详细地址:"
            cell.textView.text = address
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 4 {
            cell.title.text = "邮政编码:"
            cell.textView.text = code
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 5 {
            cell.title.text = "备用号码:"
            cell.textView.text = sparetel
            cell.textView.tag = indexPath.row
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func didChangeText(textField:UITextField) {
        if textField.tag == 0{
            name = textField.text!
        
        }
        if textField.tag == 1{
            tel = textField.text!
        }
        if textField.tag == 2{
            country = textField.text!
        }
        if textField.tag == 3{
            address = textField.text!
        }
        if textField.tag == 4{
            code  = textField.text!
        }
        if textField.tag == 5{
            sparetel = textField.text!
            
        }
        
    }

    //cell的点击
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            
            let selectArea01VC = SelectAreaOneVC()
            selectArea01VC.areaData = self.areaModel.data
            let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: selectArea01VC)
            
            self.presentViewController(nvc1, animated: false) { () -> Void in
                
            }
            
            
            
        }
    }

    
    
}

extension PersonModifyAddressVC{
    
    func requestModifyAddress(keyid:Int,name: String, addressid:Int ,phone:String, address:String, country: String, code: String, sparetel: String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let parameters = ["userid":keyid,"usertype":1,"addressid":addressid, "name":name , "phone":phone, "address":address, "country":country, "code":code, "sparetel":sparetel,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/address/update"
        
        Alamofire.request(.POST, url, parameters:parameters as? [String : AnyObject] )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        if dict!["code"] as! Int == 0{
                            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                            self.view.dodo.style.bar.locationTop = false
                            self.view.dodo.warning(dict!["msg"] as! String)
                            let time: NSTimeInterval = 0.5
                            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
                            dispatch_after(delay, dispatch_get_main_queue()) {
                                self.navigationController?.popViewControllerAnimated(false)
                            }
                            
                            
                            
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

    func RequestAllAreaList(){
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let para = ["sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/merchant/arealist"
        
        Alamofire.request(.GET, url, parameters: para)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.areaModel = ListProvinceModel.init(fromDictionary: dict!)
                        self.areaData = self.areaModel.data
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
