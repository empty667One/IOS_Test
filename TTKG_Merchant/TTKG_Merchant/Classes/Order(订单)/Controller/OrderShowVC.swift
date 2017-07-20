//
//  OrderShowVC.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/4.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire


class OrderShowVC: UIViewController {
    
    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    //当前展示的tableView
    var usrId = 0
    var currentShowTableViewIndex = 0 {
        didSet{
            dropDownRef()
        }
    }
    
    private var http = OrderDataAPI.shareInstance
    
    //全部订单订单详情
    private var allOrderListData = [OrderList]()
    //爽购订单
    private var shuangGouOrderListData = [OrderList]()
    //待付款订单
    private var nonPaymentOrderData = [OrderList]()
    //待发货订单
    private var noDeliverOrderData = [OrderList]()
    //待签收订单
    private var noReceiveOrderData = [OrderList]()
    //已签收订单
    private var completedOrderData = [OrderList]()
    

    //顶部可以滑动的view+可以点击的button
    private var buttonsOnderLine = OrderButtonsOnderLine(frame: CGRect(x: 0, y: 0, width: screenWith, height: 30))
    
    //底部容器(用于装tableview)
    private var scrollContentView = UIScrollView()
    
    
    //订单列表tableView
    private var tableViewForAllOrder   = UITableView(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh - 94), style: UITableViewStyle.Grouped)
    
    private var tableViewForShuangGouOrder   = UITableView(frame: CGRect(x: screenWith, y: 0, width: screenWith, height: screenHeigh - 94), style: UITableViewStyle.Grouped)
    
    private var tableViewForWaitToPay   = UITableView(frame: CGRect(x: screenWith*2, y: 0, width: screenWith, height: screenHeigh - 94), style: UITableViewStyle.Grouped)
    
    private var tableViewForWaitToDeliver = UITableView(frame: CGRect(x: screenWith*3, y: 0, width: screenWith, height: screenHeigh - 94), style: UITableViewStyle.Grouped)
    
    private var tableViewForWaitToAccept = UITableView(frame: CGRect(x: screenWith*4, y: 0, width: screenWith, height: screenHeigh - 94), style: UITableViewStyle.Grouped)
    
    private var tableViewForFinished = UITableView(frame: CGRect(x: screenWith*5, y: 0, width: screenWith, height: screenHeigh - 94), style: UITableViewStyle.Grouped)
    
    private var tableViews = [UITableView]()
    
    private func setTableViewInfo()  {
        tableViews.append(tableViewForAllOrder)
        tableViews.append(tableViewForShuangGouOrder)
        tableViews.append(tableViewForWaitToPay)
        tableViews.append(tableViewForWaitToDeliver)
        tableViews.append(tableViewForWaitToAccept)
        tableViews.append(tableViewForFinished)
        
        for i in 0..<tableViews.count {
            
            scrollContentView.addSubview(tableViews[i])

            tableViews[i].registerClass(OrderShowCell.self, forCellReuseIdentifier: "cell")
            tableViews[i].backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            tableViews[i].separatorStyle = .None
            
            tableViews[i].dataSource = self
            tableViews[i].delegate = self
            tableViews[i].tag = i
            
            //下拉
            tableViews[i].mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(OrderShowVC.dropDownRef))
            //上拉
            tableViews[i].mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(OrderShowVC.pullUpRef))
            
            
        }
        
    }
    
    
    
    //下拉刷新
    func dropDownRef()  {
        if !onlineState {
            
            for item in tableViews {
                item.mj_header.endRefreshing()
            }
            
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }

        
        
        
        switch currentShowTableViewIndex {
        case 0:
            http.requestDefaultAllOrderListFromServer(usrId.description)
        case 1://所有爽购订单
            http.requestDefaultShuangGouOrderListFromServer(usrId.description)
        case 2:
            http.requestDefaultWaitToPayOrderListFromServer(usrId.description)
        case 3:
            http.requestDefaultWaitToDeliverOrderListFromServer(usrId.description)
        case 4:
            http.requestDefaultWaitToReceivedOrderListFromServer(usrId.description)
        case 5:
            http.requestDefaultCompletedOrderListFromServer(usrId.description)
        default:
            break
        }

    }
    
    //上拉加载更多
    func pullUpRef()  {
        if !onlineState {
            
            for item in tableViews {
                item.mj_footer.endRefreshing()
            }
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        switch currentShowTableViewIndex {
        case 0:
            http.requestMoreAllOrderListFromServer(usrId.description)
        case 1:
            http.requestMoreShuangGouListFromServer(usrId.description)
        case 2:
            http.requestMoreNonpaymentOrderList(usrId.description)
        case 3:
            http.requestMoreNoDeliverGoodsOrderList(usrId.description)
        case 4:
            http.requestMoreNoReceiveOrderList(usrId.description)
        case 5:
            http.requestMoreCompletedOrderList(usrId.description)
        default:
            break
        }
        
    }
    
    //商品列表获取(通知处理)
    func orderListChangedProcess(notice:NSNotification) {
        
        
        
        let index = notice.object as! Int
        
        if index != 10 {
            tableViews[index].mj_footer.endRefreshing()
            tableViews[index].mj_header.endRefreshing()
            
            switch index {
            case 0:
                let allOrderListData = http.getAllOrderList()
                self.allOrderListData = allOrderListData
                
                if self.allOrderListData.count == 0 {
                    let backgroundView = UIImageView(image: UIImage(named:"背景"))
                    tableViews[index].backgroundView = backgroundView
                }else{
                    tableViews[index].backgroundView = nil
                }

            case 1:
                let shuangGouOrderListData = http.getShuangGouOrderList()
                self.shuangGouOrderListData = shuangGouOrderListData
                
                if self.shuangGouOrderListData.count == 0 {
                    let backgroundView = UIImageView(image: UIImage(named:"背景"))
                    tableViews[index].backgroundView = backgroundView
                }else{
                    tableViews[index].backgroundView = nil
                }
                
            case 2:
                let nonPaymentOrderData = http.getNoPayOrderList()
                self.nonPaymentOrderData = nonPaymentOrderData

                if self.nonPaymentOrderData.count == 0 {
                    let backgroundView = UIImageView(image: UIImage(named:"背景"))
                    tableViews[index].backgroundView = backgroundView
                }else{
                    tableViews[index].backgroundView = nil
                }
                
            case 3:
                let noDeliverOrderData = http.getNoDeliverOrderList()
                self.noDeliverOrderData = noDeliverOrderData

                if self.noDeliverOrderData.count == 0 {
                    let backgroundView = UIImageView(image: UIImage(named:"背景"))
                    tableViews[index].backgroundView = backgroundView
                }else{
                    tableViews[index].backgroundView = nil
                }
                
            case 4:
                let noReceiveOrderData = http.getNoReceiveOrderList()
                self.noReceiveOrderData = noReceiveOrderData
                if self.noReceiveOrderData.count == 0 {
                    let backgroundView = UIImageView(image: UIImage(named:"背景"))
                    tableViews[index].backgroundView = backgroundView
                }else{
                    tableViews[index].backgroundView = nil
                }
                
            case 5:
                let completedOrderData = http.getCompletedOrderList()
                self.completedOrderData = completedOrderData
                if self.completedOrderData.count == 0 {
                    let backgroundView = UIImageView(image: UIImage(named:"背景"))
                    tableViews[index].backgroundView = backgroundView
                }else{
                    tableViews[index].backgroundView = nil
                }
            default:
                break
            }
            
            
            tableViews[index].reloadData()
        }else{
            for index in 0..<self.tableViews.count{
                tableViews[index].mj_footer.endRefreshing()
                tableViews[index].mj_header.endRefreshing()
            }
            let msg = "无更多数据"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
        self.edgesForExtendedLayout = UIRectEdge.None
        
        
        
        
        //微信支付结果处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderShowVC.weiXinResultProcess(_:)), name: "WeiXinResult", object:nil)
        
        //支付宝支付结果处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderShowVC.alipayResultProcess(_:)), name: "AlipayResult", object:nil)
        
        
        //爽购支付通知处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderShowVC.shuangGouResultProcess(_:)), name: "ShuangGouResult", object:nil)
        
        
        
        //货到付款通知处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderShowVC.huoDaoFuKuanResultProcess(_:)), name: "HuoDaoFuKuanResult", object:nil)
        
        

        //订单列表模型通知接收
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderShowVC.orderListChangedProcess(_:)), name: "OrderDataChanged", object:nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderShowVC.orderStatusChangedProcess(_:)), name: "orderStatusChanged", object:nil)
        
        
        //错误信息及无更多数据
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderShowVC.errorOrNoMoreDataProcess(_:)), name: "OrderShowVC_ErrorOrNoMoreData", object:nil)
        
        //无网络连接
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderShowVC.Order_SendErrorMsgProcess(_:)), name: "Order_SendErrorMsg", object: nil)
        
        self.view.addSubview(buttonsOnderLine)
        
        
        buttonsOnderLine.delegate = self
        
        setScrollContentView()
        
        setTableViewInfo()
        
        self.view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        
        //请求10条默认数据
        //dropDownRef()
        selectOrderStatus(currentShowTableViewIndex)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setScrollContentView()  {
        self.view.addSubview(scrollContentView)
        
        scrollContentView.showsHorizontalScrollIndicator = false
        scrollContentView.showsVerticalScrollIndicator = false
        scrollContentView.pagingEnabled = true
        scrollContentView.scrollEnabled = false
        
        scrollContentView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(buttonsOnderLine.snp_bottom).offset(2)
            //make.bottom.equalTo(self.view.snp_bottom).offset(-44)
            make.height.equalTo(screenHeigh - 94)
        }
        let startY = buttonsOnderLine.frame.maxY + 2
        let endY = self.scrollContentView.frame.maxY
        
        scrollContentView.contentSize = CGSize(width: screenWith*5, height: endY - startY )
        scrollContentView.delegate = self
        scrollContentView.backgroundColor = UIColor.whiteColor()
    }

}


