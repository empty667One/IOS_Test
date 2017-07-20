//
//  HomeVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/29.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftDate

class HomeVC: UIViewController,UIAlertViewDelegate {

    private  var classGoodsImage = ["yinliao","jiushui","riyong","zhipin","tiaowei","shicai","lingshi","gengduo"]

    var appUpDateUrl = String()
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
//        if alertView.tag == 100{
//            
//            UIApplication.sharedApplication().openURL(NSURL(string: "https://upgrade.ttkgmall.com/app/index")!)
//        }
        
        if alertView.tag == 200 {
            if buttonIndex == 0 {
                print("appUpDateUrl = \(appUpDateUrl)")
                UIApplication.sharedApplication().openURL(NSURL(string:appUpDateUrl)!)
            }else{
                
            }
        }
        
    }
    
    //请求版本更新
    func requestCheckUpdate(version:String){
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
                            //没有新版本
                            if version == appUpDateRootClass.results.last?.version {
                                //print("没有新版本")
                            }else{//有新版本
                                //print("有新版本")
                                
                                //判断今天提示过没有，没有就提示
                                
                                if let showUpateMessageDate = NSUserDefaults.standardUserDefaults().stringForKey("showUpateMessageDate")  {
                                    if showUpateMessageDate == NSDate().day.description {//今天已经提示过了
                                        
                                    }else{//今天第一次提示更新
                                        self.appUpDateUrl = (appUpDateRootClass.results.last?.trackViewUrl)!
                                        let alert = UIAlertView(title: "版本更新提示", message: (appUpDateRootClass.results.last?.releaseNotes)!, delegate: self, cancelButtonTitle: "去更新",otherButtonTitles: "取消")
                                        alert.tag = 200
                                        alert.show()
                                        
                                        NSUserDefaults.standardUserDefaults().setValue(NSDate().day.description, forKey: "showUpateMessageDate")
                                        NSUserDefaults.standardUserDefaults().synchronize()
                                        
                                    }
                                }else{//第一次安装app
                                    self.appUpDateUrl = (appUpDateRootClass.results.last?.trackViewUrl)!
                                    let alert = UIAlertView(title: "版本更新提示", message: (appUpDateRootClass.results.last?.releaseNotes)!, delegate: self, cancelButtonTitle: "去更新",otherButtonTitles: "取消")
                                    alert.tag = 200
                                    alert.show()
                                    
                                    NSUserDefaults.standardUserDefaults().setValue(NSDate().day.description, forKey: "showUpateMessageDate")
                                    NSUserDefaults.standardUserDefaults().synchronize()
                                }
                                
                                
                            }
                            
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
//        let url = "https://upgrade.ttkgmall.com/appInformation/check"

//        let parameters = ["version":version,"type":"4"]
//        Alamofire.request(.GET, url, parameters: parameters)
//            .responseString { response -> Void in
//                
//                var checkUpdate:CheckUpdateModel!
//                
//                switch response.result {
//                case .Success:
//                    let dict:NSDictionary?
//                    do {
//                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
//                        
//                        NSLog("dict == \(dict?.allKeys)--\(dict?.allValues)")
//                        checkUpdate = CheckUpdateModel.init(fromDictionary: dict!)
//                        if (checkUpdate.success == true) && (checkUpdate.state == 4){
//                            let alert = UIAlertView(title: checkUpdate.msg, message: checkUpdate.descriptionField, delegate: self, cancelButtonTitle: "去更新")
//                            alert.tag = 100
//                            alert.show()
//                        }
//                        
//                        if (checkUpdate.success == true) && (checkUpdate.state == 1){
//                            let alert = UIAlertView(title: checkUpdate.msg, message: checkUpdate.descriptionField, delegate: self, cancelButtonTitle: "去更新",otherButtonTitles: "取消")
//                            alert.tag = 200
//                            alert.show()
//                        }
//                        
//                    }catch _ {
//                        dict = nil
//                    }
//                    
//                    
//                case .Failure(_): break
//                    
//                }
//                
//        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // 得到当前应用的版本号
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
        //NSLog("currentAppVersion==\(currentAppVersion)")
        
        //检测更新
        requestCheckUpdate(currentAppVersion)
    }
    
    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.collection.mj_footer.endRefreshing()
        self.collection.mj_header.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
      
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
//        requestPushAD_Data(userInfo_Global.roleid.description, areaid: userInfo_Global.areaid)
        
        RequestAllAreaList()
    }
    
 
    
    var collection : UICollectionView!        //collectionView
    let layout = UICollectionViewFlowLayout()
    
    var adAppView : HomeAdAPPView!
    
    var areaModel : ListProvinceModel!
    var areaData = [ListData]()
    
    //数据接口api
    private var http = HomePageAPI.shareInstance
    
    var pushAD_Data:PushAD_Data!
    var pushAD_RootClass:PushAD_RootClass!
    var scrollADDatas:[ScrollADData] = []
    var goodsBrandDatas:[GoodsBrandData] = []
    var goodsClassificationDatas:[GoodsClassificationData] = []
    var merchantInfoDatas:[MerchantInfoData] = []

    var noticeData : [NoticeMessageData] = []
    var adAppData : AdApp_Data!
    
    var pushPic = String()
    var adPic = String()
    
    var AdRemark = String()
    var PushRemark = String()
    
    
