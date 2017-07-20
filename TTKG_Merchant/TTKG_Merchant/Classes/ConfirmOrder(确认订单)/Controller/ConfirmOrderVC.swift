//
//  ConfirmOrderVC.swift
//  ttkg_customer
//
//  Created by yd on 16/7/11.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import SDWebImage


enum PaymentType {
    case Alipay,Weichat
}

protocol ConfirmOrderVCDelegate : class {
    func paymentSuccess(paymentType paymentType:PaymentType)
    func paymentFail(paymentType paymentType:PaymentType)
}

class ConfirmOrderVC: UIViewController,UIAlertViewDelegate,PersonAddressVCDelegate {
    
    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
     private var telNum = String("4006008195")
    var addressModel : AddressListModel!
    var getGiftInfoMode : GetShopCarGiftModel!
    var payResultModel : PayResultModel!
    var leaveMessageArray = [String]()
    
    //购物车数据
    var confirmOrderDatas = [ShoppingCarData]()
    
    private var userID = 0
    private var userName = ""
    private var userTel = ""
    private var userDetailAddress = ""
    private var userAddress = ""
    
    private var goodsKeyIDString = "" //购物车keyid
    
    private var remarkTemp = ""
    private var discountPrice = 0.00

    
    var payMethodModel : PaymentConfig!
    var createOrderModel : CreateOrder!
    
    var payMentKeyID = 0 //支付id
    private var payMentFlag = ""//标记支付方式
    