extension OrderShowVC : UIAlertViewDelegate{
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 1:
            let loginVC = LoginVC()
            self.presentViewController(loginVC, animated: true, completion: {
                
            })
        default:
            break
        }
    }
}


extension OrderShowVC:UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
    }
}




extension OrderShowVC:OrderButtonsOnderLineDelegate{
    func goodsOrderStatesSeparatedBy(index:Int) {
        
        let offSet = screenWith*CGFloat(index)
        
        self.currentShowTableViewIndex = index
        
        UIView.animateWithDuration(0.3, animations: {
            self.scrollContentView.contentOffset = CGPoint(x: offSet, y: 0)
            }) { (flag) in
               //在此处可以进行数据请求更新
        }
        
    }
}


extension OrderShowVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch tableView.tag {
        case 0:
           return allOrderListData[section].details.count
        case 1:
            return shuangGouOrderListData[section].details.count
        case 2:
            return nonPaymentOrderData[section].details.count
        case 3:
            return noDeliverOrderData[section].details.count
        case 4:
            return noReceiveOrderData[section].details.count
        case 5:
            return completedOrderData[section].details.count
        default:
            return 0
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        switch tableView.tag {
        case 0:
            return allOrderListData.count
        case 1:
            return shuangGouOrderListData.count
        case 2:
            return nonPaymentOrderData.count
        case 3:
            return noDeliverOrderData.count
        case 4:
            return noReceiveOrderData.count
        case 5:
            return completedOrderData.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! OrderShowCell
        
        
        
        switch tableView.tag {
        case 0:
            let cellInfo = allOrderListData[indexPath.section].details[indexPath.row].ex_showCellInfo()
            cell.imgStr = cellInfo.picUrl
            cell.nameStr = cellInfo.name
            cell.sellCntStr = cellInfo.num.description
            cell.priceStr = String(format: "%.2f", cellInfo.price)
            return cell
        case 1:
            let cellInfo = shuangGouOrderListData[indexPath.section].details[indexPath.row].ex_showCellInfo()
            cell.imgStr = cellInfo.picUrl
            cell.nameStr = cellInfo.name
            cell.sellCntStr = cellInfo.num.description
            cell.priceStr = String(format: "%.2f", cellInfo.price)
            return cell
        case 2:
            
            let cellInfo = nonPaymentOrderData[indexPath.section].details[indexPath.row].ex_showCellInfo()
            cell.imgStr = cellInfo.picUrl
            cell.nameStr = cellInfo.name
            cell.sellCntStr = cellInfo.num.description
            cell.priceStr = String(format: "%.2f", cellInfo.price)
            return cell
        case 3:
            let cellInfo = noDeliverOrderData[indexPath.section].details[indexPath.row].ex_showCellInfo()
            cell.imgStr = cellInfo.picUrl
            cell.nameStr = cellInfo.name
            cell.sellCntStr = cellInfo.num.description
            cell.priceStr = String(format: "%.2f", cellInfo.price)
            return cell
        case 4:
            let cellInfo = noReceiveOrderData[indexPath.section].details[indexPath.row].ex_showCellInfo()
            cell.imgStr = cellInfo.picUrl
            cell.nameStr = cellInfo.name
            cell.sellCntStr = cellInfo.num.description
            cell.priceStr = String(format: "%.2f", cellInfo.price)
            return cell
        case 5:
            let cellInfo = completedOrderData[indexPath.section].details[indexPath.row].ex_showCellInfo()
            cell.imgStr = cellInfo.picUrl
            cell.nameStr = cellInfo.name
            cell.sellCntStr = cellInfo.num.description
            cell.priceStr = String(format: "%.2f", cellInfo.price)
            return cell
        default:
            return cell
        }
    
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenWith/4
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 320/8
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        switch tableView.tag {
            case 0://需判断该笔订单的状态
                let h = allOrderListData[section].ex_orderStatusForFooterHeight()
                let heigth = 320/8 - 6 + CGFloat(h)
                
                return 320/8 - 6 + CGFloat(h)
            case 1://需判断该笔订单的状态
                let h = shuangGouOrderListData[section].ex_orderStatusForFooterHeight()
                let heigth = 320/8 - 6 + CGFloat(h)
                
                return 320/8 - 6 + CGFloat(h)
            
            case 2:
                let h = nonPaymentOrderData[section].ex_orderStatusForFooterHeight()
                return 320/8 - 6 + CGFloat(h)
            case 3:
                return 320/8 - 6
            case 4:
                let h = noReceiveOrderData[section].ex_orderStatusForFooterHeight()
                return 320/8 - 6 + CGFloat(h)
                //return 320/8 - 6
            case 5:
                let h = completedOrderData[section].ex_orderStatusForFooterHeight()
                return 320/8 - 6 + CGFloat(h)
                //return 320/8 - 6
        default:
            break
        }
        return 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let orderHeaderView = OrderHeaderView()
        
        switch tableView.tag {
        case 0:
             let info = allOrderListData[section].ex_forHeaderInfo()
             orderHeaderView.orderNum = info.orderNum
             orderHeaderView.shopName = info.shopName
             orderHeaderView.orderState = info.orderState
        case 1:
            let info = shuangGouOrderListData[section].ex_forHeaderInfo()
            orderHeaderView.orderNum = info.orderNum
            orderHeaderView.shopName = info.shopName
            orderHeaderView.orderState = info.orderState
        case 2:
            let info = nonPaymentOrderData[section].ex_forHeaderInfo()
            orderHeaderView.orderNum = info.orderNum
            orderHeaderView.shopName = info.shopName
            orderHeaderView.orderState = info.orderState
        case 3:
            let info = noDeliverOrderData[section].ex_forHeaderInfo()
            orderHeaderView.orderNum = info.orderNum
            orderHeaderView.shopName = info.shopName
            orderHeaderView.orderState = info.orderState
        case 4:
            let info = noReceiveOrderData[section].ex_forHeaderInfo()
            orderHeaderView.orderNum = info.orderNum
            orderHeaderView.shopName = info.shopName
            orderHeaderView.orderState = info.orderState
        case 5:
            let info = completedOrderData[section].ex_forHeaderInfo()
            orderHeaderView.orderNum = info.orderNum
            orderHeaderView.shopName = info.shopName
            orderHeaderView.orderState = info.orderState
        default:
             break
        }
        
        
        
        
        
        return orderHeaderView
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        
        switch tableView.tag {
        case 0:
            
            let showFooterInfo = allOrderListData[section].goodsCurrentShopPriceAndCount()
            var footerView = allOrderListData[section].ex_footerViewForSection()
            
            let orderStatus:String = allOrderListData[section].ex_orderStatus()
            switch orderStatus {
            case "待付款":
                let view = footerView as! OrderWaitToPayFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待发货":
                
                let view = footerView as! OrderWaitToDeliveryFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待签收":
                
                let view = footerView as! OrderWaitToSignInFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "已完成":
                let view = footerView as! OrderCompleteFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            default:
                return nil
            }

        case 1:
            let showFooterInfo = shuangGouOrderListData[section].goodsCurrentShopPriceAndCount()
            var footerView = shuangGouOrderListData[section].ex_footerViewForSection()
            
            let orderStatus:String = shuangGouOrderListData[section].ex_orderStatus()
            switch orderStatus {
            case "待付款":
                let view = footerView as! OrderWaitToPayFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待发货":
                
                let view = footerView as! OrderWaitToDeliveryFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待签收":
                
                let view = footerView as! OrderWaitToSignInFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "已完成":
                let view = footerView as! OrderCompleteFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            default:
                return nil
            }
            
            
        case 2:
            let showFooterInfo = nonPaymentOrderData[section].goodsCurrentShopPriceAndCount()
            
            var footerView = nonPaymentOrderData[section].ex_footerViewForSection()
            
            let orderStatus:String = nonPaymentOrderData[section].ex_orderStatus()
            switch orderStatus {
            case "待付款":
                let view = footerView as! OrderWaitToPayFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
                
            case "待发货":
                
                let view = footerView as! OrderWaitToDeliveryFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待签收":
                
                let view = footerView as! OrderWaitToSignInFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "已完成":
                let view = footerView as! OrderCompleteFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            default:
                return nil
            }
            
        case 3:
            let showFooterInfo = noDeliverOrderData[section].goodsCurrentShopPriceAndCount()
            var footerView = noDeliverOrderData[section].ex_footerViewForSection()
            
            let orderStatus:String = noDeliverOrderData[section].ex_orderStatus()
            switch orderStatus {
            case "待付款":
                let view = footerView as! OrderWaitToPayFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
                
            case "待发货":
                
                let view = footerView as! OrderWaitToDeliveryFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待签收":
                
                let view = footerView as! OrderWaitToSignInFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "已完成":
                let view = footerView as! OrderCompleteFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
                
            default:
                return nil
                
            }
            
            
        case 4:
            let showFooterInfo = noReceiveOrderData[section].goodsCurrentShopPriceAndCount()
            
            var footerView = noReceiveOrderData[section].ex_footerViewForSection()
            
            let orderStatus:String = noReceiveOrderData[section].ex_orderStatus()
            switch orderStatus {
            case "待付款":
                let view = footerView as! OrderWaitToPayFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待发货":
                
                let view = footerView as! OrderWaitToDeliveryFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待签收":
                
                let view = footerView as! OrderWaitToSignInFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "已完成":
                let view = footerView as! OrderCompleteFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
                
            default:
                return nil
                
            }
            
        case 5:
            let showFooterInfo = completedOrderData[section].goodsCurrentShopPriceAndCount()
            
            var footerView = completedOrderData[section].ex_footerViewForSection()
            
            let orderStatus:String = completedOrderData[section].ex_orderStatus()
            switch orderStatus {
            case "待付款":
                let view = footerView as! OrderWaitToPayFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待发货":
                
                let view = footerView as! OrderWaitToDeliveryFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "待签收":
                
                let view = footerView as! OrderWaitToSignInFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
            case "已完成":
                let view = footerView as! OrderCompleteFooterView
                view.setValueForView(section, haveLargesses: showFooterInfo.haveLargesses, allNum: showFooterInfo.allCnt, shouldPay: showFooterInfo.priceOfCurrentShopGoods)
                view.delegate = self
                return view
                
            default:
                return nil
                
            }
            
            
        default:
            break
        }
        
        
        return nil
    }
}