//    隐藏状态栏
//    override func prefersStatusBarHidden() -> Bool {
//        return true;
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        createUI()       //加载控件
        
        setNavbar()      //创建导航栏
        
        dropDownRef()   //请求数据
        
        //接受通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeVC.HomePageModelChangedProcess), name: "HomePageModelChanged", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeVC.HomePageAPI_SendErrorMsgProcess(_:)), name: "HomePageAPI_SendErrorMsg", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeVC.btn3Click), name: "pushSupplierVC", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeVC.btn2Click), name: "pushHotGoodsVC", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeVC.btn1Click), name: "pushBuyForGiftVC", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeVC.selectAddress(_:)), name: "selectAddress", object: nil)
        
        
        //下拉刷新
        collection.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeVC.dropDownRef))
        
        //上拉加载更多
        self.collection.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(HomeVC.pullUpRef))
        
        
    }
    
    //MARK: Getter
    func setNavbar() {
    
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        /*
        //设置搜索框
        let searchView = UIView(frame: CGRectMake(0, 0, screenWith - 100, 30))
        let searchBar=UISearchBar(frame:  searchView.frame)
        searchView.backgroundColor = UIColor.yellowColor()
        searchView.layer.cornerRadius = 8
        searchView.layer.masksToBounds = true
        self.navigationItem.titleView = searchView
        searchView.addSubview(searchBar)
        */
        let searchBtn = UIButton(frame: CGRectMake(0, 0, screenWith - 100, 28))
        searchBtn.setImage(UIImage(named: "search000"), forState: UIControlState.Normal)
        searchBtn.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 20)
        searchBtn.setTitle("搜索快购商品", forState: UIControlState.Normal)
        searchBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        searchBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        searchBtn.titleEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        searchBtn.backgroundColor = UIColor(red: 229/255, green:230/255 , blue:235/255 , alpha: 1.0)
        searchBtn.layer.masksToBounds = true
        searchBtn.layer.cornerRadius = 10
        searchBtn.addTarget(self, action: #selector(self.searchBtnClick), forControlEvents: .TouchUpInside)
        self.navigationItem.titleView = searchBtn
        
        
       //设置navigationItem
        if userInfo_Global.roleid == 6 {
             self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"定位11100" ), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeVC.someoneSelectAreaID))
        }
        else{
        }
