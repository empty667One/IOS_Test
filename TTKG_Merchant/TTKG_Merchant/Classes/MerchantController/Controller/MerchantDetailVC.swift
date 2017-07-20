//
//  MerchantDetailVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/5.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import WebKit



class MerchantDetailVC: UIViewController,MMButtonsOnderLineDelegate ,ThreeBtnForGoodsButtonViewDelegate{
    var merchantModel : MerchantModel!
    private let http = MerchantDataAPI.shareInstance
    
    private var allGoodsListData = [MerchantGoodsData]()
    
    private var hotGoodsListData = [MerchantGoodsData]()
    
    private var yhGoodsListData = [MerchantGoodsData]()
    
    private var merchantAdListData = [MerchantADDetailData]()
    
    let headerView = UIView(frame: CGRect(x: 0, y: 10, width: screenWith, height: 80))
    let merchantImage = UIImageView() //左侧小房子
    let merchantName = UILabel()      //配送商
    let QPLabel = UILabel()           //显示起配
    let YHLabel = UILabel()           //显示优惠
    let QPMessage = UILabel()         //起配信息
    let YHMessage = UILabel()         //优惠信息
    let tradeLabel = UILabel()        //交易次数
    
    
    var titleView = MMButtonsOnderLine()
    var scrollViews = UIScrollView()
    let layout = UICollectionViewFlowLayout()
    let layout1 = UICollectionViewFlowLayout()
    let layout2 = UICollectionViewFlowLayout()
    var hotGoodsCollectionView : UICollectionView! //热销商品CollectionView
    var allGoodsCollecyionView : UICollectionView! //全部商品CollectionView
    var YHGoodsCollectionView : UICollectionView!  //优惠商品CollectionView
    var activityWebView : UITableView!             //店铺活动tableView
    var merchantInfoTableView : UITableView!       //商店信息tableView
    var infoData = [MerchantBottominfo]()
    var shopid = ""
    var sortBtnStatus = ThreeSortBtn.noselect
    private var indexSelectTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        setNotify()
        createUI()
    }
    
    
    func getSortButtomStatus(status: ThreeSortBtn) {
        
        sortBtnStatus = status
        
        if self.indexSelectTag == 0  {
            
            allGoodsDropDownRef()
        }
        
        if self.indexSelectTag == 1 {
            hotGoodsDropDownRef()
        }
        
        if self.indexSelectTag == 2 {
            YHGoodsDropDownRef()
        }
        
    }
    
    //MARK: 加载控件
    func createUI() {
        self.view.addSubview(headerView)
        headerView.addSubview(merchantImage)
        headerView.addSubview(merchantName)
        headerView.addSubview(QPLabel)
        headerView.addSubview(QPMessage)
        headerView.addSubview(YHLabel)
        headerView.addSubview(YHMessage)
        headerView.addSubview(tradeLabel)
        
        /*************************左侧小房子**************************/
        merchantImage.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(5)
            make.top.equalTo(0).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        merchantImage.image = UIImage(named: "商家房子")
        
        /**************************配送商****************************/
        merchantName.snp_makeConstraints { (make) in
            make.left.equalTo(merchantImage.snp_right).offset(3)
            make.top.equalTo(0).offset(2)
            make.right.equalTo(0).offset(-20)
            make.height.equalTo(20)
        }
        
        merchantName.font = UIFont.systemFontOfSize(12)
        
        /************************起配Label******************************/
        QPLabel.snp_makeConstraints { (make) in
            make.left.equalTo(merchantImage.snp_right).offset(3)
            make.top.equalTo(merchantName.snp_bottom).offset(3)
            make.width.equalTo(30)
            make.height.equalTo(18)
        }
        QPLabel.backgroundColor = UIColor.redColor()
        QPLabel.text = "起配"
        QPLabel.font = UIFont.systemFontOfSize(10)
        QPLabel.textColor = UIColor.whiteColor()
        QPLabel.textAlignment = NSTextAlignment.Center
        
        /************************起配信息******************************/
        QPMessage.snp_makeConstraints { (make) in
            make.left.equalTo(QPLabel.snp_right).offset(3)
            make.top.equalTo(merchantName.snp_bottom).offset(3)
            make.right.equalTo(0).offset(-80)
            make.height.equalTo(18)
        }
        QPMessage.font = UIFont.systemFontOfSize(10)
        QPMessage.text = ""
        QPMessage.textColor = UIColor.blackColor()
        QPMessage.textAlignment = NSTextAlignment.Left
        
        /************************优惠label******************************/
        YHLabel.snp_makeConstraints { (make) in
            make.left.equalTo(merchantImage.snp_right).offset(3)
            make.top.equalTo(QPLabel.snp_bottom).offset(3)
            make.width.equalTo(30)
            make.height.equalTo(18)
        }
        YHLabel.font = UIFont.systemFontOfSize(10)
        YHLabel.backgroundColor = UIColor.orangeColor()
        YHLabel.text = "优惠"
        YHLabel.textColor = UIColor.whiteColor()
        YHLabel.textAlignment = NSTextAlignment.Center
        
        /**************************优惠信息****************************/
        YHMessage.snp_makeConstraints { (make) in
            make.left.equalTo(YHLabel.snp_right).offset(3)
            make.top.equalTo(QPMessage.snp_bottom).offset(3)
            make.right.equalTo(0).offset(-70)
            make.height.equalTo(18)
        }
        
        YHMessage.text = ""
        YHMessage.textColor = UIColor.blackColor()
        YHMessage.textAlignment = NSTextAlignment.Left
        YHMessage.font = UIFont.systemFontOfSize(10)
        
        /***************************交易次数***************************/
        tradeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(QPMessage.snp_right).offset(5)
            make.top.equalTo(merchantName.snp_bottom).offset(5)
            make.right.equalTo(0).offset(-1)
            make.height.equalTo(25)
        }
        
        tradeLabel.text = "0 次交易"
        tradeLabel.font = UIFont.systemFontOfSize(11)
        tradeLabel.textAlignment = NSTextAlignment.Center
        
        /******************************************************/
        titleView = MMButtonsOnderLine(frame: CGRect(x: 0, y: headerView.frame.maxY, width: screenWith, height: 50))
        titleView.delegate = self
        self.view.addSubview(titleView)
        
        /**************************可滚动区域****************************/
        self.view.addSubview(scrollViews)
        scrollViews.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(titleView.snp_bottom)
            make.bottom.equalTo(0)
        }
        scrollViews.delegate = self
        scrollViews.backgroundColor = UIColor.whiteColor()
        scrollViews.scrollEnabled = false
        scrollViews.pagingEnabled = true