extension OrderShowVC:OrderWaitToPayFooterViewDelegate{
    //取消订单
    func cancelOrder(section:Int){
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        switch currentShowTableViewIndex {
        case 0:
            let orderNum = allOrderListData[section].orderno
            http.cancelOrdetr(orderNum, index: currentShowTableViewIndex)
            
        case 2:
            let orderNum = nonPaymentOrderData[section].orderno
            http.cancelOrdetr(orderNum, index: currentShowTableViewIndex)
            
        default:
            break
        }
        
    }
    //支付订单
    func payOrder(section:Int){
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        switch currentShowTableViewIndex {
        case 0:
            
            let (tradeNo,productName,productDescription,amount) = allOrderListData[section].ex_payForAlipay()
            payOrder(tradeNo, productName: productName, productDescription: productDescription, amount: amount)
        case 2:
            
            let (tradeNo,productName,productDescription,amount) = nonPaymentOrderData[section].ex_payForAlipay()
            payOrder(tradeNo, productName: productName, productDescription: productDescription, amount: amount)
        default:
            break
        }
    }
    //查看赠品信息
    func checkLargesses(section:Int){
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        switch currentShowTableViewIndex {
        case 0:
            
            let msg = allOrderListData[section].activitiemassage
            showMessage(msg)
        case 1:
            
            let msg = shuangGouOrderListData[section].activitiemassage
            showMessage(msg)
        case 2:
            
            let msg = nonPaymentOrderData[section].activitiemassage
            showMessage(msg)
        case 3:
            
            let msg = noDeliverOrderData[section].activitiemassage
            showMessage(msg)
        case 4:
            
            let msg = noReceiveOrderData[section].activitiemassage
            showMessage(msg)
        case 5:
            
            let msg = completedOrderData[section].activitiemassage
            showMessage(msg)
        default:
            break
        }
    }
    
