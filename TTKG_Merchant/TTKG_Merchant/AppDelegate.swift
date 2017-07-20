//
//  AppDelegate.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/27.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import RealmSwift
import SwiftyJSON
import CoreLocation

class Position: Object {
    dynamic var longitude = 0.0 //经度
    dynamic var latitude = 0.0  //纬度
    dynamic var date     = String() //当前时间
    dynamic var userID   = Int() //用户id(唯一)

}

//extension AppDelegate : AMapLocationManagerDelegate {
//    
//    //位置更新后回调方法
//    func amapLocationManager(manager: AMapLocationManager!, didUpdateLocation location: CLLocation!) {
//        
//        let position = Position()
//        position.longitude = location.coordinate.longitude //获取经度
//        position.latitude = location.coordinate.latitude  //获取纬度
//        position.date = NSDate().day.description
//        position.userID = userInfo_Global.keyid
//        
//
//        //可以在任何一个线程中执行检索操作
//        dispatch_async(dispatch_queue_create("background", nil)) {
//            // 获取默认的 Realm 数据库
//            
//            
//            if userInfo_Global.keyid > 0 {//检测用户登录了没有
//                let realm = try! Realm()
//                // 数据持久化操作十分简单
//                try! realm.write {
//                    realm.add(position)
//                }
////                //查询记录
////                let today = NSDate().day.description
////                let puppies = realm.objects(Position)//.filter("date == \(today)")
////                
////                for item  in puppies {
////                    print("puppies = \(item.latitude)   \(item.longitude)")
////                }
//            }
//            
//        }

//        NSLog("===========location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy)
//    }



//1.使用定位服务
//设置app有访问定位服务的权限
//在使用应用期间 / 始终(app在后台)
//info.plist文件添加以下两条(或者其中一条):
//NSLocationWhenInUseUsageDescription 在使用应用期间
//NSLocationAlwaysUsageDescription  始终
//2.LocationManager 对象管理相关的定位服务
//manager判断: 手机是否开启定位 / app是否有访问定位的权限
//[CLLocationManager locationServicesEnabled]; //手机是否开启定位
//[CLLocationManager authorizationStatus];  //app访问定位的权限的状态
//}

extension AppDelegate:CLLocationManagerDelegate
{
    
       
    //获取定位信息
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //取得locations数组的最后一个
        let location:CLLocation = locations[locations.count - 1]
        let position = Position()
        position.longitude = location.coordinate.longitude
        position.latitude = location.coordinate.latitude
        position.date = NSDate().day.description
        position.userID = userInfo_Global.keyid
        self.locationManager.startUpdatingLocation()