//
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"扫一扫" ), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeVC.gotoScanVC))
        
    }
    
    /**
     特殊人员可以点击该按钮
     */
    func someoneSelectAreaID()  {
        
        if userInfo_Global.roleid == 6{
        
        let selectArea01VC = SelectAreaOneVC()
        selectArea01VC.areaData = self.areaData
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: selectArea01VC)
        
        self.presentViewController(nvc1, animated: false) { () -> Void in
      
            }

        }
        else{
            
           
        }

    }
    
    //接受通知调用的方法,更改区域ID
    func selectAddress(notice:NSNotification)  {
        
        let areaid = notice.object!["areaID"] as! Int
        
        userInfo_Global.areaid = "\(areaid)"
        
        let msg = "区域已切换"
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)
        
        
        dropDownRef()
        
    }
    
    func gotoScanVC() {
        let scanQRcodeVC = QRCodeViewController()
        scanQRcodeVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(scanQRcodeVC, animated: false)
    }
    
    func tankuang(){
        
        
        adAppView = HomeAdAPPView.init(frame: CGRectMake(0, 0, screenWith, screenHeigh - 49))
        adAppView.delegate = self
        
        var reqFlag = "false"
        
        //获取当前时间
        let currentDay = NSDate().day
        
        //判断上次弹出广告的时间是否是今天
        
        if let dic = NSUserDefaults.standardUserDefaults().valueForKey("currentDay") as? [String:String] {
            print("dic = \(dic.description)")
            if dic["currentDay"] == currentDay.description {//今天已经弹出过广告了，无需再弹出了
                //再次判断该用户是否退出过
                if dic["signOut"] == "true" {
                    //可以进行网络请求弹出广告
                    reqFlag = "true"
                    self.view.addSubview(adAppView)
                    
                }else{
                    //你可能是home退出后进来的
                }
                
            }else{
                reqFlag = "true"
                self.view.addSubview(adAppView)
                
            }
        }else{
            //该手机还没有记录过日期，可以进行网络请求弹出广告
            reqFlag = "true"
            self.view.addSubview(adAppView)
        }
        
        if reqFlag == "true"{//可以进行网络请求
            let day = NSDate().day.description
            let status = ["currentDay":day,"signOut":"false"]
            NSUserDefaults.standardUserDefaults().setValue(status, forKey: "currentDay")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        
    }
    
    //加载CollectionView
    func createUI()  {
        

        collection = UICollectionView(frame: CGRect(x: 0 ,y:  0, width: screenWith, height: screenHeigh - 113), collectionViewLayout: layout)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        

        collection.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
        collection!.delegate = self
        collection!.dataSource = self
        
        
        self.view.addSubview(collection)
        
        //注册cell
        collection.registerClass(HomeVCZeroCell.self, forCellWithReuseIdentifier: "ZeroCell")
        collection.registerClass(HomeVCFirstCell.self, forCellWithReuseIdentifier: "FirstCell")
        collection.registerClass(HomeVCSecondCell.self, forCellWithReuseIdentifier: "SecondCell")
        collection.registerNib(UINib(nibName: "HomeVCThirdCell" , bundle: nil), forCellWithReuseIdentifier: "ThirdCell")
        
        collection.registerClass(HomeVCHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "zero_headView")
        collection.registerClass(HomeVCFirstHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "firstHeaderView")
        
        collection.registerClass(HomeVCSecondHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "secondHeaderView")
        
        collection.registerClass(HomeVCFooterView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter , withReuseIdentifier: "footerView")
        
        

    }

     //下拉刷新
    func dropDownRef() {
        
        if onlineState {
            http.requestDefaultDataFromServer(userInfo_Global.roleid, areaid: userInfo_Global.areaid, keyid : userInfo_Global.keyid)
            
            requestPushAD_Data(userInfo_Global.roleid.description, areaid: userInfo_Global.areaid)
        }else{
    
            let msg = "无网络连接"
            collection.mj_header.endRefreshing()
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
       }

    }
    
    //显示错误信息，停止上下拉
    func HomePageAPI_SendErrorMsgProcess(notice : NSNotification){
        

        let msg = notice.object!["errorMsg"]! as! String
        let status = notice.object!["status"]! as! String
        collection.mj_header.endRefreshing()
        if status == "404" {//(true 表示网络故障)或(false 表示无更多数据)
            collection.mj_footer.endRefreshing()
        }else{
            collection.mj_footer.endRefreshingWithNoMoreData()
        }
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)
    }
    

    
//    上拉加载更多
    func pullUpRef()  {

        if onlineState {
            http.requestMoreMerchantData(userInfo_Global.keyid, areaid: userInfo_Global.areaid)
        }
        
    }
    
    //收到通知就可以调用getHomePageDataFromModel获取数据
    func HomePageModelChangedProcess() {
        
        self.collection.mj_header.endRefreshing()
        self.collection.mj_footer.endRefreshing()
        
        let(pushAD_DataTemp,scrollADDatasTemp,goodsBrandDatasTemp,goodsClassificationDatasTemp,merchantInfoDatasTemp, noticeMessageDataTemp,adAppDataTemp) = http.getHomePageDataFromModel()
        
//        if let temp  = pushAD_DataTemp {
//            
//            self.pushAD_Data = temp
//            
//    
//        }
        
        if let temp = scrollADDatasTemp {
            
            self.scrollADDatas = temp
        }
        if  let temp = goodsBrandDatasTemp {
           
            self.goodsBrandDatas =  temp
        }
        
        if let temp = goodsClassificationDatasTemp {
            
            self.goodsClassificationDatas = temp
        }
        if let temp  = merchantInfoDatasTemp {
            
           self.merchantInfoDatas = temp
           
        }
        if let temp  = noticeMessageDataTemp {
            
            self.noticeData = temp
            
        }
        if let temp  = adAppDataTemp {
            
            self.adAppData = temp
            self.adPic = self.adAppData.picurl
            self.AdRemark = self.adAppData.remark
            
        }
        
        self.collection.reloadData()
       
    }
 
    //MARK:Event Response
    //跳转供应商
    func btn3Click() {
        
//        let bankVC = BankVC()
        let bankVC = SupplierController()

        bankVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(bankVC, animated: false)
     
    }
    
    // 跳转热卖
    func btn2Click() {
        
        let hotGoodsVC = HotGoodsVC()
        hotGoodsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(hotGoodsVC, animated: false)
        
    }
    // 跳转满赠
    func btn1Click() {
        
        let buyForGiftVC = BuyForGiftVC()
        buyForGiftVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(buyForGiftVC, animated: false)
        
    }
    
}


