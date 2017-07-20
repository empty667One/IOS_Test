//
//  OrderDataAPI.swift
//  ttkg_customer
//
//  Created by yd on 16/7/4.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation

class OrderDataAPI: OrderHTTPClientDelegate {
    
    static let shareInstance = OrderDataAPI()
    private init() {
        peristencyManager = OrderManager()
        httpClient = OrderHTTPClient()
        //isOnline = true
        httpClient?.delegate = self
    }
    
    private let peristencyManager : OrderManager?
    private let httpClient : OrderHTTPClient?
    //private let isOnline : Bool?
    
    
    func removeAllModelData()  {
        peristencyManager?.removeAllOrderList()
        peristencyManager?.removeNoPayOrderList()
        peristencyManager?.removeNoDeliverOrderList()
        peristencyManager?.removeNoReceiveOrderList()
        peristencyManager?.removeCompletedOrderList()
    }
    
    //获取全部订单
    func getAllOrderList() -> [OrderList] {
        return (peristencyManager?.getAllOrderList())!
    }
    
    //获取全部订单
    func getShuangGouOrderList() -> [OrderList] {
        return (peristencyManager?.getShuangGouList())!
    }
    
    //获取未付款订单
    func getNoPayOrderList() -> [OrderList] {
        return (peristencyManager?.getNonpaymentOrderList())!
    }
    //获取待发货订单
    func getNoDeliverOrderList() -> [OrderList] {
        return (peristencyManager?.getNoDeliverOrderList())!
    }
    //获取待签收订单
    func getNoReceiveOrderList() -> [OrderList] {
        return (peristencyManager?.getNoReceiveOrderList())!
    }
    //获取已完成订单
    func getCompletedOrderList() -> [OrderList] {
        return (peristencyManager?.getCompletedOrderList())!
    }
    
