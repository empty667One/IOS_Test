//
//  SearchGoodsVC.swift
//  CLLoopScrollView
//
//  Created by iosnull on 16/6/25.
//  Copyright © 2016年 ChrisLian. All rights reserved.
//

import UIKit

import Alamofire


//历史搜索记录
var historySearchRecord = [String]()



enum EnterFromWhereFlag {
    case 全局搜索
    case 商家内搜索
}


class SearchGoodsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,MoreLableShowViewDelegate,UISearchBarDelegate {
    
    
    
    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //从商家进入的搜索还是从全局进入的搜索
    var enterFlag = EnterFromWhereFlag.全局搜索
    var merchantId = String()//商家ID
    
    private let http = SearchGoodsDataAPI.shareInstance
    
    //scrollView容器
    private var scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: screenWith, height: screenHeigh - 64))
    
    //热门标签选中标记(最大值10000为不选中)
    private var hotSearchSelectFlag = 10000
    
    private var searchView:UISearchBar!
    private var tableView:UITableView?
    private var tableViewHeaderView:UIView?
    
    //商品搜索的tableview
    private var tableViewSearchGoods:UITableView?
    
    //热门商品信息
    private var hotSearchList = [MerchantGoodsData]()
    
    private var searchGoods = [MerchantGoodsData]()//搜索到的商品
    private var historySearch = [String]()//历史搜索
    
    private var cell01Heigth = CGFloat(0)
    
    //多lable显示代理实现
    func heigthOfThisView(heigth:CGFloat){
        
        if cell01Heigth != heigth {
            cell01Heigth = heigth
            self.tableView?.reloadData()
        }
    }
    
    func didSelectLableIndex(num: Int) {
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        hotSearchSelectFlag = num
        self.tableView?.reloadData()
        
        
        if enterFlag == .全局搜索 {
            http.requestAllMerchantGoodsByName(hotSearchList[num].title)
        }else{
            //去商品详情页面
            let goodsDetailVC = GoodsDetailVC()
            goodsDetailVC.shopid =  hotSearchList[num].shopid.description
            goodsDetailVC.productid = hotSearchList[num].productid.description
            goodsDetailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(goodsDetailVC, animated: true)
        }
        
        
    }
    
    
    
    
    //查看历史搜索记录
    func getHisToryInfo() -> [String]{
        var historyArry = [String]()
        
        if let historySearchRecord = (NSUserDefaults.standardUserDefaults().objectForKey("historySearchRecord") as? [String] ){
            
            historyArry = historySearchRecord
        }
                
        return historyArry
    }
    
    func insertHistoryItem(historySearch:String)  {
        
        var insertFlag = true
        var recordTemp = [String]()
        if let historySearchRecord = (NSUserDefaults.standardUserDefaults().objectForKey("historySearchRecord") as? [String] ){
            
            recordTemp = historySearchRecord
            
            for item in historySearchRecord {
                if historySearch == item {
                    insertFlag = false
                }
            }
        }
        
        if insertFlag {
            recordTemp.append(historySearch)
            NSUserDefaults.standardUserDefaults().setObject(recordTemp, forKey: "historySearchRecord")
            NSUserDefaults.standardUserDefaults().synchronize()
        }else{
            
        }
    }
    
    
    //热门商品模型通知处理
    func hotGoodsChangedProcess() {
        
        let hotSearchList = http.getHotGoodsInfo()
        self.hotSearchList = hotSearchList
        self.tableView?.reloadData()
    }
    
    
    func notSearchedGoodsProcess()  {
        let message = "没有搜索到该商品"
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(message)
    }
    
    //普通搜索商品通知处理
    func normalSearchGoodsChangedProcess() {
        searchGoods = http.getNormalSearchGoods()
        if searchGoods.count > 0 {//有搜索到数据，可以刷新
            self.tableViewSearchGoods?.reloadData()
            //偏移到搜索页面
            UIView.animateWithDuration(1, animations: { 
                self.scrollView.contentOffset = CGPointMake(0, screenHeigh - 64)
            })
            
        }else{
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.addSubview(scrollView)
        scrollView.scrollEnabled = false
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSize(width: screenWith, height: 2*(screenHeigh - 64))
        
        scrollView.backgroundColor = UIColor.redColor()
        
        historySearch  = getHisToryInfo()
        
        //热门商品模型通知接收
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchGoodsVC.hotGoodsChangedProcess), name: "hotGoodsChanged", object: nil)
        
        //商品搜索
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchGoodsVC.normalSearchGoodsChangedProcess), name: "normalSearchGoodsChanged", object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchGoodsVC.notSearchedGoodsProcess), name: "notSearchedGoods", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SearchGoodsVC.searchGoods_SendErrorMsgProcess(_:)), name: "searchGoods_SendErrorMsg", object: nil)
        
        
        //热门商品搜索tableView
        let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - 64 )
        tableView = UITableView(frame: rect, style: UITableViewStyle.Plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView?.registerClass(MyHistorySearchCell.self, forCellReuseIdentifier: "cell2")
        tableView?.registerClass(GoodsSelectCell.self, forCellReuseIdentifier: "cell1")
        tableView?.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        self.scrollView.addSubview(tableView!)
        self.tableView?.tag = 100
        
        //tableViewSearchGoods上拉
        let footer = MJRefreshBackNormalFooter()
        footer.setTitle("往上拉去看看搜索到的商品", forState: MJRefreshState.Pulling)
        footer.setTitle("往上拉去看看搜索到的商品", forState: MJRefreshState.Refreshing)
        footer.setTitle("往上拉去看看搜索到的商品", forState: MJRefreshState.Idle)
        footer.setRefreshingTarget(self, refreshingAction: #selector(SearchGoodsVC.pullUpRef))
        self.tableView!.mj_footer = footer
        
        //商品搜索产品列表tableView
        let searchGoodsFrame = CGRect(x: 0, y: self.tableView!.frame.maxY, width: screenWith, height: UIScreen.mainScreen().bounds.height - 64)
        tableViewSearchGoods = UITableView(frame:searchGoodsFrame , style: UITableViewStyle.Plain)
        self.scrollView.addSubview(tableViewSearchGoods!)
        tableViewSearchGoods?.delegate = self
        tableViewSearchGoods?.dataSource = self
        tableViewSearchGoods?.separatorStyle = .None
        
        //tableViewSearchGoods上拉
        let header = MJRefreshNormalHeader()
        header.setTitle("放开去热门商品试试手气", forState: MJRefreshState.Pulling)
        header.setTitle("去热门商品", forState: MJRefreshState.Refreshing)
        header.setTitle("去热门商品", forState: MJRefreshState.Idle)
        header.setRefreshingTarget(self, refreshingAction: #selector(SearchGoodsVC.pullDownRef))
        self.tableViewSearchGoods!.mj_header = header
        self.tableViewSearchGoods!.tag = 200
        self.tableViewSearchGoods!.registerClass(NormalSearchGoodsCell.self, forCellReuseIdentifier: "NormalSearchGoodsCell")
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        //导航栏左边返回按钮
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SearchGoodsVC.back))
        //导航栏右边返回按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "搜索", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SearchGoodsVC.searchBtnClk))
//        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.redColor()
        
        
        //导航栏中间按钮
        
        
        searchView = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        //searchView.barTintColor = UIColor.redColor(); // 修改背景色
        //searchView.searchBarStyle = UISearchBarStyle.Minimal;  // 去掉边线
        searchView.delegate = self
        
        
        //1. 设置背景颜色
        //设置背景图是为了去掉上下黑线
        searchView.backgroundImage = UIImage()
        // 设置SearchBar的颜色主题为白色
        searchView.barTintColor = UIColor.grayColor()
        
        
        //2. 设置圆角和边框颜色
        let searchField:UITextField? = (searchView.valueForKey("searchField") as? UITextField)
        if searchField != nil {
            searchField!.layer.cornerRadius = 14.0;
            //searchField!.layer.borderColor = UIColor.redColor().CGColor
            //searchField!.layer.borderWidth = 1;
            searchField!.layer.masksToBounds = true;
            searchField?.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1)
        }
        
        
        self.navigationItem.titleView?.sizeToFit()
        self.navigationItem.titleView = searchView
        
        //请求热门商品数据
        if enterFlag == EnterFromWhereFlag.全局搜索 {
            http.requestAllHotGoods()
        }else{
            http.requestMerchantHotGoods(self.merchantId)
        }
        
    }
    
    // 请求错误时显示信息
    func searchGoods_SendErrorMsgProcess(notice:NSNotification){
        
        let msg = notice.object!["errorMsg"]! as! String
        let status = notice.object!["status"]! as! String
  
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)
    }
    
    
    //上拉去看看搜索到的商品
    func pullUpRef() {
        if searchGoods.count != 0 {
        UIView.animateWithDuration(1, animations: {
        self.scrollView.contentOffset = CGPointMake(0, screenHeigh - 64)
            })
        self.tableView?.mj_footer.endRefreshing()
        }else{
            self.tableView?.mj_footer.endRefreshing()
            let HUD = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            let message = "你还没有搜索商品哦"
            HUD.mode = MBProgressHUDMode.Indeterminate
            HUD.label.text = message
            HUD.hideAnimated(true, afterDelay: 0.5)
        }
    }
    //下拉回到热门商品页面
    func pullDownRef(){
        UIView.animateWithDuration(1, animations: {
        self.scrollView.contentOffset = CGPointMake(0, 0)
            })
        self.tableViewSearchGoods?.mj_header.endRefreshing()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBtnClk()
    }
    
    func searchBtnClk()  {
        
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        if searchView.text?.characters.count == 0 {
            
            
            let message = "请输入需要搜索的关键字"
            
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(message)
            
            
        }else{
            searchView.resignFirstResponder()
            
            
            //插入数据库
            let str = searchView.text
            insertHistoryItem(str!)
            
            historySearch = getHisToryInfo()
            self.tableView?.reloadData()
            //进行网络请求
            if enterFlag == EnterFromWhereFlag.全局搜索 {
                http.requestAllMerchantGoodsByName(str!)
            }else{
                http.requestMerchantGoodsByName(str!, shopid: self.merchantId)
            }
            
        }
        
    }
    
