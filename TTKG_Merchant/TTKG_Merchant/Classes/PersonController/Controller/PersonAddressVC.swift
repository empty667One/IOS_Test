//
//  PersonAddressVC.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/15.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

protocol PersonAddressVCDelegate {
    
    func getAddressData(name: String, phone: String, address: String, country: String, code: String, sparetel: String)
}

class PersonAddressVC: UIViewController {
    
    var addressListModel : AddressListModel!
    var AddressList = [AddressListData]()

    var tableView : UITableView!
    
    let pushFlag = false
    
    let bottomView = UIView()
    let addAdressBtn = UIButton()
    
    var delegate : PersonAddressVCDelegate?
    
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
       
        if onlineState{
       
            //请求数据
            requestData(userInfo_Global.keyid)
        }else{
            
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }

        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //设置导航栏返回按钮
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        
        self.title = "地址管理"
        
        creatUI()
    }
    
    func creatUI() {
        
        tableView = UITableView(frame: CGRectMake(0, 0, screenWith, screenHeigh - 50), style: .Grouped)
        tableView.backgroundColor = UIColor.whiteColor()
    
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        tableView.registerClass(PersonAddressCell.self, forCellReuseIdentifier: "cell")
        tableView.registerClass(PersonAddressCell_one.self, forCellReuseIdentifier: "cell_one")
        tableView.registerClass(PersonAddressCell_two.self, forCellReuseIdentifier: "cell_two")
        
        
        bottomView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.bottom.equalTo(0).offset(0)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.height.equalTo(50)
        }

        
        addAdressBtn.backgroundColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        addAdressBtn.layer.cornerRadius = 5

        addAdressBtn.setTitle("新增收货地址", forState: UIControlState.Normal)
        addAdressBtn.addTarget(self, action: #selector(PersonAddressVC.addAddressBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.bottomView.addSubview(addAdressBtn)
        addAdressBtn.snp_makeConstraints { (make) in
            make.bottom.equalTo(bottomView.snp_bottom).offset(-10)
            make.left.equalTo(bottomView.snp_left).offset(15)
            make.right.equalTo(bottomView.snp_right).offset(-15)
            make.height.equalTo(35)
        }
        
        
  
    }
}

extension PersonAddressVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (self.AddressList.count)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell : PersonAddressCell = tableView.dequeueReusableCellWithIdentifier("cell") as! PersonAddressCell
            cell.name.text = self.AddressList[indexPath.section].name
            
            cell.country_address.text = self.AddressList[indexPath.section].country + self.AddressList[indexPath.section].address
            cell.address.text = self.AddressList[indexPath.section].address
            cell.tel.text = self.AddressList[indexPath.section].phone
            cell.addressid = self.AddressList[indexPath.section].addressid
            cell.country.text = self.AddressList[indexPath.section].country
            cell.code = self.AddressList[indexPath.section].postcode
            cell.sparetel = self.AddressList[indexPath.section].sparetel
            
            if self.AddressList[indexPath.section].isaudit != 2{
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            return cell
        }else{
            if self.AddressList[indexPath.section].isaudit == 2 {
            
                let cell : PersonAddressCell_one = tableView.dequeueReusableCellWithIdentifier("cell_one") as! PersonAddressCell_one
                
                cell.name.text = self.AddressList[indexPath.section].name
                
                cell.country_address.text = self.AddressList[indexPath.section].country + self.AddressList[indexPath.section].address
                cell.address.text = self.AddressList[indexPath.section].address
                cell.tel.text = self.AddressList[indexPath.section].phone
                cell.addressid = self.AddressList[indexPath.section].addressid
                cell.country.text = self.AddressList[indexPath.section].country
                cell.code = self.AddressList[indexPath.section].postcode
                cell.sparetel = self.AddressList[indexPath.section].sparetel

                
                if (self.AddressList[indexPath.section].isdefault == true) {
                    cell.tickBtn.setImage(UIImage(named: "勾-1"), forState: UIControlState.Normal)
                }else{
                    cell.tickBtn.setImage(UIImage(named: "灰色圆"), forState: UIControlState.Normal)
                }
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.delegate = self
                
                return cell
            }else
            {
                let cell : PersonAddressCell_two = tableView.dequeueReusableCellWithIdentifier("cell_two") as! PersonAddressCell_two
                cell.name.text = self.AddressList[indexPath.section].name
                
                cell.country_address.text = self.AddressList[indexPath.section].country + self.AddressList[indexPath.section].address
                cell.address.text = self.AddressList[indexPath.section].address
                cell.tel.text = self.AddressList[indexPath.section].phone
                cell.addressid = self.AddressList[indexPath.section].addressid
                cell.country.text = self.AddressList[indexPath.section].country
                cell.code = self.AddressList[indexPath.section].postcode
                cell.sparetel = self.AddressList[indexPath.section].sparetel
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.delegate = self
                return cell
            }
            

        }
        
        
    }
    
    //设置row的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 70
        }else
        {
            return 45
        }
    }
    
    //设置足部视图内容
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRectMake(0, 0, screenWith, 15))
        footerView.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //cell的点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
            if self.AddressList[indexPath.section].isaudit == 2 {
                
                let name = self.AddressList[indexPath.section].name
                let country = self.AddressList[indexPath.section].country
                let address = self.AddressList[indexPath.section].address
                let tel = self.AddressList[indexPath.section].phone
                let code = self.AddressList[indexPath.section].postcode
                let sparetel = self.AddressList[indexPath.section].sparetel
                
                
                self.delegate?.getAddressData(name, phone: tel, address: address, country: country, code: code, sparetel: sparetel)
                
                self.navigationController?.popViewControllerAnimated(true)
                
        }
    }
    
    
}