    //赠品信息
    func showMessage(message:String)  {
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        let img = HalfAlphaGiftShowMessageImageView(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh - 44))
        img.message = message
        self.view.addSubview(img)
    }
    
    //签收订单
    func signInOrder(section:Int){
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        switch currentShowTableViewIndex {
        case 0:
            let order = allOrderListData[section].orderno
            http.signInOrder(order, index: 0)
            
        case 1:
            let order = shuangGouOrderListData[section].orderno
            http.signInOrder(order, index: 1)
            
        case 4:
            let order = noReceiveOrderData[section].orderno
            http.signInOrder(order, index: 4)
            
        default:
            break
        }
        
    }
    //删除订单
    func deleteOrder(section:Int){
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        switch currentShowTableViewIndex {
        case 0:
            let order = allOrderListData[section].orderno
            http.deleteOrder(order, index: currentShowTableViewIndex)
            
        case 1:
            let order = shuangGouOrderListData[section].orderno
            http.deleteOrder(order, index: currentShowTableViewIndex)
            
        case 5:
            let order = completedOrderData[section].orderno
            http.deleteOrder(order, index: currentShowTableViewIndex)
            
        default:
            break
        }
        
    }
}


extension OrderShowVC{
    
    func Order_SendErrorMsgProcess(notice : NSNotification){
        
        
        let msg = notice.object!["errorMsg"]! as! String
        let status = notice.object!["status"]! as! String
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)
    }

    
    
    func errorOrNoMoreDataProcess(notice:NSNotification) {
        
        let msg = notice.object!["msg"] as!  String
        self.view.dodo.style.bar.hideAfterDelaySeconds = 3
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)
        
    }
    
    func orderStatusChangedProcess(notice:NSNotification) {
        print("\(notice.description)")
        let index = notice.object as! Int
        
        selectOrderStatus(index)
    }
    
    //点击了哪一种订单
    func selectOrderStatus(index:Int)  {
        self.buttonsOnderLine.selectNum = index
    }
}


