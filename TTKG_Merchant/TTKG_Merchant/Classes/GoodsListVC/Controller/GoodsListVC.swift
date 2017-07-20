//
//  GoodsListVC.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/5.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit

class GoodsListVC: UIViewController {
    
    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    
   lazy var moreConditionSelectView : MoreConditionSelectView = MoreConditionSelectView(frame: CGRect(x: screenWith, y: 20, width: screenWith, height: screenHeigh - 20))
    
    //是否是筛选商品设置的参数
    private var conditionFlag = false
    
    var http = GoodsListAPI.shareInstance
    
    //大品牌（筛选用）
    var bigBrand:[BigBrandData]!
    
    //商品列表
    var goodsDatas = [MerchantGoodsData]()
    
    //排序存储记录
    var moreSelectRootClass = MoreSelectRootClass()
    
    var collection : UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    
    func creatUI() {
        self.edgesForExtendedLayout = UIRectEdge.None
        
        
        let topViewContent = UIView()
        self.view.addSubview(topViewContent)
        
        
        
        topViewContent.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        let fourButtonView = TopFourButtonView(frame: CGRect(x: 0, y: 0, width: screenWith, height:40 ))
        fourButtonView.delegate = self
        topViewContent.addSubview(fourButtonView)
        
        layout.minimumInteritemSpacing = 1//2.5
        layout.minimumLineSpacing = 1//2.5
        
        let rect = CGRect(x: 0, y: 40, width: screenWith, height: screenHeigh - 104)
        collection = UICollectionView(frame: rect,collectionViewLayout: layout)
        self.view.addSubview(collection)
        collection.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(topViewContent.snp_bottom)
        }
        collection!.delegate = self
        collection!.dataSource = self
        collection.backgroundColor =  UIColor(red: 236/255, green: 237/255, blue: 239/255, alpha: 1.0)
        
        collection.registerClass(GoodsListCell.self, forCellWithReuseIdentifier: "GoodsListCell")
        
        //下拉
        self.collection.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(GoodsListVC.dropDownRef))
        //上拉
        self.collection.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(GoodsListVC.pullUpRef))
        
        //请求大品牌数据
        http.requestBigBrand()
        
        //默认下拉一次
        dropDownRef()
    }
    
    //上拉加载更多
    func pullUpRef(){
        collection.mj_footer.endRefreshingWithNoMoreData()
    }
    //下拉刷新
    func dropDownRef()  {
        
        //请求商品列表数据
        //先更新一下请求条件
        self.moreSelectRootClass.requestPara()
        
        if  conditionFlag == false {
            //判断从哪点点击进入的（true为分类进入，false为大品牌进入）
            if moreSelectRootClass.slectGoodsByCondition.enterFromClassOrBigBrandFlag {
                http.requestGoodsByClass(moreSelectRootClass.slectGoodsByCondition.categoryid, pageindex: "1", pagesize: "10000", sort: moreSelectRootClass.slectGoodsByCondition.sort, asc: moreSelectRootClass.slectGoodsByCondition.asc)
            }else{
                http.requestGoodsByBrand(moreSelectRootClass.slectGoodsByCondition.brandid, pageindex: "1", pagesize: "10000", sort: moreSelectRootClass.slectGoodsByCondition.sort, asc: moreSelectRootClass.slectGoodsByCondition.asc)
            }
        }else{
            
            http.requestGoodsByCondition(moreSelectRootClass.slectGoodsByCondition.brandid,categoryid:moreSelectRootClass.slectGoodsByCondition.categoryidTemp, carryingamount: moreSelectRootClass.slectGoodsByCondition.carryingamount, minprice: moreSelectRootClass.slectGoodsByCondition.minprice, maxprice: moreSelectRootClass.slectGoodsByCondition.maxprice, pageindex: "1", pagesize: "1000", sort: moreSelectRootClass.slectGoodsByCondition.sort, asc: moreSelectRootClass.slectGoodsByCondition.asc)
        }
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        
        //接受通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsListVC.goodsList_SendErrorMsgProcess), name: "goodsList_SendErrorMsg", object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsListVC.bigBrandDataChangedProcess), name: "BigBrandDataChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsListVC.goodsListModelChangedProcess), name: "GoodsListModelChanged", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension GoodsListVC{
    
    func bigBrandDataChangedProcess(notice:NSNotification){
        //大品牌获取
        self.bigBrand = http.getBigBrand()
        
        var titles = [String]()
        var brandID = [String]()
        for item in self.bigBrand {
            titles.append(item.title)
            brandID.append( String(item.keyid))
        }
        
        //创建筛选信息
        setMoreSortInfo(titles,brandID:brandID)
    }
    
    func goodsListModelChangedProcess(notice:NSNotification){
        collection.mj_header.endRefreshing()
        collection.mj_footer.endRefreshing()
        
        
        self.goodsDatas = http.getGoodsList()
        
        if self.goodsDatas.count == 0 {
            let backgroundView = UIImageView(image: UIImage(named:"背景"))
            self.collection.backgroundView = backgroundView
        }else{
            self.collection.backgroundView = nil
        }
        
        
        self.collection.reloadData()
    }
    
    func goodsList_SendErrorMsgProcess(notice:NSNotification){
        
        
        let msg = notice.object!["errorMsg"]! as! String
        let status = notice.object!["status"]! as! String
        collection.mj_header.endRefreshing()
        collection.mj_footer.endRefreshing()
        
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)
    }
}