        NSLog("location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy)
        
        
        //反地理编码：将经纬度转换成城市，地区，街道
        CLGeocoder().reverseGeocodeLocation(location) { (placemakes: [CLPlacemark]?, error: NSError?) -> Void in
            guard let placemark = placemakes?.first else {
                return
            }
            // 城市
            self.locality = placemark.locality
            // 地区
            self.subLocality = placemark.subLocality
            print("========%@,========%@",self.locality,self.subLocality)
            
            if self.locality != nil
            {
                self.RequestArea(self.subLocality!)
                
            }

            
        }
    }

}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,WXApiDelegate {

//    var locationManager : AMapLocationManager!
    var locationManager : CLLocationManager!
    var currentLocation: CLLocation?
    var geocoder : CLGeocoder!
    var subLocality: String?
    var locality: String?
    var window: UIWindow?

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        if url.host == "safepay" {
            AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (result) -> Void in
                
                NSNotificationCenter.defaultCenter().postNotificationName("alipayKehuduanPayresult", object: nil)
                
            })
        }
        
        if url.host == "platformapi" {
            AlipaySDK.defaultService().processAuthResult(url, standbyCallback: { (result) in
                
                
            })
        }

        
        
        return WXApi.handleOpenURL(url, delegate: self)
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        return WXApi.handleOpenURL(url, delegate: self)
    }
    
    /**
     微信支付回调结果状态码
     
     - parameter resp: resp description
     */
    //errCode = -2  errStr = nil type = 0 取消
    //errCode = 0 errStr = nil type = 0 付款成功
    func onResp(resp: BaseResp!) {
        let errCode = resp.errCode
        let errStr = resp.errStr
        let type = resp.type
        
        
        if 0 == errCode {//支付成功
            let status = ["WeiXinStatus":"paySuccess"]
            let notice = NSNotification(name: "WeiXinResult", object: status)
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }else if -2 == errCode {//取消支付
            let status = ["WeiXinStatus":"cancelWinXinPay"]
            let notice = NSNotification(name: "WeiXinResult", object: status)
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }else{
            let status = ["WeiXinStatus":"error"]
            let notice = NSNotification(name: "WeiXinResult", object: status)
            NSNotificationCenter.defaultCenter().postNotification(notice)
        }
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
//        if url.host == "safepay" {
//            AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (result) -> Void in
//                
//                NSLog("result==\(result.description)")
//                
//            })
//        }

        
        let result :Bool = UMSocialSnsService .handleOpenURL(url)
        
        if result == false{
            
            if url.host == "safepay" {
                AlipaySDK.defaultService().processOrderWithPaymentResult(url, standbyCallback: { (result) -> Void in
                    
                    
                    
                })
            }
            
            if url.host == "platformapi" {
                AlipaySDK.defaultService().processAuthResult(url, standbyCallback: { (result) in
                    
                    
                })
            }

            
        }
        
        return result
        
    }
    
    
    //本地推送
    //24小时制
    func getFireDate( hourOfDay:Float)->NSDate{
        //本地推送时间 hourOfDay
        let pushTime: Float =  hourOfDay*60*60
        let date = NSDate()
        let dateFormatter = NSDateFormatter()
        //日期格式为“时，分，秒”
        dateFormatter.dateFormat = "HH,mm,ss"
        //设备当前的时间（24小时制）
        let strDate = dateFormatter.stringFromDate(date)
        //将时、分、秒分割出来，放到一个数组
        let dateArr = strDate.componentsSeparatedByString(",")
        //统一转化成秒为单位
        let hour = ((dateArr[0] as NSString).floatValue)*60*60
        let minute = ((dateArr[1] as NSString).floatValue)*60
        let second = (dateArr[2] as NSString).floatValue
        var newPushTime = Float()
        if hour > pushTime {
            newPushTime = 24*60*60-(hour+minute+second)+pushTime
        } else {
            newPushTime = pushTime-(hour+minute+second)
        }
        return  NSDate(timeIntervalSinceNow: NSTimeInterval(newPushTime))
    }
    
    //发送通知消息
    func scheduleNotification(itemID:Int){
        //如果已存在该通知消息，则先取消
        cancelNotification(itemID)
        
        //创建UILocalNotification来进行本地消息通知
        let localNotification = UILocalNotification()
        //推送时间（设置为30秒以后）(默认每天晚上7点进行推送)
        var nowTime = NSDate()
        localNotification.fireDate = getFireDate(19)//NSDate(timeIntervalSinceNow: 30)
        //时区
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        //推送内容
        localNotification.alertBody = "天天快购提醒您，天天有惊喜，天天在等你，天天有折扣"
        //声音
        localNotification.soundName = UILocalNotificationDefaultSoundName
        //额外信息
        localNotification.userInfo = ["ItemID":itemID]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    //取消通知消息
    func cancelNotification(itemID:Int){
        //通过itemID获取已有的消息推送，然后删除掉，以便重新判断
        let existingNotification = self.notificationForThisItem(itemID) as UILocalNotification?
        if existingNotification != nil {
            //如果existingNotification不为nil，就取消消息推送
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
    }
    
    //通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
    func notificationForThisItem(itemID:Int)-> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in allNotifications! {
            let info = notification.userInfo as! [String:Int]
            let number = info["ItemID"]
            if number != nil && number == itemID {
                return notification as UILocalNotification
            }
        }
        return nil
    }
    
    
    func application(application: UIApplication,
                     didReceiveLocalNotification notification: UILocalNotification) {
        //设定Badge数目
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        let info = notification.userInfo as! [String:Int]
        let number = info["ItemID"]
        
        let alertController = UIAlertController(title: "本地通知",
                                                message: "温馨提示：\(notification.alertBody!)",
                                                preferredStyle: UIAlertControllerStyle.Alert)
        
        
        
        let cancel = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let ok = UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel) { (UIAlertAction) in
            
            if userInfo_Global.keyid > 0 && userInfo_Global.roleid == 6 {//检测用户登录了没有,且是测试员
                
                do {
                    let realm = try Realm()
                    //查询记录
                    let today = NSDate().day
                    
                    let puppiesTemp = realm.objects(Position).filter("date = '\(today)' ")
                    let puppies = puppiesTemp.filter("userID = \(userInfo_Global.keyid)")
                    
                    //上传数据格式
                    var uploadData = [[String:String]]()
                    for item  in puppies {//取出经纬度，进行拼接
                        var json = [String:String]()
                        print("puppies = \(item.latitude)   \(item.longitude)")
                        json["longititude"] = String(item.longitude)
                        json["latitude"] =  String(item.latitude)
                       
                        uploadData.append(json)
                    }
                    
                    let updata:JSON = JSON(uploadData)
                    
                    //print("updata = \(updata.description)")
                    self.uploadUserInfo(updata.description)
                } catch let error as NSError {
                    // 错误处理
                }
                
                
            }
        }
        
        //alertController.addAction(cancel)
        
        alertController.addAction(ok)
        
        self.window?.rootViewController!.presentViewController(alertController,
                                                               animated: true, completion: nil)
    }
    
    //上传业务员位置数据
    func uploadUserInfo(coords:String){
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let para = ["userid":userInfo_Global.keyid,"coords":coords,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/platform/salesman"
        Alamofire.request(.POST, url, parameters:para as! [String : AnyObject] )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    
                    // 从 Realm 中删除所有数据
                    let realm = try! Realm()
                    try! realm.write {
                        realm.deleteAll()
                    }
                    print("upload OK  response = \(response.description)")
                    break
                    
                    
                case .Failure(let _):
                    print("upload ERROR  response = \(response.description)")
                    break
                    
                }
        }
    }

    //
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        

        
        // 在appDelegate中注册本地通知
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8 {
            //开启通知
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound],categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        //推送通知
//        scheduleNotification(12345);
        
        
        GetNetWorkTime().requestNetWorkTime()
        
        NSLog("timeTemp = \(userInfo_Global.timeStemp)")
        
        self.locationManager = CLLocationManager()
        
        self.geocoder = CLGeocoder()

        if ([CLLocationManager.locationServicesEnabled] == nil) {
            NSLog("定位服务当前可能尚未打开，请设置打开！");
            return true
        }
        
            self.locationManager.requestAlwaysAuthorization()//请求授权
            //设置代理
            self.locationManager.delegate=self;
            //设置定位精度
            self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
            //定位频率,每隔多少米定位一次
             self.locationManager.distanceFilter = 10
            //启动跟踪定位
            self.locationManager.startUpdatingLocation()
        
        
              
        //微信分享
        UMSocialData .setAppKey("57c59df267e58eb55f001796")

        UMSocialWechatHandler.setWXAppId("wx8342726f54c12192" , appSecret: "cb8f3d32faa539e46555447c1b51f385", url: "http://www.umeng.com/social")
        //QQ分享
        UMSocialQQHandler .setQQWithAppId("1105303140", appKey: "PoArvJVywTcAKw5m", url: "http://www.umeng.com/social")
        
        //微信支付注册
        WXApi.registerApp(APP_ID, withDescription: "wx8342726f54c12192")
        IQKeyboardManager.sharedManager().enable = true
        
        //零售商登录通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.startControler), name: "notifyControllerVC", object: nil)
        
        //配送商登录通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.peiSongTabbar), name: "notifyPeiSongTabbar", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.ToLogin), name: "toLoginVC", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.adViewTemp), name: "postAdView", object: nil)
        
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh))
        self.window?.backgroundColor = UIColor.whiteColor()
        
        let loginVC = New_LoginVC()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = loginVC
        
        
        return true
       