extension OrderShowVC{
    
    //支付订单
    func payOrder(tradeNo:String,productName:String,productDescription:String,amount:Double) {
        requestPayMethod(tradeNo,amount:amount)

    }
    
    //显示可用的支付方式
    func showAvaliablePayMethod(paymentConfig:PaymentConfig,orderNum:String,amount:Double)  {
        
        //支付名称
        var payMethodName = [String]()
        //支付方式id
        var payMethodId = [String:Int]()
        if paymentConfig.code == 0 {//网络请求成功
            let payMethodArr:[PaymentData] = paymentConfig.data
            for item in payMethodArr {
                payMethodName.append(item.title)
                payMethodId[item.title] = item.paymentid
            }
            
        }else{
            return
        }
        
        let alertController = UIAlertController(title: "提示", message: "请选中支付方式", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        
        let shuangGouZhiFu = UIAlertAction(title: "爽购", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            
            self.requestDiscountPriceAndGift(payMethodId["爽购"]!, orderno: orderNum,payMethod:"爽购",amount:amount)
        }
        
        let huoDaoFuKuan = UIAlertAction(title: "货到付款", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            
            self.requestDiscountPriceAndGift(payMethodId["货到付款"]!, orderno: orderNum,payMethod:"货到付款",amount:amount)
        }
        
        let alipayMethod = UIAlertAction(title: "支付宝", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            
            self.requestDiscountPriceAndGift(payMethodId["支付宝"]!, orderno: orderNum,payMethod:"支付宝",amount:amount)
            
        }
        
        let weixinMethod = UIAlertAction(title: "微信支付", style: UIAlertActionStyle.Destructive) { (UIAlertAction) in
            
            self.requestDiscountPriceAndGift(payMethodId["微信支付"]!, orderno: orderNum,payMethod:"微信支付",amount:amount)
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil)
        
        for item in payMethodName {
            if item == "爽购" {
                alertController.addAction(shuangGouZhiFu)
                continue
            }
            if item == "货到付款" {
                alertController.addAction(huoDaoFuKuan)
                continue
            }
            if item == "支付宝" {
                alertController.addAction(alipayMethod)
                continue
            }
            if item == "微信支付" {
                alertController.addAction(weixinMethod)
                continue
            }
                
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
            
        }
    }
    
    //网络请求打折信息和赠品信息
    func requestDiscountPriceAndGift(paymentid:Int,orderno:String,payMethod:String,amount:Double) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let url = serverUrl + "/order/gift"
        let parameters =  ["userid":userInfo_Global.keyid,
                           "usertype":"1",
                           "paymentid":paymentid,
                           "orderno":orderno,
                           "sign":MD5_time,"timespan":timeTemp.description
        ]
        
        
        Alamofire.request(.GET, url, parameters: parameters as? [String : AnyObject]).responseString { response -> Void in
            
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    
                    
                   let giftAndDiscountRootClass = GiftAndDiscountRootClass(fromDictionary: dict!)
                    
                    //判断有无赠品和减免信息
                    if giftAndDiscountRootClass.code == 0 {
                        var discount = Double()
                        
                        var merchantGift = [String]()
                        //商家活动
                        if (giftAndDiscountRootClass.data.hasdiscount == true) {//减免金额
                            discount = giftAndDiscountRootClass.data.discountamount
                            merchantGift.append(giftAndDiscountRootClass.data.actitiemassage)
                        }else{//送商品
                            discount = 0.0
                            
                        }
                        //商品活动
                        var goodsGift = [String]()
                        
                        for item in giftAndDiscountRootClass.data.products{
                            goodsGift.append(item.productname + ":" + item.activitiemassage)
                        }
                        
                        
                        let time = giftAndDiscountRootClass.data.timespan
                        let merchantName = giftAndDiscountRootClass.data.shopname
                        
                        
                        let giftView = ShowGiftAndPayView(gift: merchantGift + goodsGift, discountPrice: discount, price: amount,payMethod:payMethod,flag:true,orderNum:orderno,time:time,goodsTitle:merchantName)
                        giftView.delegate = self
                        self.view.addSubview(giftView)
                    }else if giftAndDiscountRootClass.code == 1{
                        
                        let time = dict!["data"] as! String
                        let merchantName = String()
                        
                        let giftView = ShowGiftAndPayView(gift: [String](), discountPrice: 0.0, price: amount,payMethod:payMethod,flag:true,orderNum:orderno,time:time,goodsTitle:merchantName)
                        
                        giftView.delegate = self
                        self.view.addSubview(giftView)
                    }else{
                        
                    }
    
                }catch _ {
                    
                }
                
            case .Failure(let error):
                print(error)
            }
            
        }
    }
    
    //支付方式列表
    func requestPayMethod(orderNum:String,amount:Double){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let url = serverUrl + "/payment/list"
        Alamofire.request(.GET, url, parameters: ["roleid":userInfo_Global.roleid,"sign":MD5_time,"timespan":timeTemp.description]).responseString { response -> Void in
            
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    let payMethodInfo:PaymentConfig = PaymentConfig(fromDictionary: dict!)
                    self.showAvaliablePayMethod(payMethodInfo, orderNum: orderNum,amount:amount )
                    
                    
                }catch _ {
                    
                }
                
            case .Failure(let error):
                print(error)
            }
            
        }
    }
    
    

    
    
    
}


