//
//  SupplierController.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/9.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class SupplierController: UIViewController {

    
    var collection : UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    //数据接口api
    let http = SupplierAPI.shareInstance
    var merchantInfoDatas : [MerchantInfoData] = []
    
    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
       

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "配送商"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.edgesForExtendedLayout = UIRectEdge.None
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        
        creatUI()
        
        //接受通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SupplierController.SupplierModelChangeProcess), name: "SupplierModelChange", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SupplierController.SupplierAPI_SendErrorMsg), name: "SupplierAPI_SendErrorMsg", object: nil)
        
        dropDownRef()
        
        //下拉刷新
        collection.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(HomeVC.dropDownRef))
        
        //上拉加载更多
        self.collection.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(HomeVC.pullUpRef))
    }

    func creatUI() {
        
        collection = UICollectionView(frame: CGRect(x: 0 ,y:  0, width: screenWith, height: screenHeigh - 64), collectionViewLayout: layout)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
//        layout.itemSize = CGSizeMake(screenWith, 240)
        
        
        collection.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
        collection!.delegate = self
        collection!.dataSource = self
        
        self.view.addSubview(collection)
        
        collection.registerNib(UINib(nibName: "HomeVCThirdCell" , bundle: nil), forCellWithReuseIdentifier: "ThirdCell")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    //下拉刷新
    func dropDownRef() {
        
        if onlineState{

            http.requestDefaultDataFromServer(userInfo_Global.keyid,areaid: userInfo_Global.areaid)
         
        }else{
            
            let msg = "无网络连接"
            collection.mj_header.endRefreshing()
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
    }
    
    //上拉加载更多
    func pullUpRef() {
        
        http.requsetMoreDataFromServer(userInfo_Global.keyid, areaid: userInfo_Global.areaid)

    }
    
    //接受通知获得数据
    func SupplierModelChangeProcess(){
        
        self.collection.mj_header.endRefreshing()
        self.collection.mj_footer.endRefreshing()
        
        merchantInfoDatas = http.getSupplierDataFromModel()

       
        
        
        self.collection.reloadData()
    }
    
    
    func SupplierAPI_SendErrorMsg(notice:NSNotification) {
        
        
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
}

extension SupplierController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return merchantInfoDatas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        
        
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
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        if self.merchantInfoDatas[indexPath.row].products .isEmpty == true{
            return CGSize(width: screenWith, height: 126)
        }else{
            let size3 = CGSize(width: screenWith, height: 240)
            
            
            return size3
        }

    }
}

extension SupplierController : HomeVCThirdCellDelegate{
    
    func entenrShop(shopId:Int) {
        let merchantdetailVC = MerchantDetailVC()
        merchantdetailVC.shopid = String(shopId)
        self.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(merchantdetailVC, animated: false)
    }
    
    func goodDatail(productid : Int, shopid : Int) {
        
        let productVC = GoodsDetailVC()
        productVC.shopid = "\(shopid)"
        productVC.productid = "\(productid)"
        
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}