//        scrollViews. = false
        scrollViews.showsHorizontalScrollIndicator = false
        scrollViews.contentSize = CGSizeMake(screenWith*5, screenHeigh - titleView.frame.maxY)
        
        /******************************************************/
        layout.minimumInteritemSpacing = 2.5
        layout.minimumLineSpacing = 2.5
        layout1.minimumInteritemSpacing = 2.5
        layout1.minimumLineSpacing = 2.5
        layout2.minimumInteritemSpacing = 2.5
        layout2.minimumLineSpacing = 2.5
        
        /**
         
         热销商品CollectionView
         **/
        hotGoodsCollectionView = UICollectionView(frame: CGRect(x: CGFloat(screenWith), y: 0, width: screenWith, height: screenHeigh - titleView.frame.maxY - 49 ),collectionViewLayout:layout)
        hotGoodsCollectionView.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1.0)
        hotGoodsCollectionView.delegate = self
        hotGoodsCollectionView.dataSource = self
        hotGoodsCollectionView.tag = 1
        hotGoodsCollectionView.registerClass(ThreeForHotGoodsButtonView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "hotGoodsHeaderView")
        hotGoodsCollectionView.registerClass(GoodsListCell.self, forCellWithReuseIdentifier: "hotGoodsCollectionView")
        hotGoodsCollectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(MerchantDetailVC.hotGoodsDropDownRef))
        hotGoodsCollectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(MerchantDetailVC.hotGoodsPullUpRef))
        
        /**
         
         全部商品CollectionView
         
         **/
        allGoodsCollecyionView = UICollectionView(frame: CGRect(x: CGFloat(screenWith), y: 0, width: screenWith, height: screenHeigh - titleView.frame.maxY - 49),collectionViewLayout:layout1)
        allGoodsCollecyionView.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1.0)
        allGoodsCollecyionView.delegate = self
        allGoodsCollecyionView.dataSource = self
        allGoodsCollecyionView.tag = 0
        allGoodsCollecyionView.registerClass(ThreeForAllGoodsButtonView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "AllGoodsHeaderView")
        allGoodsCollecyionView.registerClass(GoodsListCell.self, forCellWithReuseIdentifier: "allGoodsCollecyionView")
        allGoodsCollecyionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(MerchantDetailVC.allGoodsDropDownRef))
        allGoodsCollecyionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(MerchantDetailVC.allGoodsPullUpRef))
        
        /**
         
         优惠商品CollectionView
         
         **/
        YHGoodsCollectionView = UICollectionView(frame: CGRect(x: CGFloat(screenWith), y: 0, width: screenWith, height: screenHeigh - titleView.frame.maxY - 49),collectionViewLayout:layout2)
        YHGoodsCollectionView.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1.0)
        YHGoodsCollectionView.delegate = self
        YHGoodsCollectionView.dataSource = self
        YHGoodsCollectionView.tag = 2
        
        YHGoodsCollectionView.registerClass(ThreeForYHGoodsButtonView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "YHGoodsHeaderView")
        YHGoodsCollectionView.registerClass(GoodsListCell.self, forCellWithReuseIdentifier: "YHGoodsCollectionView")
        
        YHGoodsCollectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(MerchantDetailVC.YHGoodsDropDownRef))
        YHGoodsCollectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(MerchantDetailVC.YHGoodsPullUpRef))
        
        /**
         
         店铺活动TableView
         
         **/
        activityWebView = UITableView(frame: CGRect(x: CGFloat(screenWith), y: 0, width: screenWith, height: screenHeigh - titleView.frame.maxY - 49),style: UITableViewStyle.Plain)
        activityWebView.delegate = self
        activityWebView.dataSource = self
        activityWebView.backgroundColor = UIColor.whiteColor()
        activityWebView.tag = 3
        activityWebView.registerClass(MerchantAdCell.self, forCellReuseIdentifier: "MerchantAdCell")
        
        /**
         
        商店信息TableView
         
         **/
        merchantInfoTableView = UITableView(frame: CGRect(x: CGFloat(screenWith), y: 0, width: screenWith, height: screenHeigh - titleView.frame.maxY - 49), style: UITableViewStyle.Plain)
        merchantInfoTableView.delegate = self
        merchantInfoTableView.dataSource = self
        merchantInfoTableView.tag = 4
        merchantInfoTableView.registerClass(MerchantInfoCell.self, forCellReuseIdentifier: "MerchantInfoCell")

        
        
        let controllers = [allGoodsCollecyionView,hotGoodsCollectionView,YHGoodsCollectionView,activityWebView,merchantInfoTableView]
        
        
        for indexs in 0 ..< 5 {
            var viewicon = UIView(frame: CGRect(x: CGFloat(screenWith*CGFloat(indexs)), y: 0, width: screenWith, height: screenHeigh - titleView.frame.maxY - 64 ))
            let viewcontrollers = controllers[indexs]
            viewicon = viewcontrollers
            viewicon.frame = CGRectMake(screenWith*CGFloat(indexs), 0, screenWith, screenHeigh - titleView.frame.maxY - 64 )
            scrollViews.addSubview(viewicon)
        
            
        }

        
    }
    
    //MARK:通知
    func setNotify(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MerchantDetailVC.allGoodsDataChange), name: "allGoodsSenderFlag", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MerchantDetailVC.hotGoodsDataChange), name: "hotGoodsSenderFlag", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MerchantDetailVC.yhGoodsDataChange), name: "yhGoodsSenderFlag", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MerchantDetailVC.merchantAdDataChange), name: "adListDataSenderFlag", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MerchantDetailVC.Merchant_SendErrorMsgProcess(_:)), name: "Merchant_SendErrorMsg", object: nil)
        
    }
    
    //请求错误时显示
    func Merchant_SendErrorMsgProcess(notice : NSNotification){
        
        let msg = notice.object!["errorMsg"]! as! String
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)

        YHGoodsCollectionView.mj_header.endRefreshing()
        YHGoodsCollectionView.mj_footer.endRefreshing()
        allGoodsCollecyionView.mj_header.endRefreshing()
        allGoodsCollecyionView.mj_footer.endRefreshing()
        hotGoodsCollectionView.mj_header.endRefreshing()
        hotGoodsCollectionView.mj_footer.endRefreshing()
    }
    
    //所有商品数据通知处理
    func allGoodsDataChange(){
        
        self.allGoodsListData = http.getAllGoodsList()
        allGoodsCollecyionView.reloadData()
        allGoodsCollecyionView.mj_header.endRefreshing()
        allGoodsCollecyionView.mj_footer.endRefreshing()
    }
    //热销商品数据通知处理
    func hotGoodsDataChange(){
        self.hotGoodsListData = http.getHotGoodsList()
        hotGoodsCollectionView.reloadData()
        hotGoodsCollectionView.mj_header.endRefreshing()
        hotGoodsCollectionView.mj_footer.endRefreshing()
    }
    //优惠商品数据通知处理
    func yhGoodsDataChange(){
        self.yhGoodsListData = http.getYHGoodsList()
        YHGoodsCollectionView.reloadData()
        YHGoodsCollectionView.mj_header.endRefreshing()
        YHGoodsCollectionView.mj_footer.endRefreshing()
    }
    //商家广告数据通知处理
    func merchantAdDataChange(){
        self.merchantAdListData = http.getMerchantAdDataList()
        activityWebView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //搜索框
        let searchView = UIButton(frame: CGRect(x: screenWith/2 - 50, y: 20 + 9, width:screenWith/2 + 50, height: 26))
        searchView.setImage(UIImage(named: "search000"), forState: UIControlState.Normal)
        searchView.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 20)
        searchView.setTitle("搜索快购商品", forState: UIControlState.Normal)
        searchView.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        searchView.titleLabel?.font = UIFont.systemFontOfSize(14)
        searchView.titleEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        searchView.backgroundColor = UIColor(red: 229/255, green:230/255 , blue:235/255 , alpha: 1.0)
        searchView.layer.masksToBounds = true
        searchView.layer.cornerRadius = 10
        searchView.addTarget(self, action: #selector(MerchantDetailVC.gotoSearchVC), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.titleView = searchView
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blueColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        http.requestAllGoodsDefaultData(shopid)
        http.requestHotGoodsDefaultData(shopid)
        http.requestYHGoodsDefaultData(shopid)
        http.requestMerchantAdData(shopid)
        requestMerchantInfo(shopid)
    }
    
    //MARK:Event Response
    
    //点击抖索按钮界面跳转
    func gotoSearchVC(){
//        var enterFlag = EnterFromWhereFlag.全局搜索
//        var merchantId = String()//商家ID
        let searchVC = SearchGoodsVC()
        searchVC.enterFlag = EnterFromWhereFlag.商家内搜索
        searchVC.merchantId = self.shopid
        self.navigationController?.pushViewController(searchVC, animated: true)
        
    }

}