extension PersonAddressVC : PersonAddressCell_oneDelegate, PersonAddressCell_twoDelegate{
    
    
    //改变默认地址
    func tickBtnStatusChanged(keyid:Int,addressid: Int){
      
        
        if onlineState{
            
            requestStatusChanged(keyid, addressid: addressid)
        }else{
            
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }

       
        
    }
    
    //删除按钮
    func deleteBtnProcess(keyid:Int, addressid:Int) {
        
        if onlineState{
            
            requestDeleteAddress(keyid, addressid: addressid)
        }else{
            
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
    }
    
    //编辑按钮
    func editBtnClickPushVC(keyid:Int, addressid: Int, name: String, phone: String, address: String, country: String, code: String, sparetel: String) {
        
        let modifyAddressVC = PersonModifyAddressVC()
        modifyAddressVC.name = name
        modifyAddressVC.tel = phone
        modifyAddressVC.address = address
        modifyAddressVC.addressid = addressid
        modifyAddressVC.country = country
        modifyAddressVC.code = code
        modifyAddressVC.sparetel = sparetel
        self.navigationController?.pushViewController(modifyAddressVC, animated: false)
    }

    //新增收货地址
    func addAddressBtnClick()  {
        
        let addAddressVC = PersonAddAddressVC()
        self.navigationController?.pushViewController(addAddressVC, animated: false)
        
    }
    
/**************************************************************
     */
    //请求地址列表
    func requestData(userid:Int) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let parameters = ["userid":userid,"usertype":1,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/address/list"
        Alamofire.request(.GET, url, parameters:parameters as! [String : AnyObject] )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        if dict!["code"] as! Int == 0 {
                            self.addressListModel = AddressListModel.init(fromDictionary: dict!)
                            self.AddressList = self.addressListModel.data
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
    
    //请求改变默认收货地址
    func requestStatusChanged(keyid:Int,addressid: Int) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let parameters = ["userid":keyid,"usertype":1, "addressid": addressid,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/address/setdefault"
        
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
                            
                            self.requestData(userInfo_Global.keyid)
                            self.tableView.reloadData()
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

    //请求删除地址
    func requestDeleteAddress(keyid:Int,addressid: Int) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let parameters = ["userid":keyid,"usertype":1, "addressid": addressid,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/address/remove"
        
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
                            
                            self.requestData(userInfo_Global.keyid)
                            self.tableView.reloadData()
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