extension GoodsListVC :  UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //商品列表cell
        let cell = self.collection.dequeueReusableCellWithReuseIdentifier("GoodsListCell", forIndexPath: indexPath) as!  GoodsListCell
        
        cell.goodsImage.sd_setImageWithURL(NSURL(string: serverPicUrl + self.goodsDatas[indexPath.row].pictureurl))
        cell.goodsName.text = self.goodsDatas[indexPath.row].title
        cell.nowPriceStr = String(format: "%.2f", self.goodsDatas[indexPath.row].originalprice)//(self.goodsDatas[indexPath.row].originalprice).description
        cell.saleNumStr = (self.goodsDatas[indexPath.row].salesvolume).description
        cell.oldPriceStr =  (self.goodsDatas[indexPath.row].originalprice).description
        cell.shopName.text = "【" + self.goodsDatas[indexPath.row].shopname + "】"
        
        //粘贴商品活动或者是促销活动图片
        let isactivity = self.goodsDatas[indexPath.row].isactivity
        let ispromotional = self.goodsDatas[indexPath.row].ispromotional
        
        if isactivity == 0 {
            cell.goodsStatus = GoodsSelltatus.活动
        }else if ispromotional == 0 {
            cell.goodsStatus = GoodsSelltatus.促销
        }else{
            cell.goodsStatus = GoodsSelltatus.无
        }
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let cgsize1 =  CGSize(width: screenWith, height: 2 )
        return cgsize1
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let size =  CGSize(width: screenWith, height: 2 )
        return size
    }
    
    //    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    //
    //        var collectionReusableView = UICollectionReusableView()
    //        if kind == UICollectionElementKindSectionHeader{//头视图
    //        }
    //
    //        if kind == UICollectionElementKindSectionFooter{//尾巴视图
    //        }
    //
    //        return collectionReusableView
    //
    //    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productVC = GoodsDetailVC()
        productVC.shopid = (self.goodsDatas[indexPath.row].shopid).description
        productVC.productid = (self.goodsDatas[indexPath.row].productid).description
        self.navigationController?.pushViewController(productVC, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.goodsDatas.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let screenWith = UIScreen.mainScreen().bounds.width
        let size =  CGSize(width: (screenWith - 10)/2 , height: screenWith/2 + 40 )
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let edge = UIEdgeInsets(top: 1, left: 3.5, bottom: 2, right:3.5)
        return edge
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        
        return 2.5
    }
    
    
    
}


extension GoodsListVC{
    //返回商品排序信息
    func setMoreSortInfo(brandTitles:[String],brandID:[String]){
        //商品品牌
        let brandTitles = brandTitles//["哇哈哈","康师傅","好一多","北极熊","老干妈","雕牌","金龙鱼","黔五福","阿迪达斯","苹果手机"]
        //商品价格范围
        let priceRanges = ["20以下","20-100","100-200","200以上"]
        //商品起配金额
        let deliveryConditions = ["0元起配","100元起配","300元起配","500元起配"]
        
        let priceRangesCondition = MoreSelectCondition(title: priceRanges, selectedFlag: 10000)
        let deliveryCondition = MoreSelectCondition(title: deliveryConditions, selectedFlag: 10000)
        
        let brandTitlesCondition = MoreSelectCondition(title: brandTitles, selectedFlag: 10000)
        
        self.moreSelectRootClass.condition  = [brandTitlesCondition,deliveryCondition,priceRangesCondition]
        self.moreSelectRootClass.brandID = brandID
        
    }
}


extension GoodsListVC:TopFourButtonViewDelegate {
    
    
    //按照排序,请求商品
    func requestGoodsListBySort(name:String,sort:String){
        
        
        
        
        
        if name != "筛选" {
            //如果和上一次选择的不一样
            if name != self.moreSelectRootClass.sortName {
                self.moreSelectRootClass.sortName = name
                for item in self.moreSelectRootClass.condition {
                    //item.selectedFlag = 1000
                }
                
                
            }
            
            //排序升降标记
            self.moreSelectRootClass.sort = sort
            
            
            self.dropDownRef()
            
        }
        
        
        if name == "筛选" && (self.moreSelectRootClass.condition.count == 3){
            
            
//           let moreConditionSelectView = MoreConditionSelectView(frame: CGRect(x: screenWith, y: 20, width: screenWith, height: screenHeigh - 20))
            
            moreConditionSelectView.moreSelectRootClass = self.moreSelectRootClass
            
            moreConditionSelectView.delegate = self
            

            
            UIApplication.sharedApplication().keyWindow?.addSubview(moreConditionSelectView)
            
            //self.view.addSubview(moreConditionSelectView)
            
            UIView.animateWithDuration(0.3, animations: {
                self.moreConditionSelectView.frame = CGRect(x: 0, y: 20, width: screenWith, height: screenHeigh - 20)
            
            })
        }else{
            
        }
    }
}


// MARK: - 更多筛选条件
extension GoodsListVC:MoreConditionSelectViewDelegate{
    
    func clearConditionsFlag(flag:Bool){
        self.conditionFlag = flag
        self.dropDownRef()
    }
    
    
    func selectConditions(conditions:MoreSelectRootClass){
        let (brandid,carryingamount,minprice,maxprice,sort,asc) = conditions.requestPara()
        
        //把综合设置为条件筛选的状态
        self.conditionFlag = true
   
        http.requestGoodsByCondition(brandid,categoryid:moreSelectRootClass.slectGoodsByCondition.categoryidTemp, carryingamount: carryingamount, minprice: minprice, maxprice: maxprice, pageindex: "1", pagesize: "1000", sort: conditions.slectGoodsByCondition.sort, asc: conditions.slectGoodsByCondition.asc)
    }
}