//MARK:Delegate
extension HomeVC :  UICollectionViewDataSource{
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 1{
            
            return goodsClassificationDatas.count
        }
  //7.17 修改（去掉快购品牌）      
        
//        if section == 2{
//            
//            return goodsBrandDatas.count
//        }
        if section == 2{
            
            return merchantInfoDatas.count
            
        }else{
            
            return 1
        }
        
}
    
    //设置cell内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section == 0 {
            let cellZero : HomeVCZeroCell = self.collection.dequeueReusableCellWithReuseIdentifier("ZeroCell", forIndexPath: indexPath) as! HomeVCZeroCell
            
            cellZero.backgroundColor = UIColor.whiteColor()
            
            return cellZero
        }
        
        if indexPath.section == 1{
            let cellFirst : HomeVCFirstCell = self.collection.dequeueReusableCellWithReuseIdentifier("FirstCell", forIndexPath: indexPath) as! HomeVCFirstCell
            
            cellFirst.backgroundColor = UIColor.whiteColor()
            
            
            let (name,img) = goodsClassificationDatas[indexPath.row].ex_dataForCellShow()
            
//            cellFirst.nameStr = name
            
            cellFirst.iconUrl = classGoodsImage[indexPath.row]
            
            
            return cellFirst
            
        }
 //7.17 修改（去掉快购品牌）
            