extension MerchantDetailVC {
    //下拉
    func hotGoodsDropDownRef(){
        http.removeHotGoodsList()
        
        
        switch sortBtnStatus {
        case .noselect:
            http.requestHotGoodsDefaultData(shopid)
        case .priceDown:
            http.requestHotGoodsDefaultPriceLow(shopid)
        case .priceUp:
            http.requestHotGoodsDefaultPriceHeight(shopid)
        case .saleNumDown:
            http.requestHotGoodsDefaultSaleLow(shopid)
        case .saleNumUp:
            http.requestHotGoodsDefaultSaleHeight(shopid)
        
        }
        
        
    }
    //上拉
    func hotGoodsPullUpRef(){
        switch sortBtnStatus {
        case .noselect:
            http.requestHotGoodsDefaultMoreData(shopid)
        case .priceDown:
            http.requestHotGoodsLowPriceMoreData(shopid)
        case .priceUp:
            http.requestHotGoodsHeightPriceMoreData(shopid)
        case .saleNumDown:
            http.requestHotGoodsSaleLowMoreData(shopid)
        case .saleNumUp:
            http.requestHotGoodsSaleHeightMoreData(shopid)
        
        }
        
        
    }
    //下拉
    func allGoodsDropDownRef(){
        
        switch sortBtnStatus {
        case .noselect:
            http.requestAllGoodsDefaultData(shopid)
        case .priceDown:
            http.requestAllGoodsDefaultPriceLow(shopid)
        case .priceUp:
            http.requestAllGoodsDefaultPriceHeight(shopid)
        case .saleNumDown:
            http.requestAllGoodsDefaultSaleLow(shopid)
        case .saleNumUp:
            http.requestAllGoodsDefaultSaleHeight(shopid)
            
        }

    }
    //上拉
    func allGoodsPullUpRef(){
        switch sortBtnStatus {
        case .noselect:
            http.requestAllGoodsDefaultMoreData(shopid)
        case .priceDown:
            http.requestAllGoodsLowPriceMoreData(shopid)
        case .priceUp:
            http.requestAllGoodsHeightPriceMoreData(shopid)
        case .saleNumDown:
            http.requestAllGoodsSaleLowMoreData(shopid)
        case .saleNumUp:
            http.requestAllGoodsSaleHeightMoreData(shopid)
            
        }
    }
    //下拉
    func YHGoodsDropDownRef(){
        
        switch sortBtnStatus {
        case .noselect:
            http.requestYHGoodsDefaultData(shopid)
        case .priceDown:
            http.requestYHGoodsDefaultPriceLow(shopid)
        case .priceUp:
            http.requestYHGoodsDefaultPriceHeight(shopid)
        case .saleNumDown:
            http.requestYHGoodsDefaultSaleLow(shopid)
        case .saleNumUp:
            http.requestYHGoodsDefaultSaleHeight(shopid)
        }
    }
    //上拉
    func YHGoodsPullUpRef(){
        switch sortBtnStatus {
        case .noselect:
            http.requestYHGoodsDefaultMoreData(shopid)
        case .priceDown:
            http.requestYHGoodsLowPriceMoreData(shopid)
        case .priceUp:
            http.requestYHGoodsHeightPriceMoreData(shopid)
        case .saleNumDown:
            http.requestYHGoodsSaleLowMoreData(shopid)
        case .saleNumUp:
            http.requestYHGoodsSaleHeightMoreData(shopid)
            
        }
    }
    
}

