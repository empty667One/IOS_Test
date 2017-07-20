//
//  PersonCenterVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftDate



class PersonCenterVC: UIViewController {

    //App下载地址
    var appUpDateUrl = String()
    
    var tableview :UITableView!
    var titleArray : [String]!
    var imageArray : [String]!
    var orderListDic : [String]!
    
    var CreditInfoModel : creditInfoModel!
    var CreditInfoData : creditInfoData!

    
    var temp123 = Float()
    var flag = Bool()
    
    var tel = UILabel()
    
    var index = Int()
    
    var orderListModel : OrderListModel!
    var orderList = [OrderListData]()
    
    
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewWillAppear(animated: Bool) {

        self.navigationController?.navigationBar.hidden = true
        
        if onlineState {
            
            requestInfo(userInfo_Global.keyid)
            requestTelphone()
            requestOrder(userInfo_Global.keyid)
            
            //获取app商店的URL
            requestAppStoreUrl()
            
        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = UIRectEdge.None
        self.navigationController?.navigationBar.hidden = true
        createUI()
        
        titleArray = ["我的爽购", "个人中心","地址管理","我的店铺","分享","关于","退出帐号"]
        imageArray = ["sehuo","ic_user_img","menu_address","menu_address","menu_share","menu_about","login_out_icon"]
        
        //设置导航栏的返回键
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.lightGrayColor()
        
        
    }

    
    //  隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

    
    func createUI() {
        
        tableview = UITableView(frame: CGRectMake(0, 0, screenWith, screenHeigh - 12), style: .Grouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 50
        
        tableview.showsVerticalScrollIndicator = false
        
        
        let subView = PersonView(frame: CGRectMake(0, 0, screenWith, 230))
        subView.delegate = self
        subView.backgroundColor = UIColor.whiteColor()
        tableview.tableHeaderView = subView
        
        self.view.addSubview(tableview)
        
        tableview.registerClass(PersonCell.self, forCellReuseIdentifier: "cell")
        
              
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    

}

extension PersonCenterVC : UITableViewDataSource, UITableViewDelegate,UMSocialUIDelegate{
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : PersonCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PersonCell
        
        if indexPath.row == 0{
            
            if flag == true {
                
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.balance.text = String(format: "余额¥%.2f", temp123)
            }else{
                cell.balance.text = "尚未开通"
            
              }   
       
            
        }else {
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.img.image = UIImage(named: imageArray[indexPath.row])
        cell.label.text = titleArray[indexPath.row]
        
        return cell
        
    }
    
    // 设置头部视图
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
       
        let headView  = UIView()
        let img = UIImageView()
        let label = UILabel()
        let seperateView = UIView()
        
        img.image = UIImage(named: "menu_left_icon")
        headView.addSubview(img)
        img.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.top.equalTo(0).offset(8)
            make.bottom.equalTo(0).offset(-7)
        }
        
        label.text = "常用功能"
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = UIColor.grayColor()
        headView.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.left.equalTo(img.snp_right).offset(3)
            make.centerY.equalTo(img.snp_centerY).offset(0)
        }
        
        seperateView.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
        headView.addSubview(seperateView)
        seperateView.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            make.top.equalTo(0).offset(0)
            make.height.equalTo(3)

        }
        
        headView.backgroundColor = UIColor.whiteColor()
        return headView
            
        
        
    }
    
    //设置头部视图的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    
    //设置cell的点击 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0
        {
            
            if flag == true
            {
                
                let creditVC = PersonCreditVC()
                creditVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(creditVC, animated: false)
            }
                
            else
            {
                if self.tel.text != nil{
                let alertView = UIAlertView(title: "温馨提示", message: "亲，开通此功能需要联系我们的人工客服电话：\(self.tel.text!)", delegate: self, cancelButtonTitle: "开通", otherButtonTitles: "取消")

                alertView.show()
                    index = 0
                }
                else
                {
                    let msg = "无网络连接"
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.warning(msg)
                }
            }
        }
        
        //个人中心
        if indexPath.row == 1
        {
            
            let dataVC = PersonDataVC()
            
            dataVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(dataVC, animated: false)
        }
        
        //地址管理
        if indexPath.row == 2
        {
            
            let addressVC = PersonAddressVC()
            addressVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(addressVC, animated: false)
        }
        
        if indexPath.row == 3
        {

            let myOrder =  MyOrderVC()
            myOrder.orderAry = self.orderList
            myOrder.hidesBottomBarWhenPushed = true

            self.navigationController?.pushViewController(myOrder, animated: false)
            
//
//            let orderVc = OrderViewController()
//            orderVc.htmlUrl = "http://120.76.220.179:8080/WebApp"
//            orderVc.hidesBottomBarWhenPushed = true
//            
//            self.navigationController?.pushViewController(orderVc, animated: false)


        }
        //分享
        if indexPath.row == 4
        {
            
            UMSocialData .defaultData().extConfig.title = "天天快购"
            UMSocialData .defaultData().extConfig.wechatTimelineData.title = "天天快购"
            UMSocialData .defaultData().extConfig.qqData.title = "天天快购"
            UMSocialData .defaultData().extConfig.qzoneData.title = "天天快购"
            
            //判断该用户在appstore没有
            if self.appUpDateUrl.characters.count > 0 {
                UMSocialData .defaultData().extConfig.qqData.url = appUpDateUrl//"https://upgrade.ttkgmall.com/app/index"
                UMSocialData .defaultData().extConfig.qzoneData.url = appUpDateUrl//"https://upgrade.ttkgmall.com/app/index"
                
                
                UMSocialData .defaultData().extConfig.wechatSessionData.url = appUpDateUrl//"https://upgrade.ttkgmall.com/app/index"
                
                UMSocialData .defaultData().extConfig.wechatTimelineData.url = appUpDateUrl//"https://upgrade.ttkgmall.com/app/index"
            }

            UMSocialSnsService .presentSnsIconSheetView(self, appKey: "57c59df267e58eb55f001796", shareText: "进货不需要再花自己的钱，多进多买，利润滚滚", shareImage: UIImage(named: "123456hh"), shareToSnsNames: [UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone], delegate: self)


        }

        //关于
        if indexPath.row == 5{
            
            let htmVC = HtmlVC()
            htmVC.htmlUrl = "https://upgrade.ttkgmall.com/about/about.html"
            htmVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(htmVC, animated: false)
        }
        
        //退出账号
        if indexPath.row == 6
        {
            
            let alertView = UIAlertView(title: "提示", message: "是否确认退出?", delegate: self, cancelButtonTitle: "确定", otherButtonTitles: "取消")
            
            alertView.show()
            index = 4
        }

    }
   
    //分享之后回调方法
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        
        if response.responseCode == UMSResponseCodeSuccess{
            
        
        }
        
   
    }
    
    //检查应用在AppStore中没有
    func requestAppStoreUrl(){
        let url = "https://itunes.apple.com/lookup?id=1153481986" //id 号是该应用的唯一标识符
        Alamofire.request(.GET, url, parameters: nil)
            .responseString { response -> Void in
                
                var appUpDateRootClass:AppUpDateRootClass!
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        appUpDateRootClass = AppUpDateRootClass.init(fromDictionary: dict!)
                        
                        if appUpDateRootClass.resultCount == 1 {
                            
                                self.appUpDateUrl = (appUpDateRootClass.results.last?.trackViewUrl)!
                            
                        }else{
                            //该应用还没有上架成功
                            //print("该应用还没有上架成功")
                        }
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    
                case .Failure(_): break
                    
                }
                
        }

        
    }
    
    
}