//        if indexPath.section == 2{
//            let cellSecond : HomeVCSecondCell = self.collection.dequeueReusableCellWithReuseIdentifier("SecondCell", forIndexPath: indexPath) as! HomeVCSecondCell
//            
//            cellSecond.backgroundColor = UIColor.whiteColor()
//            
//            let (name, img) = goodsBrandDatas[indexPath.row].ex_ex_dataForCellShow()
//            
//            cellSecond.name.text = name
//            cellSecond.iconUrl = img
//            
//            return cellSecond
//        }
        
        else{
            
            let cellThird : HomeVCThirdCell = self.collection.dequeueReusableCellWithReuseIdentifier("ThirdCell", forIndexPath: indexPath) as! HomeVCThirdCell
            
            cellThird.backgroundColor = UIColor.whiteColor()
            
            cellThird.deliverName.text = self.merchantInfoDatas[indexPath.row].shopname
            cellThird.orderLabel.text = "￥\(self.merchantInfoDatas[indexPath.row].carryingamount)起订 ；每天一次"

            cellThird.brandsStr = self.merchantInfoDatas[indexPath.row].brands
            let imageArray = self.merchantInfoDatas[indexPath.row].products
            
            if imageArray.count != 0 {
                
                
                cellThird.imagHeight.constant = 90
                
                cellThird.imageTop.constant = 12
                cellThird.viewTop.constant = 12
                
                switch imageArray.count {
                    case 1:

                        cellThird.price1.hidden = false
                        cellThird.price2.hidden = true
                        cellThird.price3.hidden = true
                        cellThird.price4.hidden = true
                        
                        cellThird.goodImage1.hidden = false
                        cellThird.goodImage2.hidden = true
                        cellThird.goodImage3.hidden = true
                        cellThird.goodImage4.hidden = true
                        
                        cellThird.goodImage1.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[0].image))
                        cellThird.price1.text = String(format: "￥%.2f",Double(imageArray[0].price) )
                        
                        
                        cellThird.productId1 = imageArray[0].productid
                        
                    
                    case 2:
                        
                        cellThird.price1.hidden = false
                        cellThird.price2.hidden = false
                        cellThird.price3.hidden = true
                        cellThird.price4.hidden = true
                        
                        cellThird.goodImage1.hidden = false
                        cellThird.goodImage2.hidden = false
                        cellThird.goodImage3.hidden = true
                        cellThird.goodImage4.hidden = true
                        cellThird.goodImage1.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[0].image))
                        cellThird.goodImage2.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[1].image))
                    
                        cellThird.price1.text = String(format: "￥%.2f",Double(imageArray[0].price) )
                        cellThird.price2.text = String(format: "￥%.2f",Double(imageArray[1].price) )
                        
                        
                        cellThird.productId1 = imageArray[0].productid
                        cellThird.productId2 = imageArray[1].productid
                    
                    
                    case 3:
                        
                        cellThird.price1.hidden = false
                        cellThird.price2.hidden = false
                        cellThird.price3.hidden = false
                        cellThird.price4.hidden = true
                        
                        cellThird.goodImage1.hidden = false
                        cellThird.goodImage2.hidden = false
                        cellThird.goodImage3.hidden = false
                        cellThird.goodImage4.hidden = true
        
                        cellThird.goodImage4.hidden = true
                        cellThird.price4.hidden = true
                        cellThird.goodImage1.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[0].image))
                        cellThird.goodImage2.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[1].image))
                        cellThird.goodImage3.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[2].image))
                    
                        cellThird.price1.text = String(format: "￥%.2f",Double(imageArray[0].price) )
                        cellThird.price2.text = String(format: "￥%.2f",Double(imageArray[1].price) )
                        cellThird.price3.text = String(format: "￥%.2f",Double(imageArray[2].price) )
                        
                        
                        cellThird.productId1 = imageArray[0].productid
                        cellThird.productId2 = imageArray[1].productid
                        cellThird.productId3 = imageArray[2].productid
                    
                        
                    case 4:
                        
                        cellThird.price1.hidden = false
                        cellThird.price2.hidden = false
                        cellThird.price3.hidden = false
                        cellThird.price4.hidden = false
                        
                        cellThird.goodImage1.hidden = false
                        cellThird.goodImage2.hidden = false
                        cellThird.goodImage3.hidden = false
                        cellThird.goodImage4.hidden = false
                        
                        cellThird.goodImage1.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[0].image))
                        cellThird.goodImage2.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[1].image))
                        cellThird.goodImage3.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[2].image))
                        cellThird.goodImage4.sd_setImageWithURL(NSURL(string: serverPicUrl + imageArray[3].image))
                    
                        cellThird.price1.text = String(format: "￥%.2f",Double(imageArray[0].price) )
                        cellThird.price2.text = String(format: "￥%.2f",Double(imageArray[1].price) )
                        cellThird.price3.text = String(format: "￥%.2f",Double(imageArray[2].price) )
                        cellThird.price4.text = String(format: "￥%.2f",Double(imageArray[3].price))
                        
                        cellThird.productId1 = imageArray[0].productid
                        cellThird.productId2 = imageArray[1].productid
                        cellThird.productId3 = imageArray[2].productid
                        cellThird.productId4 = imageArray[3].productid
                default:
                    break
                }
                
                
                
                
            }else {
                cellThird.price1.hidden = true
                cellThird.price2.hidden = true
                cellThird.price3.hidden = true
                cellThird.price4.hidden = true
                
                cellThird.imagHeight.constant = 0
                cellThird.imageTop.constant = 0
                cellThird.viewTop.constant = 0
                
            }
            
        
            cellThird.shopId = self.merchantInfoDatas[indexPath.row].shopid
            
            cellThird.delegate = self
            
            
            
            return cellThird
        }
        
        
    }
    
}


extension HomeVC : UICollectionViewDelegate{
    
    //监听cell的点击
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
       
        if indexPath.section == 0 {
            return false
        }