//MARK:Delegate
extension MerchantDetailVC : UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let size = CGSize(width: screenWith , height: 30)
        return size
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
                if kind == UICollectionElementKindSectionHeader {
                     if collectionView.tag == 1 {
                        
                    let hotBtnView : ThreeForHotGoodsButtonView = hotGoodsCollectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "hotGoodsHeaderView", forIndexPath: indexPath) as! ThreeForHotGoodsButtonView
                        hotBtnView.delegate = self
                        return hotBtnView
                    }
                    
                    if collectionView.tag == 0 {
                        
                        let allBtnView : ThreeForAllGoodsButtonView = allGoodsCollecyionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "AllGoodsHeaderView", forIndexPath: indexPath) as! ThreeForAllGoodsButtonView
                        allBtnView.delegate = self
                        return allBtnView
                        
                    }
                    
                    if collectionView.tag == 2 {
                        
                        let YHBtnView : ThreeForYHGoodsButtonView =  YHGoodsCollectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "YHGoodsHeaderView", forIndexPath: indexPath) as! ThreeForYHGoodsButtonView//
                        YHBtnView.delegate = self
                        return YHBtnView
                        
                    }
            }
            
        return UICollectionReusableView()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return self.hotGoodsListData.count
        }
        if collectionView.tag == 0 {
            return self.allGoodsListData.count
        }
        if collectionView.tag == 2{
            return self.yhGoodsListData.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let hotGoodsCell : GoodsListCell = hotGoodsCollectionView.dequeueReusableCellWithReuseIdentifier("hotGoodsCollectionView", forIndexPath: indexPath) as! GoodsListCell
            hotGoodsCell.goodsImage.sd_setImageWithURL(NSURL(string: serverPicUrl + self.hotGoodsListData[indexPath.row].pictureurl))
            hotGoodsCell.goodsName.text = self.hotGoodsListData[indexPath.row].title
            hotGoodsCell.nowPriceStr = (self.hotGoodsListData[indexPath.row].originalprice).description
            hotGoodsCell.saleNumStr = (self.hotGoodsListData[indexPath.row].salesvolume).description
            hotGoodsCell.oldPriceStr =  (self.hotGoodsListData[indexPath.row].originalprice).description
            
            //粘贴商品活动或者是促销活动图片
            let isactivity = self.hotGoodsListData[indexPath.row].isactivity
            let ispromotional = self.hotGoodsListData[indexPath.row].ispromotional
            
            if isactivity == 0 {
                hotGoodsCell.goodsStatus = GoodsSelltatus.活动
            }else if ispromotional == 0 {
                hotGoodsCell.goodsStatus = GoodsSelltatus.促销
            }else{
                hotGoodsCell.goodsStatus = GoodsSelltatus.无
            }
            
            return hotGoodsCell
        }
        if collectionView.tag == 0 {
            let allGoodsCell : GoodsListCell = allGoodsCollecyionView.dequeueReusableCellWithReuseIdentifier("allGoodsCollecyionView", forIndexPath: indexPath) as! GoodsListCell
            allGoodsCell.goodsImage.sd_setImageWithURL(NSURL(string: serverPicUrl + self.allGoodsListData[indexPath.row].pictureurl))
            allGoodsCell.goodsName.text = self.allGoodsListData[indexPath.row].title
            allGoodsCell.nowPriceStr = (self.allGoodsListData[indexPath.row].originalprice).description
            allGoodsCell.saleNumStr = (self.allGoodsListData[indexPath.row].salesvolume).description
            allGoodsCell.oldPriceStr =  (self.allGoodsListData[indexPath.row].originalprice).description
            
            //粘贴商品活动或者是促销活动图片
            let isactivity = self.allGoodsListData[indexPath.row].isactivity
            let ispromotional = self.allGoodsListData[indexPath.row].ispromotional
            
            if isactivity == 0 {
                allGoodsCell.goodsStatus = GoodsSelltatus.活动
            }else if ispromotional == 0 {
                allGoodsCell.goodsStatus = GoodsSelltatus.促销
            }else{
                allGoodsCell.goodsStatus = GoodsSelltatus.无
            }
            
            return allGoodsCell
        }
        if collectionView.tag == 2{
            let YHGoodsCell : GoodsListCell = YHGoodsCollectionView.dequeueReusableCellWithReuseIdentifier("YHGoodsCollectionView", forIndexPath: indexPath) as! GoodsListCell
            YHGoodsCell.goodsImage.sd_setImageWithURL(NSURL(string: serverPicUrl + self.yhGoodsListData[indexPath.row].pictureurl))
            YHGoodsCell.goodsName.text = self.yhGoodsListData[indexPath.row].title
            YHGoodsCell.nowPriceStr = (self.yhGoodsListData[indexPath.row].originalprice).description
            YHGoodsCell.saleNumStr = (self.yhGoodsListData[indexPath.row].salesvolume).description
            YHGoodsCell.oldPriceStr =  (self.yhGoodsListData[indexPath.row].originalprice).description

            //粘贴商品活动或者是促销活动图片
            let isactivity = self.yhGoodsListData[indexPath.row].isactivity
            
            if isactivity == 0 {
                YHGoodsCell.goodsStatus = GoodsSelltatus.活动
            }else{
                YHGoodsCell.goodsStatus = GoodsSelltatus.无
            }
            
            
            
            
            
            return YHGoodsCell
        }
        let cell = UICollectionViewCell()
        
        return cell
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let screenWith = UIScreen.mainScreen().bounds.width
        let size =  CGSize(width: (screenWith - 10)/2 , height: screenWith/2 + 40 )
        return size
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 3, left: 3.5, bottom: 2, right:3.5)
        //let edge = UIEdgeInsets(top: 2, left: 2, bottom: 2, right:2)
        //return edge
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if collectionView.tag == 1 {
            let productVC = GoodsDetailVC()
            productVC.shopid = (self.hotGoodsListData[indexPath.row].shopid).description
            productVC.productid = (self.hotGoodsListData[indexPath.row].productid).description
            self.navigationController?.pushViewController(productVC, animated: true)
        }
        
        if collectionView.tag == 0 {
            let productVC = GoodsDetailVC()
            productVC.shopid = (self.allGoodsListData[indexPath.row].shopid).description
            productVC.productid = (self.allGoodsListData[indexPath.row].productid).description
            self.navigationController?.pushViewController(productVC, animated: true)
        }
        
        if collectionView.tag == 2 {
            let productVC = GoodsDetailVC()
            productVC.shopid = (self.yhGoodsListData[indexPath.row].shopid).description
            productVC.productid = (self.yhGoodsListData[indexPath.row].productid).description
            self.navigationController?.pushViewController(productVC, animated: true)
        }
        
    }
    
    
    /*********************************************************************************************/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 3 {
            return self.merchantAdListData.count
        }
        
        if tableView.tag == 4 {
            return infoData.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 3 {
            return screenWith/2 + 2
        }
        
        if tableView.tag == 4 {
            return 60
        }
        
        return 0
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag == 3 {
            let merchantAdCell : MerchantAdCell = activityWebView.dequeueReusableCellWithIdentifier("MerchantAdCell", forIndexPath: indexPath) as! MerchantAdCell
            merchantAdCell.adImageView.sd_setImageWithURL(NSURL(string: serverPicUrl + self.merchantAdListData[indexPath.row].picurl))
            return merchantAdCell
            
        }
        
        if tableView.tag == 4 {
            let merchantCell : MerchantInfoCell = merchantInfoTableView.dequeueReusableCellWithIdentifier("MerchantInfoCell", forIndexPath: indexPath) as! MerchantInfoCell
            merchantCell.infoLabel.text = infoData[indexPath.row].title
            merchantCell.detailLabel.text = infoData[indexPath.row].value
            return merchantCell
        }
        
        let cell = UITableViewCell()
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView.tag == 3 {
            let datatype = self.merchantAdListData[indexPath.row].datatype
            if datatype == 1  {
                let htmlVC = HtmlVC()
                htmlVC.htmlStr = self.merchantAdListData[indexPath.row].remark
                self.navigationController?.pushViewController(htmlVC, animated: true)
            }else{
                let productVC = GoodsDetailVC()
                productVC.shopid = (self.merchantAdListData[indexPath.row].shopid).description
                productVC.productid = (self.merchantAdListData[indexPath.row].productid).description
                self.navigationController?.pushViewController(productVC, animated: true)
            }
        }
        
    }
    
    
    //获取字符串宽高
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
}

