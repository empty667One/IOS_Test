//
//  PersonDataVC.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/18.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class PersonDataVC: UIViewController {

    var tableView : UITableView!
    
    var modifyInfo :TLoginModel!
    
    var name = String()
    var tel = String()
    var shopname = String()
    var address = String()
    var sparetel = String()
    

    override func viewWillAppear(animated: Bool) {
        
        if onlineState{
            
            requestPersonData(userInfo_Global.loginid, password: userInfo_Global.password)
        }else{
            
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
 
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    
    override func viewDidLoad() {
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.view.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationItem.title = "个人资料"
        
        
        let btn = UIButton()
        btn.setTitle("保存", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(self.savePersonData), forControlEvents: UIControlEvents.TouchUpInside)
        btn.frame = CGRectMake(0, 0, 40, 20)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)//(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.savePersonData)
        
        creatUI()
    }
    
    func creatUI()  {
    
        tableView = UITableView(frame: CGRectMake(0, 0, screenWith, 350), style: .Plain)
        tableView.rowHeight = 50
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.scrollEnabled = false
        
        self.view.addSubview(tableView)
        
        tableView.registerClass(PersonAddAddressCell.self, forCellReuseIdentifier: "cell")


    }
}


extension PersonDataVC : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : PersonAddAddressCell = tableView.dequeueReusableCellWithIdentifier("cell") as! PersonAddAddressCell
        
        cell.textView.addTarget(self, action: #selector(PersonDataVC.didChangeText(_:)), forControlEvents: .EditingChanged)
        
        if indexPath.row == 0{
            cell.title.text = "帐    号:"
            cell.textView.text = userInfo_Global.loginid
            cell.textView.enabled = false
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 1 {
            cell.title.text = "店铺名称:"
            cell.textView.enabled = false
            cell.textView.text = shopname
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 2 {
            cell.title.text = "真实姓名:"
            cell.textView.text = name
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 3 {
            cell.title.text = "手机号码:"
            cell.textView.text = tel
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 4 {
            cell.title.text = "商铺地址:"
            cell.title.numberOfLines = 0
            cell.textView.text = address
            cell.textView.enabled = false
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 5 {
            cell.title.text = "备用号码:"
            cell.textView.text = sparetel
            cell.textView.tag = indexPath.row
        }
        if indexPath.row == 6 {
            cell.title.text = "修改密码:"
            cell.textView.enabled = false
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 6 {
            
            let modifyCodeVC = PersonModifyCodeVC()
            self.navigationController?.pushViewController(modifyCodeVC, animated: false)
            
        }
    }
    
    func didChangeText(textField:UITextField) {
        if textField.tag == 1{
            shopname = textField.text!
        }
        if textField.tag == 2{
            name = textField.text!
        }
        if textField.tag == 3{
            tel = textField.text!
        }
        if textField.tag == 4{
            address = textField.text!
        }
        if textField.tag == 5{
    
            sparetel = textField.text!
            
        }
        
    }

}


extension PersonDataVC{
    
    func savePersonData()  {
        
        if onlineState{
            
            requestModifyPersonData(userInfo_Global.keyid, name:name , shopname: shopname, tel: tel, address: address, sparetel: sparetel)
        }else{
            
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }

        
    }
    
    //请求修改个人信息
    func requestModifyPersonData(keyid:Int,name: String ,shopname :String, tel:String, address:String, sparetel: String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let parameters = ["userid":keyid, "name":name ,"shopname":shopname, "tel":tel, "address":address, "sparetel":sparetel,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/merchant/changeinfo"
        
        Alamofire.request(.POST, url, parameters:parameters as? [String : AnyObject] )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    
                    
                    if dict!["code"] as! Int == 0{
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.warning(dict!["msg"] as! String)
                        
                        self.navigationController?.popViewControllerAnimated(true)

                    }else
                    {
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.warning(dict!["msg"] as! String)
                    }
                    
                    
                case .Failure(let error): break
                
                }
                
        }
        
    }
    
    //请求个人信息
    func requestPersonData(phone:String, password:String) {
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        
        let parameters = ["phone":phone, "password":password,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/merchant/login"
        
        Alamofire.request(.POST, url, parameters:parameters  )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.modifyInfo = TLoginModel.init(fromDictionary: dict!)
                        if (self.modifyInfo.code == 0){
                            let (address,areaid,keyid,loginid,name,picurl,roleid,shopname,tel,ptmc) = self.modifyInfo.data.getUserInfo()
                            
                            
                            if let temp = address {
                                userInfo_Global.address = temp
                                self.address = temp
                            }
                            
                            if let temp = areaid {
                                userInfo_Global.areaid = temp
                                
                            }
                            
                            if let temp = keyid {
                                userInfo_Global.keyid = temp
                            }
                            
                            if let temp = loginid {
                                userInfo_Global.loginid = temp
                            }
                            
                            if let temp = name {
                                userInfo_Global.name = temp
                                self.name = temp
                            }
                            
                            if let temp = picurl {
                                userInfo_Global.picurl = temp
                            }
                            
                            if let temp = roleid {
                                userInfo_Global.roleid = temp
                            }
                            
                            
                            if let temp = shopname {
                                userInfo_Global.shopname = temp
                                self.shopname = temp
                            }
                            
                            
                            if let temp = tel {
                                userInfo_Global.tel = temp
                                self.tel  = temp
                            }
                            
                            self.tableView.reloadData()
                            
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