//    func back()  {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    override func viewDidLayoutSubviews() {
        self.tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag == 100 {//热门页面
            if indexPath.section == 0 {
                return cell01Heigth
            }
            return 30
        }else{//商品搜索页面
            return screenWith/4
        }
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 100 {//热门页面
            if section == 0 {//热门搜索
                return 1
            }else{//搜索历史
                return historySearch.count
            }
        }
        
        if tableView.tag == 200{//商品搜索页面
            return searchGoods.count
        }else{
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView.tag == 100 {//热门页面
            return 2
        }else{//商品搜索页面
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 100 {//热门页面
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! GoodsSelectCell
                let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 100)
                
                
                cell.titleFont = CGFloat(13)
                cell.cornerRadius = 15
                
                //去除热门商品名称
                var hotGoodsNames = [String]()
                for item in hotSearchList {
                    hotGoodsNames.append(item.title)
                }
                
                cell.setSubView(rect, lableNames: hotGoodsNames,selectedIndex: hotSearchSelectFlag)
                cell.moreLableShowView!.delegate = self
                cell.backgroundColor = UIColor.whiteColor()
                return cell
            }else{
                let cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! MyHistorySearchCell
                cell.title.text = historySearch[indexPath.row]
                return cell
            }
        }else{//商品搜索页面
            let cell = tableViewSearchGoods?.dequeueReusableCellWithIdentifier("NormalSearchGoodsCell") as! NormalSearchGoodsCell
            
            let (name,imgurl,nowPrice,isactivity,ispromotional) = searchGoods[indexPath.row].showGoodsSomeInfo()

            cell.imgURL = imgurl
            cell.name = name
            cell.nowPriceStr = String(format: "%.2f", nowPrice)
            
            cell.accessoryType = .DisclosureIndicator
            
            cell.sellCnt.text = "销量:"  +  String(searchGoods[indexPath.row].salesvolume)
            
            cell.shopName.text = "[" +  searchGoods[indexPath.row].shopname +  "]"
            
            //粘贴商品活动或者是促销活动图片
            if isactivity == 0 {
                cell.goodsStatus = GoodsSelltatus.活动
            }else if ispromotional == 0 {
                cell.goodsStatus = GoodsSelltatus.促销
            }else{
                cell.goodsStatus = GoodsSelltatus.无
            }
            

            return cell
        }
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView.tag == 100 {//热门页面
            let headerView  = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 30))
            
            let title = UILabel(frame: CGRect(x: 10, y: 0, width: 200, height: 30  ))
            title.textColor = UIColor(red: 230/255, green: 33/255, blue: 30/255, alpha: 1)
            headerView.addSubview(title)
            headerView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
            if section == 0 {
                title.text = "热门搜索"
                
            }else{
                title.text = "搜索历史"
            }
            return headerView
        }else{
            return nil
        }
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView.tag == 100 {//热门页面
            if section ==  0 {
                return 0
            }else{
                guard historySearch.count > 0 else{
                    return 0
                }
                return 40
            }
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 100 {//热门页面
            if section == 0 {
                
                guard self.hotSearchList.count != 0 else{
                    return 0
                }
                
                return 30
            }else if section == 1 {
                guard historySearch.count > 0 else{
                    return 0
                }
                return 30
            }else{
                return 0
            }
        }else{
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if tableView.tag == 100 {//热门页面
            
            if section ==  0 {
                return nil
            }else{
                guard historySearch.count > 0 else{
                    return nil
                }
                
                let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 40))
                footerView.backgroundColor = UIColor.whiteColor()
                let clearHistoryBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 40))
                
                
                clearHistoryBtn.setImage(UIImage(named: "rubbish"), forState: UIControlState.Normal)
                //top left bottom right
                clearHistoryBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 5)
                
                clearHistoryBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
                clearHistoryBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
                clearHistoryBtn.setTitle("清除搜索历史", forState: UIControlState.Normal)
                //clearHistoryBtn.backgroundColor = UIColor.grayColor()
                clearHistoryBtn.titleEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 0)
                
                clearHistoryBtn.addTarget(self, action: #selector(SearchGoodsVC.clearHistoryBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
                
                footerView.addSubview(clearHistoryBtn)
                return footerView
            }
        }else{
            return nil
        }
        
    }
    
    func clearHistoryBtnClk(){
        

        
        let recordTemp = [String]()
        NSUserDefaults.standardUserDefaults().setObject(recordTemp, forKey: "historySearchRecord")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        historySearch = getHisToryInfo()
        self.tableView?.reloadData()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        if tableView.tag == 100 {//热门页面
            let searchTitle = historySearch[indexPath.row]
            
            searchView.text? = searchTitle
            //进行网络请求
            
            
            //进行网络请求
            if enterFlag == EnterFromWhereFlag.全局搜索 {
                http.requestAllMerchantGoodsByName(searchTitle)
            }else{
                http.requestMerchantGoodsByName(searchTitle, shopid: self.merchantId)
            }
            
            
        }else{
            //去商品详情页面
            let goodsDetailVC = GoodsDetailVC()
            goodsDetailVC.shopid =  searchGoods[indexPath.row].shopid.description
            goodsDetailVC.productid = searchGoods[indexPath.row].productid.description
            goodsDetailVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(goodsDetailVC, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension SearchGoodsVC {
    
}