//商品数量
extension MerchantDetailVC {
    
    func orderStatesSeparatedBy(index:Int){
        self.indexSelectTag = index
        
        
        if index == 0 {
            allGoodsDropDownRef()
            //self.titleView.waitToPayLabel.textColor = UIColor.redColor()
            self.titleView.allOderLabel.textColor = UIColor.redColor()
        }else{
            //self.titleView.waitToPayLabel.textColor = UIColor.blackColor()
            self.titleView.allOderLabel.textColor = UIColor.blackColor()
        }
        
        if index == 1 {
            hotGoodsDropDownRef()
            //self.titleView.allOderLabel.textColor = UIColor.redColor()
            self.titleView.waitToPayLabel.textColor = UIColor.redColor()
        }else{
            //self.titleView.allOderLabel.textColor = UIColor.blackColor()
            self.titleView.waitToPayLabel.textColor = UIColor.blackColor()
        }
        
        if index == 2 {
            YHGoodsDropDownRef()
            self.titleView.waitToDeliverLabel.textColor = UIColor.redColor()
        }else{
            self.titleView.waitToDeliverLabel.textColor = UIColor.blackColor()
        }
        
        if index == 3 {
            self.titleView.waitToAcceptLabel.textColor = UIColor.redColor()
            
        }else{
            self.titleView.waitToAcceptLabel.textColor = UIColor.blackColor()
        }
        
        if index == 4 {
            self.titleView.finishedImage.image = UIImage(named: "红房子")
            merchantInfoTableView.reloadData()
        }else{
            self.titleView.finishedImage.image = UIImage(named: "房子")
        }

        
        scrollViews.contentOffset = CGPoint(x: screenWith*CGFloat(index), y: 0)
    }
    
}