//支付该笔订单
extension OrderShowVC:ShowGiftAndPayViewDelegate {
    
    func cancelRightNowPayOrder(){
        
    }
    
    func payOrder(order:String,price:Double,time:String,goodsName:String,payMethod:String){
        
        
        
        switch payMethod {
        case "爽购":
            
            ShuangGouAndHuoDaoPay().requestCheckShuangGouAmount(price, tradeno: order)
            break
        case "货到付款":
            ShuangGouAndHuoDaoPay().requestDeliverToPay(order)
            break
        case "微信支付":
            
            AlipayAndWeixinPay().weiXinPay(order, productName: "天天快购平台:" + order, productDescription: time, amount: String(Int(price*100)), notifyURL: WeixinNotifyURL)
            break
        case "支付宝":
            AlipayAndWeixinPay().Alipay(order, productName: "天天快购平台:" + order, productDescription: time, amount: String(price))
            break
            
        default:
            break
        }
        
        
    }
}

extension OrderShowVC {
    
    
    //微信支付(通知处理)
    func weiXinResultProcess(notice:NSNotification) {
        
        

        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.locationTop = false
        
        var msg = String()
        if let weiXinStatus = notice.valueForKey("object")?.valueForKey("WeiXinStatus") {
            if weiXinStatus as? String == "notInstall" {
                
                msg = "请先安装微信客服端再进行支付"
            }else if "signedError" ==  weiXinStatus as? String{
                msg = "微信支付签名错误，请稍后再试"
            }else if "paySuccess" == weiXinStatus as? String {
                msg = "微信支付成功"
            }else if "cancelWinXinPay" == weiXinStatus as? String{
                selectOrderStatus(2)
                msg = "您取消了微信支付"
            }else{
                msg = "网络故障，请重试"
            }
            
        }else{
            msg = "无可用网络"
        }
        
        self.view.dodo.warning(msg)
        
 
        
    }
    