//         //得到当前应用的版本号
//        let infoDictionary = NSBundle.mainBundle().infoDictionary
//        let currentAppVersion = infoDictionary!["CFBundleShortVersionString"] as! String
//        
//        // 取出之前保存的版本号
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        let appVersion = userDefaults.stringForKey("appVersion")
//        
//        // 如果 appVersion 为 nil 说明是第一次启动；如果 appVersion 不等于 currentAppVersion 说明是更新了
//        if appVersion == nil || appVersion != currentAppVersion {
//            // 保存最新的版本号
//            userDefaults.setValue(currentAppVersion, forKey: "appVersion")
//            userDefaults.synchronize()
//            
//            let guideViewController = GuideViewController()
//            self.window?.rootViewController = guideViewController
//            self.window?.makeKeyAndVisible()
//        }else{
//            
//            self.window?.rootViewController = CustomTabBar()
//            self.window?.makeKeyAndVisible()
//        }
//        
//        return true
 
        
    }
    
    func adViewTemp(){
        let adView = LBLaunchImageAdView(window: self.window, adType: 0)
        
        adView.skipBtn.hidden = true
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let para = ["sign":MD5_time,"timespan":timeTemp.description]
        let url = serverUrl + "/home/adapp"
        Alamofire.request(.POST, url, parameters:para )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        let screenADModel = ScreenADModel(fromDictionary: dict!)
                        if screenADModel.code == 0 {//有强推广告
                            adView.adTime = 6
                            adView.skipBtn.hidden = false
                            adView.imgUrl = serverPicUrl + screenADModel.data.bigpicurl
                            
                            adView.clickBlock = { (tag) in
                                switch tag {
                                case 1100:
                                    
                                    let adShowView = AdShowView(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh))
                                    adShowView.webStr = screenADModel.data.remark
                                    
                                    adView.removeFromSuperview()
                                    
                                    break
                                case 1101:
                                    
                                    break
                                case 1102:
                                    //NSLog("倒计时完成后的回调")
                                    break
                                default:
                                    break
                                }
                            }
                            
                        }else{
                            adView.adTime = 1
                            adView.skipBtn.hidden = true
                        }
                        
                        
                    }catch _ {
                        adView.adTime = 1
                        adView.skipBtn.hidden = true
                    }
                    
                    
                case .Failure(let _):
                    adView.adTime = 1
                    adView.skipBtn.hidden = true
                }
        }
        
        
    }
    
    //零售商
    func startControler()  {
        self.window?.rootViewController = CustomTabBar()
        self.window?.makeKeyAndVisible()
    }
    
    //配送商
    func peiSongTabbar()  {
        self.window?.rootViewController = CustomTabBarPeiSong()
        self.window?.makeKeyAndVisible()
    }
    
    
    func ToLogin(){
        let loginVC = New_LoginVC()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = loginVC
        
        
    }

    func applicationWillResignActive(application: UIApplication) {
        
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
        let adView = LBLaunchImageAdView(window: self.window, adType: 0)
        
        adView.imgUrl = nil
        adView.skipBtn.hidden = true
        adView.adTime = 3
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func RequestArea(areatitle:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let url = serverUrl + "/home/GetAreaId"
        let p = ["sign":MD5_time,"timespan":timeTemp.description,"areatitle":areatitle]
        Alamofire.request(.GET, url, parameters: p )
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                                           }catch _ {
                        let msg = "无网络连接"
                        }
                    
                    
                case .Failure(let error):
                    let msg = "无网络连接"
                }
        }
    }


    func applicationDidBecomeActive(application: UIApplication) {
        
        let adView = LBLaunchImageAdView(window: self.window, adType: 0)

        //判断一下是否登陆，登陆了才可以请求广告 && 且不是支付宝或微信调起后切回来的
        if (userInfo_Global.keyid != 0) && (alipayOrWeiXinStateFlag == false) {
            
            adView.skipBtn.hidden = true
            let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
            let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
            let para = ["sign":MD5_time,"timespan":timeTemp.description]
            let url = serverUrl + "/home/adapp"
            Alamofire.request(.POST, url, parameters:para )
                    .responseString { response -> Void in
                        switch response.result {
                        case .Success:
                            let dict:NSDictionary?
                            do {
                                dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                                
                                let screenADModel = ScreenADModel(fromDictionary: dict!)
                                if screenADModel.code == 0 {//有强推广告
                                    adView.adTime = 6
                                    adView.skipBtn.hidden = false
                                    adView.imgUrl = serverPicUrl + screenADModel.data.bigpicurl
                                    
                                    adView.clickBlock = { (tag) in
                                        switch tag {
                                        case 1100:
                                            //NSLog("adview")
                                            let adShowView = AdShowView(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh))
                                            adShowView.webStr = screenADModel.data.remark
                                            
                                            adView.removeFromSuperview()
                                            break
                                        case 1101:
                                            //NSLog("点击跳过回调")
                                            break
                                        case 1102:
                                            //NSLog("倒计时完成后的回调")
                                            break
                                        default:
                                            break
                                        }
                                    }
                                    
                                }else{
                                    adView.adTime = 1
                                    adView.skipBtn.hidden = true
                                }
                                
                                
                            }catch _ {
                                adView.adTime = 1
                                adView.skipBtn.hidden = true
                            }
                            
                            
                        case .Failure(let _):
                            adView.adTime = 1
                            adView.skipBtn.hidden = true
                        }
            }
            

        }else{
            alipayOrWeiXinStateFlag = false
            
            adView.imgUrl = nil
            adView.adTime = 1
            adView.skipBtn.hidden = true
        }
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