    var deliverName = UILabel()//收货人
    var deliverUserName = UILabel()//
    var deliverPhone = UILabel()//电话
    var deliverUserPhone = UILabel()//收货人电话
    var deliverAddress = UILabel()//收货人地址
    var AdressImage = UIImageView()//logo
    
    
    var ordertableView = UITableView()
    
//    private var orderBottomView = UIView()//底部按钮
    var payMent = UILabel()//支付方式
    var payMentBtn = UIButton()//支付按钮
    var lineView = UIView()//分割线
    var confirmOrderBtn = UIButton()//确认下单按钮
    var totalPrice = UILabel()//价格显示
    var amount = UILabel()//文字显示
    var PayMentPrice = 0.00
    
    
    func alipayKehuduanPayresultProcess(){
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConfirmOrderVC.alipayKehuduanPayresultProcess), name: "alipayKehuduanPayresult", object: nil)
        
        self.title = "确认订单"
        var tempStr = String()
        var goodsKeyId = [String]()
        
        var priceTemp = 0.00
        
        
        for item in self.confirmOrderDatas {
            
            for items in item.products {
                if items.selectedFlag {
                    priceTemp += items.price*Double(items.quantity)
                    
                }
            }
            
        }
        
        //请求收货地址
        requestDefaultAddress(userInfo_Global.keyid)
        
        self.PayMentPrice = priceTemp - self.discountPrice
        for item in self.confirmOrderDatas {
            for items in item.products {
                goodsKeyId.append(items.cartid.description)
            }
        }
        
        
        for item in goodsKeyId {
            if goodsKeyId.count == 1 {//只有一个商品时
                tempStr = goodsKeyId.first!
                break
            }else{//多个商品时
                if item == goodsKeyId.last {//等于最后一个时不加逗号
                    tempStr += item
                }else{//加逗号的
                    tempStr += (item + ",")
                }
            }
        }
        
        self.goodsKeyIDString = tempStr
        
        self.ordertableView.reloadData()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        initSubView()
  
    }
    
    func getAddressData(name: String, phone: String, address: String, country: String, code: String, sparetel: String) {
        
        self.deliverUserName.text = name
        self.deliverUserPhone.text = phone
        self.deliverAddress.text = "收货地址  :" + country + address
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        
    }
    
    func initSubView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWith, height: 100))
        let selectAddressBtn = UIButton(frame: headerView.frame)
        selectAddressBtn.addTarget(self, action: #selector(ConfirmOrderVC.selectAdressBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        headerView.backgroundColor = UIColor.whiteColor()
        headerView.addSubview(selectAddressBtn)
        //self.view.addSubview(headerView)
        let bottomLine = UIImageView()
        headerView.addSubview(bottomLine)
        headerView.addSubview(deliverName)
        headerView.addSubview(deliverUserName)
        headerView.addSubview(deliverPhone)
        headerView.addSubview(deliverUserPhone)
        headerView.addSubview(deliverAddress)
        headerView.addSubview(AdressImage)
        deliverName.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(40)
            make.top.equalTo(0).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        deliverName.text = "收货人:"
        deliverName.font = UIFont.systemFontOfSize(14)
        deliverUserName.snp_makeConstraints { (make) in
            make.left.equalTo(deliverName.snp_right).offset(2)
            make.top.equalTo(0).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        deliverUserName.text = ""
        deliverUserName.font = UIFont.systemFontOfSize(12)
        
        deliverPhone.snp_makeConstraints { (make) in
            make.left.equalTo(deliverUserName.snp_right).offset(1)
            make.top.equalTo(0).offset(10)
            make.width.equalTo(35)
            make.height.equalTo(30)
        }
        deliverPhone.text = "电话"
        deliverPhone.font = UIFont.systemFontOfSize(14)
        
        
        deliverUserPhone.snp_makeConstraints { (make) in
            make.left.equalTo(deliverPhone.snp_right).offset(1)
            make.top.equalTo(0).offset(10)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        deliverUserPhone.font = UIFont.systemFontOfSize(12)
        deliverUserPhone.text = ""
        
        AdressImage.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(5)
            make.bottom.equalTo(0).offset(-20)
            make.width.height.equalTo(30)
        }
        AdressImage.image = UIImage(named: "定位11100")
        AdressImage.contentMode = .ScaleAspectFit
        
        deliverAddress.snp_makeConstraints { (make) in
            make.left.equalTo(AdressImage.snp_right).offset(5)
            make.top.equalTo(deliverName.snp_bottom).offset(5)
            make.right.equalTo(0).offset(-20)
            make.height.equalTo(40)
        }
        
        deliverAddress.text = "收货地址:"
        deliverAddress.numberOfLines = 0
        deliverAddress.font = UIFont.systemFontOfSize(12)
        
        
        bottomLine.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(6)
        }
        bottomLine.image = UIImage(named: "adderss_bg")
        
        
        ordertableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh - 64 - 88), style: UITableViewStyle.Grouped)
        ordertableView.dataSource = self
        ordertableView.delegate = self
        ordertableView.separatorStyle = .None
        ordertableView.tableHeaderView = headerView
        self.view.addSubview(ordertableView)
        ordertableView.registerClass(ConfirmOrderCell.self, forCellReuseIdentifier: "ConfirmOrderCell")
        ordertableView.registerNib(UINib(nibName: "ConfirmHeaderView",bundle: nil), forHeaderFooterViewReuseIdentifier: "headerView")
        ordertableView.registerNib(UINib(nibName: "ConfirmFooterView",bundle: nil), forHeaderFooterViewReuseIdentifier: "footerView")
        
        
        let orderBottomView = UIView()
        self.view.addSubview(orderBottomView)
        orderBottomView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(ordertableView.snp_bottom )
        }
        orderBottomView.backgroundColor = UIColor.whiteColor()
        
        
        orderBottomView.addSubview(payMent)
        orderBottomView.addSubview(lineView)
        orderBottomView.addSubview(confirmOrderBtn)
        orderBottomView.addSubview(totalPrice)
        orderBottomView.addSubview(amount)
        
        payMent.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(10)
            make.top.equalTo(0).offset(10)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        payMent.font = UIFont.systemFontOfSize(13)
        payMent.text = "支付方式"
        payMent.textAlignment = NSTextAlignment.Center
        
        lineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(payMent.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        lineView.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1.0)
        
        confirmOrderBtn.snp_makeConstraints { (make) in
            make.top.equalTo(lineView.snp_bottom)
            make.bottom.right.equalTo(0)
            make.width.equalTo(80)
        }
        
        confirmOrderBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        confirmOrderBtn.backgroundColor = UIColor.redColor()
        confirmOrderBtn.setTitle("提交下单", forState: UIControlState.Normal)
        confirmOrderBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        confirmOrderBtn.addTarget(self, action: #selector(ConfirmOrderVC.confirmOrderBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        totalPrice.snp_makeConstraints { (make) in
            make.top.equalTo(lineView.snp_bottom)
            make.bottom.equalTo(0)
            make.width.equalTo(80)
            make.right.equalTo(confirmOrderBtn.snp_left)
        }
        
        
        
        totalPrice.text = String(format: "%.2f",self.PayMentPrice)
        totalPrice.textColor = UIColor.redColor()
        totalPrice.font = UIFont.systemFontOfSize(12)
        
        amount.snp_makeConstraints { (make) in
            make.top.equalTo(lineView.snp_bottom)
            make.bottom.equalTo(0)
            make.width.equalTo(80)
            make.right.equalTo(totalPrice.snp_left)
        }
        
        amount.text = "合计："
        amount.textColor = UIColor.blackColor()
        amount.font = UIFont.systemFontOfSize(13)
        amount.textAlignment  = .Right
        
        payMentBtn = UIButton(frame: CGRect(x: orderBottomView.frame.maxX - 70, y: 10, width: 85, height: 30))
