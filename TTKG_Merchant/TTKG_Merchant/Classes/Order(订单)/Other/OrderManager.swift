//
//  OrderManager.swift
//  ttkg_customer
//
//  Created by yd on 16/7/4.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation


class OrderManager {
    

    //全部订单订单详情
    var allOrderListData = [OrderList]()
    //爽购订单
    var shuangGouOrderListData = [OrderList]()
    //待付款订单
    var nonPaymentOrderData = [OrderList]()
    //待发货订单
    var noDeliverOrderData = [OrderList]()
    //待签收订单
    var noReceiveOrderData = [OrderList]()
    //已签收订单
    var completedOrderData = [OrderList]()
    
    
    
    
    private var whichIndex = 10
    
    private var senderFlag = 0 {
        didSet{
            
            let notice = NSNotification(name: "OrderDataChanged", object: whichIndex)
            
            NSNotificationCenter.defaultCenter().postNotification(notice)
            
            
        }
    }
    
    //返回默认的十条数据
    func getTenOrderList() -> [OrderList] {
        return getTenOrderList()
    }
    
    
    // 返回全部订单列表
    func getAllOrderList() -> [OrderList] {
        return allOrderListData
    }
    
    //返回爽购订单列表
    func getShuangGouList() -> [OrderList] {
        return shuangGouOrderListData
    }
    
    func removeShuangGouList()  {
        shuangGouOrderListData = []
    }
    
    //返回待付款订单列表
    func getNonpaymentOrderList() -> [OrderList] {
        return nonPaymentOrderData
    }
    
    //返回待发货订单列表
    func getNoDeliverOrderList() -> [OrderList] {
        return noDeliverOrderData
    }
    //返回待签收订单列表
    func getNoReceiveOrderList() -> [OrderList] {
        return noReceiveOrderData
    }
    //返回已签收订单列表
    func getCompletedOrderList() -> [OrderList] {
        return completedOrderData
    }
    
    
    
    
    
     /****************************************************************************/
    //清空全部订单数据数组
    func removeAllOrderList()  {
        allOrderListData = [ ]
        whichIndex = 0
        senderFlag += 1
    }
    
    
    func removeDefaultAllOrderList()  {
        allOrderListData = [ ]
    }
    
    func addAllOrderList(allOrderListData:[OrderList])  {
        self.allOrderListData += allOrderListData
        whichIndex = 0
        senderFlag += 1
    }
    
    //在全部订单下，根据订单号删除订单
    func removeAllOrderByOrderNum(orderNum:String)  {
        for i in 0..<self.allOrderListData.count {
            if orderNum == allOrderListData[i].orderno{
                allOrderListData.removeAtIndex(i)
                whichIndex = 0
                senderFlag += 1
                break
            }
        }
    }
    
    //在待付款订单下，根据订单号删除订单
    func removeWaitToPayOrderByOrderNum(orderNum:String)  {
        for i in 0..<self.nonPaymentOrderData.count {
            if orderNum == nonPaymentOrderData[i].orderno{
                nonPaymentOrderData.removeAtIndex(i)
                whichIndex = 2
                senderFlag += 1
                break
            }
        }
    }
    
    //在已经签收下，删除订单
    func removeCompleteOrderByOrderNum(orderNum:String)  {
        for i in 0..<self.completedOrderData.count {
            if orderNum == completedOrderData[i].orderno{
                completedOrderData.removeAtIndex(i)
                whichIndex = 5
                senderFlag += 1
                break
            }
        }
    }
    
    //在爽购页面删除订单
    func removeShuangGouOrderByOrderNum(orderNum:String)  {
        for i in 0..<self.shuangGouOrderListData.count {
            if orderNum == shuangGouOrderListData[i].orderno{
                shuangGouOrderListData.removeAtIndex(i)
                whichIndex = 1
                senderFlag += 1
                break
            }
        }
    }

    
    /****************************************************************************/
    //清空待付款订单数组
    func removeNoPayOrderList()  {
        
        nonPaymentOrderData = []
        whichIndex = 2
        senderFlag += 1
    }
    
    func removeDefaultNoPayOrderList()  {
        nonPaymentOrderData = []
    }
    
    func addNoPayOrderList(nonPaymentOrderData : [OrderList])  {
        
        //检查订单，是否存在于模型中，如果存在就不添加
        for newOrderInfo in nonPaymentOrderData {
            var newOrderFlag = true
            for orderNum in nonPaymentNumList() {
                if newOrderInfo.orderno == orderNum {
                    newOrderFlag = false
                    break
                }
            }
            if newOrderFlag {
                self.nonPaymentOrderData.append(newOrderInfo)
            }
            
        }
        
        whichIndex = 2
        senderFlag += 1
    }
    
    private func nonPaymentNumList() -> [String]{
        var orderNumList = [String]()
        for item in self.nonPaymentOrderData {
            orderNumList.append(item.orderno)
        }
        return orderNumList
    }
    
    /****************************************************************************/
    //清空待发货订单数组数组
    func removeNoDeliverOrderList()  {
        noDeliverOrderData = []
        whichIndex = 3
        senderFlag += 1
    }
    
    func removeDefaultNoDeliverOrderList()  {
        noDeliverOrderData = []
    }
    
    func addNoDeliverOrderList(noDeliverOrderData : [OrderList])  {
        self.noDeliverOrderData += noDeliverOrderData
        whichIndex = 3
        senderFlag += 1
    }
    
    /****************************************************************************/
    //清空待签收数组
    func removeNoReceiveOrderList() {
        noReceiveOrderData = []
        whichIndex = 4
        senderFlag += 1
    }
    
    func removeDefaultNoReceiveOrderList()  {
        noReceiveOrderData = []
    }
    
    
    func addNoReceiveOrderList(noReceiveOrderData:[OrderList])  {
        self.noReceiveOrderData += noReceiveOrderData
        whichIndex = 4
        senderFlag += 1
    }
    /****************************************************************************/
    //清空已签收数组
    func removeCompletedOrderList()  {
        completedOrderData = []
        whichIndex = 5
        senderFlag += 1
    }
    
    func removeDefaultCompletedOrderList()  {
        completedOrderData = []
    }
    
    
    func addcompletedOrderList(completedOrderData:[OrderList])  {
        self.completedOrderData += completedOrderData
        whichIndex = 5
        senderFlag += 1
    }
    /****************************************************************************/
    func addShuangGouList(shuangGouOrderListData:[OrderList])  {
        self.shuangGouOrderListData += shuangGouOrderListData
        whichIndex = 1
        senderFlag += 1
    }
    
}