        return true
    }
    
    //cell的点击事件
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
       
        if indexPath.section == 1 {
            
            if indexPath.row == 7{

                self.tabBarController?.selectedIndex = 1
                
            }else
            {
            let goodsListVC = GoodsListVC()
            goodsListVC.moreSelectRootClass.slectGoodsByCondition.enterFromClassOrBigBrandFlag = true //从分类进入的
            
            //设置分类ID
            goodsListVC.moreSelectRootClass.slectGoodsByCondition.categoryid = String(goodsClassificationDatas[indexPath.row].categoryid)
            //备份分类ID
            goodsListVC.moreSelectRootClass.slectGoodsByCondition.categoryidTemp = String(goodsClassificationDatas[indexPath.row].categoryid)
            
            goodsListVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(goodsListVC, animated: false)
            }
        }
 //7.17 修改（去掉快购品牌）
        
//        if indexPath.section == 2{
//            
//            let goodsListVC = GoodsListVC()
//            goodsListVC.moreSelectRootClass.slectGoodsByCondition.enterFromClassOrBigBrandFlag = false //从品牌进入的
//            
//            //设置品牌ID
//            goodsListVC.moreSelectRootClass.slectGoodsByCondition.brandid = String(goodsBrandDatas[indexPath.row].brandid)
//            //备份品牌ID
//            goodsListVC.moreSelectRootClass.slectGoodsByCondition.brandidTemp = String(goodsBrandDatas[indexPath.row].brandid)
//            
//            
//            goodsListVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(goodsListVC, animated: false)
//            
//        }
//       

    }
    
    
    
}


extension HomeVC : UICollectionViewDelegateFlowLayout, HomeVCFirstHeaderViewDelegate,HomeVCFooterViewDelegate{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
            return UIEdgeInsets(top: 1, left: 1.5, bottom: 1, right: 1.5)
        
    }

     //第一组头部视图的点击
    func FirstHeaderAddImageClickToPushVC(){
        
        let webVC = HtmlVC()
        webVC.htmlStr = "\(self.AdRemark)"
        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    //第一组尾部视图的点击
    func FirstFooterAddImageClickToPushVC(){
        
        if self.pushAD_Data.datatype == 2{
            
            let shopid = self.pushAD_Data.shopid
            let productid = self.pushAD_Data.productid
            
            if shopid == 0 || productid == 0 {
                
            }else{
                
                let productVC = GoodsDetailVC()
                productVC.shopid = "\(shopid)"
                productVC.productid = "\(productid)"
                productVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(productVC, animated: true)
            }
        }
        if self.pushAD_Data.datatype == 1{
            
            let shopid = self.pushAD_Data.shopid
            
            if shopid == 0{
                
            }else{
                let merchantdetailVC = MerchantDetailVC()
                merchantdetailVC.shopid = String(shopid)
                merchantdetailVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(merchantdetailVC, animated: false)
            }
            
        }
        if self.pushAD_Data.datatype == 0{
            
            let webVC = HtmlVC()
            webVC.htmlStr = "\(PushRemark)"
            webVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(webVC, animated: true)
            

        }
        
        
    }

    //设置头部／尾部视图
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        
        switch kind {
            
        //头部视图
        case UICollectionElementKindSectionHeader:
            
            if indexPath.section == 0{
                let headerView : HomeVCHeaderView = collection.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "zero_headView", forIndexPath: indexPath) as! HomeVCHeaderView
                
                var imgArry = [String]()
                var content = [String]()
                
                for item in self.scrollADDatas {
                    
                    imgArry.append(serverPicUrl + item.picurl)
                    
                }
                
                if self.noticeData .isEmpty == true{
                    
                    content.append("该区域暂时没有广告信息")
                    headerView.scrollView.frame = CGRectMake(0, 0, screenWith, screenHeigh / 3 - 2 )
                    
                    
                }else{
                    
                    headerView.scrollView.frame = CGRectMake(0, 0, screenWith, screenHeigh / 3 - 32 )
                    
                    for item in self.noticeData {
                        
                        
                        content.append("\(item.title)  \(item.content)")
                        
                    }
                }
                
                
                headerView.scrollView.imageURLStringsGroup = imgArry
                
                headerView.scrollMessage.titlesGroup = content
                
                headerView.delegate = self
                
                return headerView
                
            }
            if indexPath.section == 1{
                let headerView1 : HomeVCFirstHeaderView = collection.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "firstHeaderView", forIndexPath: indexPath) as! HomeVCFirstHeaderView
                
                
                headerView1.delegate = self
                
                if self.adAppData.picurl .isEmpty == true {
                    
                    headerView1.picurl = ""
                }else{
                    headerView1.picurl = self.adAppData.picurl
                }
                
                return headerView1
            }
                //7.17 修改（去掉快购品牌）