extension MerchantDetailVC : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
}

// MARK: - 网络请求
extension MerchantDetailVC {
    func requestMerchantInfo(shopid:String) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let url = serverUrl + "/product/shopinfo"
        let parameter = ["shopid":shopid,"sign":MD5_time,"timespan":timeTemp.description]
        
        Alamofire.request(.GET, url, parameters:parameter)
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    var dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        self.merchantModel = MerchantModel.init(fromDictionary: dict!)
                        if (self.merchantModel.code == 0) {
                            
                            
                            self.merchantName.text = self.merchantModel.data.topinfo.shopname
                            self.QPMessage.text = self.merchantModel.data.topinfo.carryamount
                            self.YHMessage.text = self.merchantModel.data.topinfo.privilege
                            
                            let str = self.merchantModel.data.topinfo.order.description
                            let htmlText = "<font color=\"red\">\(str)</font><font color=\"black\">次交易</font>"
                            let attrStr = try NSAttributedString(data: htmlText.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                                
                            self.tradeLabel.attributedText = attrStr
                            self.titleView.allOderLabel.text = "\(self.merchantModel.data.topinfo.allproductcount!)"
                            self.titleView.waitToPayLabel.text = "\(self.merchantModel.data.topinfo.hotcount!)"
                            self.titleView.waitToDeliverLabel.text = "\(self.merchantModel.data.topinfo.privilegecount!)"
                            self.titleView.waitToAcceptLabel.text = "\(self.merchantModel.data.topinfo.activitycount!)"
                            self.infoData = self.merchantModel.data.bottominfo
                            self.merchantInfoTableView.reloadData()
                            
                            
                        }
                    }catch _ {
                        dict = nil
                    }
                    
                    
                case .Failure( _):
                    break
                    
                }
                
        }
    }
}

extension MerchantDetailVC  {
    
}