    //获取全部订单前10条默认数据(全部订单：paymentid=0，iswaybill=0，status=0 或者一个都不传)
    func requestDefaultAllOrderListFromServer(userid:String) {
        if (onlineState != false) {
            let iswaybill:String = "0"
            let status:String = "0"
            peristencyManager?.removeAllOrderList()
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: "", index: 0,paymentid:0)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取爽购订单前10条默认数据(爽购订单：paymentid=1，iswaybill=0，status=0)
    func requestDefaultShuangGouOrderListFromServer(userid:String) {
        if (onlineState != false) {
            let iswaybill:String = "0"
            let status:String = "0"
            peristencyManager?.removeAllOrderList()
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: "", index: 1,paymentid:1)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取待付款前10条默认数据(待付款：paymentid=0，iswaybill=0，status=1)
    func requestDefaultWaitToPayOrderListFromServer(userid:String) {
        if (onlineState != false) {
            let iswaybill:String = "0"
            let status:String = "1"
            peristencyManager?.removeNoPayOrderList()
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: "", index: 2,paymentid:0)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取待发货前10条默认数据(待发货：paymentid=0，iswaybill=1，status=2)
    func requestDefaultWaitToDeliverOrderListFromServer(userid:String) {
        if (onlineState != false) {
            let iswaybill:String = "1"
            let status:String = "2"
            peristencyManager?.removeNoDeliverOrderList()
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: "", index: 3,paymentid:0)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取待签收前10条默认数据(待签收：paymentid=0，iswaybill=2，status=2)
    func requestDefaultWaitToReceivedOrderListFromServer(userid:String) {
        if (onlineState != false) {
            let iswaybill:String = "2"
            let status:String = "2"
            peristencyManager?.removeNoReceiveOrderList()
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: "", index: 4,paymentid:0)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取已完成前10条默认数据(已完成：paymentid=0，iswaybill=3，status=2)
    func requestDefaultCompletedOrderListFromServer(userid:String) {
        if (onlineState != false) {
            let iswaybill:String = "3"
            let status:String = "2"
            peristencyManager?.removeCompletedOrderList()
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: "", index: 5,paymentid:0)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取全部订单(全部订单：paymentid=0，iswaybill=0，status=0 或者一个都不传)
    func requestMoreAllOrderListFromServer(userid:String) {
        
        if (onlineState != false) {
            let cnt = (peristencyManager?.getAllOrderList().count)!/10 + 1
            
            if cnt == 1 {
                peristencyManager?.removeDefaultAllOrderList()
            }
            
            let iswaybill:String = "0"
            let status:String = "0"
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: cnt.description, index: 0,paymentid:0)

        }else{
            respondErrorStatus("无可以网络")
        }
        
    }
    
    //获取爽购订单(爽购订单：paymentid=1，iswaybill=0，status=0)
    func requestMoreShuangGouListFromServer(userid:String) {
        if (onlineState != false) {
            var cnt = Int()
            if (peristencyManager?.getShuangGouList().count)! < 10 {
                cnt = 1
                peristencyManager?.removeShuangGouList()
            }else{
                cnt = (peristencyManager?.getShuangGouList().count)!/10 + 1
            }
            
            let iswaybill:String = "0"
            let status:String = "0"
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: cnt.description, index: 1,paymentid:1)
            
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取待付款订单(待付款：paymentid=0，iswaybill=0，status=1)
    func requestMoreNonpaymentOrderList(userid:String)  {
        if (onlineState != false) {
            var cnt = Int()//(peristencyManager?.getNonpaymentOrderList().count)!/10 + 1
            if (peristencyManager?.getNonpaymentOrderList().count)! < 10 {
                cnt = 1
                peristencyManager?.removeDefaultNoPayOrderList()
            }else{
                cnt = (peristencyManager?.getNonpaymentOrderList().count)!/10 + 1
            }
            
            let iswaybill:String = "0"
            let status:String = "1"
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: cnt.description, index: 2,paymentid:0)

        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取待发货订单(待发货：paymentid=0，iswaybill=1，status=2)
    func requestMoreNoDeliverGoodsOrderList(userid:String)  {
        if (onlineState != false) {
            let cnt = (peristencyManager?.getNoDeliverOrderList().count)!/10 + 1
            if cnt == 1 {
                peristencyManager?.removeDefaultNoDeliverOrderList()
            }
            let iswaybill:String = "1"
            let status:String = "2"
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: cnt.description, index: 3,paymentid:0)

        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取待签收订单(待签收：paymentid=0，iswaybill=2，status=2)
    func requestMoreNoReceiveOrderList(userid:String)  {
        
        if (onlineState != false) {
            let cnt = (peristencyManager?.getNoReceiveOrderList().count)!/10 + 1
            if cnt == 1 {
                peristencyManager?.removeDefaultNoReceiveOrderList()
            }
            let iswaybill:String = "2"
            let status:String = "2"
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: cnt.description, index: 4,paymentid:0)

        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    //获取已完成（签收）订单(已完成：paymentid=0，iswaybill=3，status=2)
    func requestMoreCompletedOrderList(userid:String)  {
        
        if (onlineState != false) {
            let cnt = (peristencyManager?.getCompletedOrderList().count)!/10 + 1
            
            if cnt == 1 {
                peristencyManager?.removeDefaultCompletedOrderList()
            }
            
            let iswaybill:String = "3"
            let status:String = "2"
            httpClient?.requireOrderData(userid, iswaybill: iswaybill, status: status, currentpage: cnt.description,index:5,paymentid:0)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    
    
    
    internal func ordersListFromServer(model: OrderModel, index: Int) {
        
        if (model.code == 0) {
                switch index {
                case 0://全部订单
                    peristencyManager?.addAllOrderList(model.data)
                case 1://爽购订单
                    peristencyManager?.addShuangGouList(model.data)
                case 2://待支付订单
                    peristencyManager?.addNoPayOrderList(model.data)
                case 3://待发货订单
                    peristencyManager?.addNoDeliverOrderList(model.data)
                case 4://待签收订单
                    peristencyManager?.addNoReceiveOrderList(model.data)
                case 5://已签收订单
                    peristencyManager?.addcompletedOrderList(model.data)
                default:
                    break
                }
            
        }else{
            //发送通知，没有数据
            let notice = NSNotification(name: "OrderDataChanged", object: 10)
            NSNotificationCenter.defaultCenter().postNotification(notice)
            
            //错误描述
            respondErrorStatus(model.msg)
        }
        
        
    }
    
    /************************************************************************/
    //取消订单
    func cancelOrdetr(orderNum:String,index:Int)  {
        if (onlineState != false) {
            httpClient?.cancelOrder(orderNum, index: index)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    internal func cancelOrderFromServer(model :CancelOrderRootClass,index:Int){
        if (model.code == 0) {
            switch index {
            case 0://全部订单
                peristencyManager?.removeAllOrderByOrderNum(model.data)
            case 2://待支付订单
                peristencyManager?.removeWaitToPayOrderByOrderNum(model.data)
            default:
                break
            }
            respondErrorStatus(model.msg)
            
        }else{
            //发送通知，没有数据
            let notice = NSNotification(name: "OrderDataChanged", object: 10)
            NSNotificationCenter.defaultCenter().postNotification(notice)
            
            //错误描述
            respondErrorStatus(model.msg)
        }
    }
    
    /************************************************************************/
    //签收订单
    func signInOrder(orderNum:String,index:Int)  {
        if (onlineState != false) {
            httpClient?.signInOrder(orderNum, index: index)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    internal func signInOrderFromServer(model :CancelOrderRootClass,index:Int){
        if (model.code == 0) {
            switch index {
            case 0,1,4://全部订单里面的签收 //待签收订单
                peristencyManager?.removeAllOrderList()
                peristencyManager?.removeNoReceiveOrderList()
                peristencyManager?.removeShuangGouList()
                
                requestDefaultAllOrderListFromServer(userInfo_Global.keyid.description)
                requestDefaultShuangGouOrderListFromServer(userInfo_Global.keyid.description)
                requestDefaultWaitToReceivedOrderListFromServer(userInfo_Global.keyid.description)
            default:
                break
            }
            respondErrorStatus(model.msg)
            
        }else{
            //发送通知，没有数据
            let notice = NSNotification(name: "OrderDataChanged", object: 10)
            NSNotificationCenter.defaultCenter().postNotification(notice)
            
            //错误描述
            respondErrorStatus(model.msg)
        }
    }
    
    /************************************************************************/
    //删除完成的订单
    func deleteOrder(orderNum:String,index:Int)  {
        if (onlineState != false) {
            httpClient?.deleteOrder(orderNum, index: index)
        }else{
            respondErrorStatus("无可以网络")
        }
    }
    
    internal func deleteOrderFromServer(model: CancelOrderRootClass, index: Int) {
        if (model.code == 0) {
            switch index {
            case 0://全部订单
                peristencyManager?.removeAllOrderByOrderNum(model.data)
            case 1://爽购订单
                peristencyManager?.removeShuangGouOrderByOrderNum(model.data)
            case 5://已经完成订单
                peristencyManager?.removeCompleteOrderByOrderNum(model.data)
            default:
                break
            }
            
            respondErrorStatus(model.msg)
            
        }else{
            //发送通知，没有数据
            let notice = NSNotification(name: "OrderDataChanged", object: 10)
            NSNotificationCenter.defaultCenter().postNotification(notice)
            
            //错误描述
            respondErrorStatus(model.msg)
        }
    }
    
    /**
     通知控制器有错误信息或无更多数据...
     
     - parameter msg:
     */
    func respondErrorStatus(msg:String)  {
        let data = ["msg":msg]
        let notice = NSNotification(name: "OrderShowVC_ErrorOrNoMoreData", object: data)
        NSNotificationCenter.defaultCenter().postNotification(notice)
        
    }
    
}