extension PersonCenterVC: PersonViewDelegate, UIAlertViewDelegate{
    
    //订单按钮的点击
    func btnClick(num:Int){
        let orderShowVC = OrderShowVC()
        orderShowVC.usrId = userInfo_Global.keyid
        orderShowVC.hidesBottomBarWhenPushed = true
        
        switch num {
        case 0:
            orderShowVC.currentShowTableViewIndex = 0
        case 1:
            orderShowVC.currentShowTableViewIndex = 2
        case 2:
            orderShowVC.currentShowTableViewIndex = 3
        case 3:
            orderShowVC.currentShowTableViewIndex = 4
        default:
            break
        }
        
        self.navigationController?.pushViewController(orderShowVC, animated: false)
        
    }
    
    // 我的订单的点击
    func orderClickToOrderVC(){
        let orderShowVC = OrderShowVC()
        orderShowVC.usrId = userInfo_Global.keyid
        orderShowVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(orderShowVC, animated: false)
    }
    
    //alertView的点击
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
    
        if buttonIndex == 0 {
        
            if index == 0{
                UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(self.tel.text!)")!)
            }
            if index == 4 {
                
                let day = NSDate().day.description
                let status = ["currentDay":day,"signOut":"true"]
                NSUserDefaults.standardUserDefaults().setValue(status, forKey: "currentDay")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                
                let notice = NSNotification(name: "toLoginVC", object: nil)
                
                userInfo_Global.keyid = 0
                
                NSNotificationCenter.defaultCenter().postNotification(notice)
                
            }
           
        }
        
        
        
    }
  
}

extension PersonCenterVC{
    
    //获取爽够状态
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
                        self.CreditInfoModel = creditInfoModel.init(fromDictionary: dict!)
                        self.temp123 = self.CreditInfoModel.data.creditavailable
                        self.flag = self.CreditInfoModel.data.creditstatus
                        self.tableview.reloadData()
                        }

                    }catch _ {
//                        let msg = "无网络连接"
//                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
//                        self.view.dodo.style.bar.locationTop = false
//                        self.view.dodo.warning(msg)
                    }
                    
                    
                    
                case .Failure(let _): break
//                    let msg = "无网络连接"
//                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
//                    self.view.dodo.style.bar.locationTop = false
//                    self.view.dodo.warning(msg)
                }
                
        }
        
    }
    
    //获取客服电话
    func requestTelphone() {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let para = ["sign":MD5_time,"timespan":timeTemp.description]
        let url = serverUrl + "/platform/contact"
        Alamofire.request(.GET, url, parameters:para )
            .responseString { response -> Void in

                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        if dict!["code"] as! Int == 0{
                            
                            let dic = dict!["data"] as! NSDictionary
                            self.tel.text = dic["tel"] as? String
                        }
                        
                    }catch _ {
                        dict = nil
                    }

             
                case .Failure(let error): break
                   
                }
                
        }
        
    }

    //获取订单列表
    func requestOrder(userid:Int) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let parameters = ["userid":userid,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/Order/Clist"
        Alamofire.request(.GET, url, parameters:parameters as! [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                            if dict!["code"] as! Int == 0 {
                            self.orderListModel = OrderListModel.init(fromDictionary: dict!)
                            self.orderList = self.orderListModel.data
                                
                                
                                

                                
                                
                        }
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    
                case .Failure(let error): break
                    
                }
                
        }
        
    }
    
    

}

    