//            if indexPath.section == 2 {
//                let headerView2 : HomeVCSecondHeaderView = collection.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "secondHeaderView", forIndexPath: indexPath) as! HomeVCSecondHeaderView
//                
//                headerView2.imageView.image = UIImage(named: "brand")
//                headerView2.imageView.contentMode = .ScaleAspectFit
//                
//                headerView2.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
//                return headerView2
            
//            }
        else{
                
                let headerView3 : HomeVCSecondHeaderView = collection.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "secondHeaderView", forIndexPath: indexPath) as! HomeVCSecondHeaderView
                
                headerView3.imageView.contentMode = .ScaleAspectFit
                headerView3.imageView.image = UIImage(named: "supplier")
                
                return headerView3
            }
        //尾部视图
        case UICollectionElementKindSectionFooter:
            if indexPath.section == 1{
                
                let footerView1 : HomeVCFooterView = collection.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footerView", forIndexPath: indexPath) as! HomeVCFooterView
                
                footerView1.delegate = self
                
                if self.pushAD_Data.picurl .isEmpty == true{
                    
                    footerView1.picurl = ""
                    
                }else{
                    footerView1.picurl = self.pushAD_Data.picurl
                }
                return footerView1
            }
            if indexPath.section == 2{
                
                let footerView2 : HomeVCFooterView = collection.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "footerView", forIndexPath: indexPath) as! HomeVCFooterView
                
                
                
                return footerView2
            }else{
                
                return UICollectionReusableView()
            }
            
        default:
            return UICollectionReusableView()
        }
        
        
    }
   
    
    
    //设置item的高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        if  indexPath.section == 0 {
            let size0 = CGSize(width: screenWith , height: 65)
            return size0
        }
        
        if indexPath.section == 1{
            let size1 = CGSize(width: (screenWith - 6) / 4, height: 130)
            return size1
        }
            //7.17 修改（去掉快购品牌）
//        if indexPath.section == 2 {
//            
//            let size2 = CGSize(width: (screenWith - 6) / 4, height: 100)
//            return size2
//        }
        else {
           
            if self.merchantInfoDatas[indexPath.row].products .isEmpty == true{
                return CGSize(width: screenWith, height: 126)
            }else{
                let size3 = CGSize(width: screenWith, height: 240)
                
                
                return size3
            }
            
          
        }
    }
    
    //设置每行间隔
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        if section == 3{
            return 5
        }
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        if section == 0{
            
            return 8
        }
        
        return 1
    }
    
    
    //    设置头部视图高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0{
            
            let size = CGSize(width: screenWith , height: screenHeigh / 3)
            return size
        }
        if section == 1 {

            guard self.adPic .isEmpty == true else{
                let size1 = CGSize(width: screenWith, height: screenWith / 2 - 70)
                return size1
            }
            return CGSizeZero
            
        }
            
//7.17 修改（去掉快购品牌）
//        if section == 2{
//            
//            let size2 = CGSize(width: screenWith, height: 35)
//            return size2
//            
//        }
        else{
            
            if merchantInfoDatas.count == 0 {
                return CGSizeZero
            }
            let size2 = CGSize(width: screenWith, height: 35)
            return size2
        }
        
    }
    
    // 设置尾部视图高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if section == 1 {
            
            guard self.pushPic .isEmpty == true else{
                let size1 = CGSize(width: screenWith, height: screenWith / 2 - 70)
                return size1
            }
            return CGSizeZero
            
        }
        if section == 2{
            
//            guard self.pushAD_Data == nil else{
//                let size1 = CGSize(width: screenWith, height: screenWith / 2 - 70)
//                return size1
//            }
            return CGSizeZero
            
        }else{
            return CGSizeZero
        }
        
    }
 
}