    //支付宝支付
    func alipayResultProcess(notice:NSNotification) {
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.locationTop = false
        
        var msg = String()
        if let alipayStatus = notice.valueForKey("object")?.valueForKey("alipayStatus") {
            if alipayStatus as? String == "successful" {
               selectOrderStatus(3)
                msg = "支付成功"
            }else if "cancellAlipay" == alipayStatus as? String{
                selectOrderStatus(2)
                msg = "您取消了支付宝支付"
            }
        }else{
                msg = "无可用网络"
        }
        
        self.view.dodo.warning(msg)
    
        
    }
    
    //爽购支付
    func shuangGouResultProcess(notice:NSNotification) {
        
        
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.locationTop = false
        if let code = notice.valueForKey("object")?.valueForKey("code") {
            if (code as! Int) == 0 {//支付成功，选择待发货
                selectOrderStatus(3)
            }
            self.view.dodo.warning(notice.valueForKey("object")?.valueForKey("msg") as! String)
        }else{
            self.view.dodo.warning("无可以网络")
        }
        
        
        
    }
    
    
    //货到付款
    func huoDaoFuKuanResultProcess(notice:NSNotification) {
        print("货到付款 = \(notice.description)")
        let msg = "无更多数据"
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 2
        self.view.dodo.style.bar.locationTop = false
        if let code = notice.valueForKey("object")?.valueForKey("code") {
            if (code as! Int) == 0 {//支付成功，选择待发货
                selectOrderStatus(3)
            }
            
            self.view.dodo.warning(notice.valueForKey("object")?.valueForKey("msg") as! String)
        }else{
            self.view.dodo.warning("无可以网络")
        }
        
        
    }
    
}