//        payMentBtn.backgroundColor = UIColor.brownColor()
        payMentBtn.setTitle("请选择支付方式", forState: UIControlState.Normal)
        payMentBtn.setImage(UIImage(named: "right_arrow"), forState: UIControlState.Normal)
        
        payMentBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: -20)
        payMentBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        payMentBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        payMentBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)
        payMentBtn.addTarget(self, action: #selector(ConfirmOrderVC.selectPayment), forControlEvents: UIControlEvents.TouchUpInside)
        
        orderBottomView.addSubview(payMentBtn)
        payMentBtn.snp_makeConstraints { (make) in
            make.right.equalTo(0).offset(-8)
            make.top.equalTo(payMent.snp_top)
            make.bottom.equalTo(payMent.snp_bottom)
            make.width.equalTo(80)
        }
        
        
    }
    
    
    func setNavBar(){
       
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ConfirmOrderVC.backUpController))
//        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.redColor()
    }
//    func backUpController() {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    
    func selectAdressBtnClick(){
        let selectAdressVC = PersonAddressVC()
        selectAdressVC.delegate = self
        selectAdressVC.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(selectAdressVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
        setNavBar()
        requestPayMethod()
        
        
        //微信支付结果处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConfirmOrderVC.weiXinResultProcess(_:)), name: "WeiXinResult", object:nil)
        
        //支付宝支付结果处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConfirmOrderVC.alipayResultProcess(_:)), name: "AlipayResult", object:nil)
        
        
        //爽购支付通知处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConfirmOrderVC.shuangGouResultProcess(_:)), name: "ShuangGouResult", object:nil)
        
        
        
        //货到付款通知处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConfirmOrderVC.huoDaoFuKuanResultProcess(_:)), name: "HuoDaoFuKuanResult", object:nil)
    }

}

extension ConfirmOrderVC: ConfirmFooterViewDelegate{
    func getLeaveMessageText(index : Int,text: String) {
        var levaeMessageArr = [String]()
        let shopidTemp = self.confirmOrderDatas[index].shopid.description
        let shopTempText = text
        
        if shopTempText != "" {
            levaeMessageArr.append(shopidTemp + "-" + shopTempText)
        }
        
        
        self.leaveMessageArray += levaeMessageArr
        
        var addressTemp = ""
        for item in self.leaveMessageArray {
            if self.leaveMessageArray.count == 1 {//只有一个商品时
                addressTemp = self.leaveMessageArray.first!
                break
            }else{//多个商品时
                if item == self.leaveMessageArray.last {//等于最后一个时不加逗号
                    addressTemp += item
                }else{//加逗号的
                    addressTemp += (item + "|")
                }
            }
        }
        
        self.remarkTemp = addressTemp
    }
}