extension HomeVC : HomeVCThirdCellDelegate, HomeVCHeaderViewDelegate, HomeAdAPPViewDelegate{
    
    
    func searchBtnClick()  {

        let searchGoodsVC = SearchGoodsVC()
        searchGoodsVC.enterFlag = EnterFromWhereFlag.全局搜索
        searchGoodsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchGoodsVC, animated: false)

    }
    
    //点击进店按钮
    func entenrShop(shopId:Int) {
        
        let merchantdetailVC = MerchantDetailVC()
        merchantdetailVC.shopid = String(shopId)
        merchantdetailVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(merchantdetailVC, animated: false)
        
    }
    
    //跳转商品详情
    func goodDatail(productid : Int, shopid : Int) {
        
        let productVC = GoodsDetailVC()
        productVC.shopid = "\(shopid)"
        productVC.productid = "\(productid)"
        productVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(productVC, animated: true)
    }
    
    //点击首页公告
    func noticeMessageClick(index:Int){
        
        if noticeData .isEmpty == false{
            
            showMessage(self.noticeData[index].title + self.noticeData[index].content)
        }else{
            showMessage("该区域暂时没有广告")

        }
       
    }
    //展示首页公告
    func showMessage(message:String)  {
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        let img = HalfAlphaGiftShowMessageImageView(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh - 93))
        img.message = message
        self.view.addSubview(img)
    }
    
    
    //点击轮播图片跳转页面
    func scrollImageClick(index: Int) {
        
        if scrollADDatas[index].datatype == 2{
            
            if scrollADDatas[index].shopid == 0 || scrollADDatas[index].productid == 0{
                
                let msg = "暂时没有商品详情"
                self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                self.view.dodo.style.bar.locationTop = false
                self.view.dodo.warning(msg)
                
            }else{
                let productVC = GoodsDetailVC()
                
                productVC.shopid = "\(scrollADDatas[index].shopid)"
                productVC.productid = "\(scrollADDatas[index].productid)"
                productVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(productVC, animated: true)
            }
            
            
        }
        if scrollADDatas[index].datatype == 1 {
            
            let shopid = self.pushAD_Data.shopid
            
            if shopid == 0{
                let msg = "暂时没有商家信息"
                self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                self.view.dodo.style.bar.locationTop = false
                self.view.dodo.warning(msg)
            }else{
                let merchantdetailVC = MerchantDetailVC()
                merchantdetailVC.shopid = String(shopid)
                merchantdetailVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(merchantdetailVC, animated: false)
            }
            
        }
        if scrollADDatas[index].datatype == 0{
            
            let webVC = HtmlVC()
            webVC.htmlStr = "\(scrollADDatas[index].remark)"
            webVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(webVC, animated: true)
        }
        
    }
    //遗憾错过
    func NoBuyBtnClick() {
        self.adAppView.removeFromSuperview()
    }
    
    //立即购买
    func BuyBtnClick() {
        
        self.adAppView.removeFromSuperview()
        
        if self.pushAD_Data.datatype == 2{
            
            let shopid = self.pushAD_Data.shopid
            let productid = self.pushAD_Data.productid
            
            if shopid == 0 || productid == 0 {
                
                let msg = "暂时没有商品详情"
                self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                self.view.dodo.style.bar.locationTop = false
                self.view.dodo.warning(msg)
                
            }else{
                
                let productVC = GoodsDetailVC()
                productVC.shopid = "\(shopid)"
                productVC.productid = "\(productid)"
                productVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(productVC, animated: true)
            }
        }else{
            
            let shopid = self.pushAD_Data.shopid
            
            if shopid == 0{
                
                let msg = "暂时没有商家信息"
                self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                self.view.dodo.style.bar.locationTop = false
                self.view.dodo.warning(msg)
                
                
            }else{
                let merchantdetailVC = MerchantDetailVC()
                merchantdetailVC.shopid = String(shopid)
                merchantdetailVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(merchantdetailVC, animated: false)
            }
            
        }
        
    }
}

extension HomeVC{
    
    func requestPushAD_Data(roleid:String,areaid:String)  {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let url = serverUrl + "/home/adpush"
        var p = ["roleid":roleid,"areaid":areaid,"sign":MD5_time,"timespan":timeTemp.description]
        
        
        Alamofire.request(.GET, url, parameters:p )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.pushAD_RootClass = PushAD_RootClass.init(fromDictionary: dict!)
                        if self.pushAD_RootClass.code == 0{
                            self.pushAD_Data = self.pushAD_RootClass.data
                            self.pushPic = self.pushAD_Data.picurl
                             self.PushRemark = self.pushAD_Data.remark
                            self.tankuang()
                            self.adAppView.imageUrl = self.pushAD_RootClass.data.bigpic
                            
                            
                        }
                        
                    }catch _ {
                        
                        let msg = "无网络连接"
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.warning(msg)
                    }
                    
                    
                case .Failure(let _): break
                    
                }
                
        }
    }
    
    func RequestAllAreaList(){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let url = serverUrl + "/merchant/arealist"
        let para = ["sign":MD5_time,"timespan":timeTemp.description]
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