//MARK:选择支付方式的弹框
extension ConfirmOrderVC {
    func selectPayment() {
        
        
        let alertController = UIAlertController(title: "提示", message: "请选中支付方式", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        //爽购
        let shuangGouMethod = UIAlertAction(title: "爽购", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            
            self.payMentBtn.setTitle("爽购", forState: UIControlState.Normal)
            self.payMentFlag = "爽购"
            for item in self.payMethodModel.data {
                if item.title == "爽购" {
                    self.payMentKeyID = item.paymentid
                    self.requestGetShopCarGetGiftInfo(userInfo_Global.keyid, paymentid: self.payMentKeyID, cartid: self.goodsKeyIDString)
                }
            }

        }
        //支付宝
        let alipayMethod = UIAlertAction(title: "支付宝", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            
            self.payMentBtn.setTitle("支付宝", forState: UIControlState.Normal)
            self.payMentFlag = "支付宝"
            for item in self.payMethodModel.data {
                if item.title == "支付宝" {
                    self.payMentKeyID = item.paymentid
                    self.requestGetShopCarGetGiftInfo(userInfo_Global.keyid, paymentid: self.payMentKeyID, cartid: self.goodsKeyIDString)
                }
            }
        }
        
        //微信支付
        let weixinMethod = UIAlertAction(title: "微信支付", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            
            self.payMentBtn.setTitle("微信支付", forState: UIControlState.Normal)
            self.payMentFlag = "微信支付"
            for item in self.payMethodModel.data {
                if item.title == "微信支付" {
                    self.payMentKeyID = item.paymentid
                    self.requestGetShopCarGetGiftInfo(userInfo_Global.keyid, paymentid: self.payMentKeyID, cartid: self.goodsKeyIDString)
                }
            }
        }
        
        //货到付款
        let huoDaoMethod = UIAlertAction(title: "货到付款", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            
            self.payMentBtn.setTitle("货到付款", forState: UIControlState.Normal)
            self.payMentFlag = "货到付款"
            for item in self.payMethodModel.data {
                if item.title == "货到付款" {
                    self.payMentKeyID = item.paymentid
                    self.requestGetShopCarGetGiftInfo(userInfo_Global.keyid, paymentid: self.payMentKeyID, cartid: self.goodsKeyIDString)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil)
        
        for item in self.payMethodModel.data {
            if item.title == "爽购" {
                self.payMentKeyID = item.paymentid
                alertController.addAction(shuangGouMethod)
            }else if item.title == "微信支付" {
                self.payMentKeyID = item.paymentid
                alertController.addAction(weixinMethod)
            }else if item.title == "支付宝"{
                self.payMentKeyID = item.paymentid
                alertController.addAction(alipayMethod)
            }else if item.title == "货到付款"{
                self.payMentKeyID = item.paymentid
                alertController.addAction(huoDaoMethod)
            }
        }
        
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true) { 
            
        }
        
    }
    
    //MARK:提交下单按钮点击
    func confirmOrderBtnClick()  {
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        
        if deliverUserName.text != "" &&  deliverAddress != ""{
            
            if self.payMentFlag == "爽购" {
                requestCheckShuangGouAmount(self.PayMentPrice)
            }else{
            
            requestCreateOrder(userInfo_Global.keyid, username: deliverUserName.text!, address: deliverAddress.text!, tel: deliverUserPhone.text!, postcode: "", cartid: self.goodsKeyIDString,remark:self.remarkTemp)
            }
        }else{
            let alert = UIAlertView(title: "提示", message: "请填写收货人和详细地址！", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
        
        
    }
    
}


extension ConfirmOrderVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.confirmOrderDatas[section].products.count)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return (self.confirmOrderDatas.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell : ConfirmOrderCell = ordertableView.dequeueReusableCellWithIdentifier("ConfirmOrderCell") as! ConfirmOrderCell
        cell.selectionStyle = .None
        cell.goodsName.text = self.confirmOrderDatas[indexPath.section].products[indexPath.row].productname
        cell.goodsImage.sd_setImageWithURL(NSURL(string: serverPicUrl + self.confirmOrderDatas[indexPath.section].products[indexPath.row].image))
        cell.goodsPrice.text = "￥" + self.confirmOrderDatas[indexPath.section].products[indexPath.row].price.description
        cell.goodsNum.text = "X" + self.confirmOrderDatas[indexPath.section].products[indexPath.row].quantity.description
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = ConfirmHeaderView()
        headerView.shopName.text = self.confirmOrderDatas[section].shopname
        return headerView
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = ConfirmFooterView()
        footerView.delegates = self
        footerView.tag = section
        footerView.leaveMessage.tag = section
        return footerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    
    
    
}


// MARK: - 获取支付配置信息
extension ConfirmOrderVC {
    func requestPayMethod() {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let para = ["roleid":userInfo_Global.roleid,"sign":MD5_time,"timespan":timeTemp.description]
        let url = serverUrl + "/payment/list"
        Alamofire.request(.GET, url, parameters: para as! [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        self.payMethodModel = PaymentConfig.init(fromDictionary: dict!)
                        if (self.payMethodModel.code == 0) {
                            let payName = self.payMethodModel.data.first?.title
                            self.payMentFlag = payName!
                            self.payMentKeyID = (self.payMethodModel.data.first?.paymentid)!
                            self.payMentBtn.setTitle(payName, forState: UIControlState.Normal)
                            self.requestGetShopCarGetGiftInfo(userInfo_Global.keyid, paymentid: self.payMentKeyID, cartid: self.goodsKeyIDString)
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

// MARK: - 提示马上支付或取消支付
extension ConfirmOrderVC:ShowGiftAndPayViewDelegate {
    
    //取消立即支付，订单已经创建了，需要去订单页面
    func cancelRightNowPayOrder(){
        self.tabBarController?.selectedIndex = ((self.tabBarController?.childViewControllers.count)! - 1 )
        let navigationController = (self.tabBarController?.childViewControllers.last) as! CustomNavigationBar
        let orderShowVC = OrderShowVC()
        orderShowVC.usrId = userInfo_Global.keyid
        orderShowVC.hidesBottomBarWhenPushed = true
        
        orderShowVC.currentShowTableViewIndex = 2
        navigationController.pushViewController(orderShowVC, animated: false)
        
        orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
        orderShowVC.view.dodo.style.bar.locationTop = false
        orderShowVC.view.dodo.warning("请重新支付该笔订单")
        
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    
    func payOrder(order:String,price:Double,time:String,goodsName:String,payMethod:String){
        if (self.payMentFlag == "爽购") {
            ShuangGouAndHuoDaoPay().requestShuangGouToPay(order)
        }
        
        if (self.payMentFlag == "货到付款"){
            ShuangGouAndHuoDaoPay().requestDeliverToPay(order)
        }
        
        if (self.payMentFlag == "支付宝"){
            AlipayAndWeixinPay().Alipay(order, productName: "天天快购平台:" + order, productDescription: time , amount: String(price))
        }
        
        if (self.payMentFlag == "微信支付"){
            AlipayAndWeixinPay().weiXinPay(order, productName: "天天快购平台:" + order, productDescription: time, amount: String(Int(price*100)), notifyURL: WeixinNotifyURL)
        }
    }
}


// MARK: - 创建订单
extension ConfirmOrderVC {
    
    func requestCreateOrder(userid:Int,username:String,address:String,tel:String,postcode:String,cartid:String,remark:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        HUD.mode = MBProgressHUDMode.Indeterminate
        HUD.label.text = "订单创建中"
        HUD.hideAnimated(true, afterDelay: 2)
        
        
        let url = serverUrl + "/order/submit"
        let parameters = ["userid":userid,"username":username,"address":address,"tel":tel,"postcode":postcode,"cartid":cartid,"clienttype":2,"usertype":1,"remark":remark,"sign":MD5_time,"timespan":timeTemp.description]
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.createOrderModel = CreateOrder.init(fromDictionary: dict!)
                        
                        
                        let message = self.createOrderModel.msg
                        
                        if (self.createOrderModel.code == 0){
                            
                            HUD.hideAnimated(true, afterDelay: 1)
                            
                            //订单号
                            let tradeNo = self.createOrderModel.data.tradeno
                            //商品总金额
                            let amount = self.createOrderModel.data.totalfee
                            //时间
                            let timespan = self.createOrderModel.data.timespan
                            
                            let doubleAmount = Double(amount)//(amount as NSString).doubleValue
                            
                        
                            let giftView = ShowGiftAndPayView(gift: [String](), discountPrice: self.discountPrice, price: doubleAmount!,payMethod:self.payMentFlag,flag:true,orderNum:tradeNo,time:timespan,goodsTitle:"")
                            giftView.delegate = self
                            self.view.addSubview(giftView)
                            
                            
                        }else{
                            HUD.label.text = message
                            HUD.hideAnimated(true, afterDelay: 1)
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




// MARK: - 请求收货地址
extension ConfirmOrderVC {
    func requestDefaultAddress(userid:Int)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/address/list"
        let parameters = ["userid":userid,"usertype":1,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.GET, url, parameters: parameters as? [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    self.addressModel = AddressListModel.init(fromDictionary: dict!)
                    
                    if (self.addressModel.code == 0) {
                        for item in (self.addressModel.data){
                            if item.isdefault == true && item.isaudit == 2{
                                self.deliverUserName.text = item.name
                                self.deliverUserPhone.text = item.phone
                                self.deliverAddress.text = "收货地址  :" + item.country + item.address
                            }
                        }
                    }
                    
                    
                case .Failure(let error):
                    print(error)
                }
        }

    }
    
    //提交购物车赠送信息
    func requestGetShopCarGetGiftInfo(userid:Int,paymentid:Int,cartid:String)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/shoppingcart/gift"
        let parameters = ["userid":userid,"usertype":1,"paymentid":paymentid,"cartid":cartid,"sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.GET, url, parameters: parameters as? [String : AnyObject])
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                    }catch _ {
                        dict = nil
                    }
                    
                   self.getGiftInfoMode = GetShopCarGiftModel.init(fromDictionary: dict!)
                    
                    if (self.getGiftInfoMode.code == 0){
                        if (self.getGiftInfoMode.data.count != 0){
                            let alert = AlertView()
                            alert.giftData = self.getGiftInfoMode.data
                            alert.show()
                            
                            var discountPriceTemp = 0.00
                            for item in self.getGiftInfoMode.data {
                                
                                if item.hasdiscount == true {
                                    discountPriceTemp  += Double(item.discountamount)
                                }
                            }
                            
                            self.discountPrice = discountPriceTemp
                            
                            
                        }
                    }
                    
                    
                case .Failure(let error):
                    print(error)
                }
        }

    }
    
    
    
    
}



extension ConfirmOrderVC  {
       func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        if alertView.tag == 100 {
            if buttonIndex == 0 {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        if alertView.tag == 0 {
            if buttonIndex == 0 {
                UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(telNum)")!)
            }
        }else{
            
        }

        if alertView.tag == 200 {
            
        }
    }
    
    

}


extension ConfirmOrderVC {
    //微信支付(通知处理)
    func weiXinResultProcess(notice:NSNotification) {
        
        
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.locationTop = false
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 3
        self.view.dodo.style.bar.locationTop = false
        
        let tab = UIApplication.sharedApplication().keyWindow?.rootViewController
        let childvc = tab!.childViewControllers
        let vc = childvc.last as! CustomNavigationBar
        
        self.tabBarController?.selectedIndex = ((childvc.count) - 1 )
        let navigationController = (vc) as! CustomNavigationBar
        
        let orderShowVC = OrderShowVC()
        orderShowVC.usrId = userInfo_Global.keyid
        orderShowVC.hidesBottomBarWhenPushed = true
        
        
        var msg = String()
        if let weiXinStatus = notice.valueForKey("object")?.valueForKey("WeiXinStatus") {
            if weiXinStatus as? String == "notInstall" {
                //selectOrderStatus(3)
                
                orderShowVC.currentShowTableViewIndex = 2
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.error("请先安装微信客服端再进行支付")
                
            }else if "signedError" ==  weiXinStatus as? String{
                msg = "微信支付签名错误，请稍后再试"
                orderShowVC.currentShowTableViewIndex = 2
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.error(msg)
            }else if "paySuccess" == weiXinStatus as? String {
                orderShowVC.currentShowTableViewIndex = 3
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.success("微信支付成功")
                
            }else if "cancelWinXinPay" == weiXinStatus as? String{
                orderShowVC.currentShowTableViewIndex = 2
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.warning("您取消了微信支付")
                
            }else if "notLogin" == weiXinStatus as? String{//没有登陆微信
                orderShowVC.currentShowTableViewIndex = 3
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.warning("您没有登陆微信")
            }else{
                
                orderShowVC.currentShowTableViewIndex = 2
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 2
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.error("网络故障，请重试")
            }
            
        }else{
            msg = "无可用网络"
        }
        
        self.view.dodo.warning(msg)
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    //支付宝支付
    func alipayResultProcess(notice:NSNotification) {
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 3
        self.view.dodo.style.bar.locationTop = false
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 3
        self.view.dodo.style.bar.locationTop = false
        
        let tab = UIApplication.sharedApplication().keyWindow?.rootViewController
        let childvc = tab!.childViewControllers
        let vc = childvc.last as! CustomNavigationBar
        
        self.tabBarController?.selectedIndex = ((childvc.count) - 1 )
        let navigationController = (vc) as! CustomNavigationBar
        
        let orderShowVC = OrderShowVC()
        orderShowVC.usrId = userInfo_Global.keyid
        orderShowVC.hidesBottomBarWhenPushed = true
        
        var msg = String()
        if let alipayStatus = notice.valueForKey("object")?.valueForKey("alipayStatus") {
            if alipayStatus as? String == "successful" {
                orderShowVC.currentShowTableViewIndex = 3
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.success("支付宝支付成功")
            }else if "cancellAlipay" == alipayStatus as? String{
                orderShowVC.currentShowTableViewIndex = 2
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.warning("您取消了支付宝支付")
            }
        }else{
            msg = "无可用网络"
        }
        
        self.view.dodo.warning(msg)
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    //爽购支付
    func shuangGouResultProcess(notice:NSNotification) {
        
    
        self.view.dodo.style.bar.hideAfterDelaySeconds = 3
        self.view.dodo.style.bar.locationTop = false
        
        
        let tab = UIApplication.sharedApplication().keyWindow?.rootViewController as! UITabBarController
        let childvc = tab.childViewControllers
        let vc = childvc.last as! CustomNavigationBar
        
        tab.selectedIndex = ((childvc.count) - 1 )
        let navigationController = (vc) as! CustomNavigationBar
        
        let orderShowVC = OrderShowVC()
        orderShowVC.usrId = userInfo_Global.keyid
        orderShowVC.hidesBottomBarWhenPushed = true
        
        if let code = notice.valueForKey("object")?.valueForKey("code") {
            if (code as! Int) == 0 {//支付成功，选择待发货
                orderShowVC.currentShowTableViewIndex = 3
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.success("支付成功")
            }else{//支付失败
                orderShowVC.currentShowTableViewIndex = 2
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.error("支付失败")
            }
        }else{
            self.view.dodo.warning("无可以网络")
        }
        
        self.navigationController?.popViewControllerAnimated(false)
        
    }
    
    
    //货到付款
    func huoDaoFuKuanResultProcess(notice:NSNotification) {
        
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 3
        self.view.dodo.style.bar.locationTop = false
        
        let tab = UIApplication.sharedApplication().keyWindow?.rootViewController
        let childvc = tab!.childViewControllers
        let vc = childvc.last as! CustomNavigationBar
        
        self.tabBarController?.selectedIndex = ((childvc.count) - 1 )
        let navigationController = (vc) as! CustomNavigationBar
        
        let orderShowVC = OrderShowVC()
        orderShowVC.usrId = userInfo_Global.keyid
        orderShowVC.hidesBottomBarWhenPushed = true
        
        
        if let code = notice.valueForKey("object")?.valueForKey("code") {
            if (code as! Int) == 0 {//支付成功，选择待发货
                orderShowVC.currentShowTableViewIndex = 3
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.success("支付成功")
            }else{//支付失败
                orderShowVC.currentShowTableViewIndex = 2
                navigationController.pushViewController(orderShowVC, animated: false)
                
                orderShowVC.view.dodo.style.bar.hideAfterDelaySeconds = 3
                orderShowVC.view.dodo.style.bar.locationTop = false
                orderShowVC.view.dodo.error("支付失败")
            }
        }else{
            self.view.dodo.warning("无可以网络")
        }
        self.navigationController?.popViewControllerAnimated(false)
    }
}

extension ConfirmOrderVC {
   
    //查询爽购余额并进行支付
    func requestCheckShuangGouAmount(price:Double){
        
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
                                self.telNum = (dic["tel"] as? String)!
                                let alertView = UIAlertView(title: "温馨提示", message: "亲，开通此功能需要联系我们的人工客服电话：\(self.telNum)", delegate: self, cancelButtonTitle: "开通", otherButtonTitles: "取消")
                                alertView.tag = 0
                                alertView.show()
                                
                            }
                            
                        }catch _ {
                            dict = nil
                        }
                        
                        
                        
                        
                        
                        
                    case .Failure(let error):
                        print(error)
                    }
                    
            }
            
        }
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        
        let parameters = ["userid":userInfo_Global.keyid,"usertype":1,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/merchant/creditstate"
        Alamofire.request(.GET, url, parameters:parameters as? [String : AnyObject] )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        //1用户没有开通爽购
                        if ( (dict!["code"] as? Int) == 0) && ( (dict!["data"]!["creditstatus"] as? Bool) == false ){
                            
                            requestTelphone()
                            
                            
                        }else if ( (dict!["code"] as? Int) == 0) && ( (dict!["data"]!["creditstatus"] as? Bool) == true ){
                            let creditavailable = dict!["data"]!["creditavailable"] as! Double
                            if price > creditavailable {//2不够支付
                                
                                let alertView = UIAlertView(title: "订单提示", message: "爽购可用余额￥\(creditavailable)\n支付金额￥\(price)\n不能完成该笔支付，请经常还款噢...还能享受更多优惠", delegate: self, cancelButtonTitle: "确定")
                                alertView.tag = 1
                                alertView.show()
                                
                            }else{//可以支付
                                self.requestCreateOrder(userInfo_Global.keyid, username: self.deliverUserName.text!, address: self.deliverAddress.text!, tel: self.deliverUserPhone.text!, postcode: "", cartid: self.goodsKeyIDString,remark:self.remarkTemp)
                            }
                        }else{
                            //其他故障
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

















