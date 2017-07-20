//
//	OrderList.swift
//
//	Create by yd on 4/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


extension OrderList {
    func goodsCurrentShopPriceAndCount() ->(allCnt:Int,priceOfCurrentShopGoods:Double,haveLargesses:Bool) {
        var allCnt = 0
        for i in 0..<self.details.count {
            allCnt += self.details[i].quantity
        }
        
        var priceOfCurrentShopGoods = Double()
        priceOfCurrentShopGoods = Double(self.paidamount)
        
        return (allCnt,priceOfCurrentShopGoods,self.hasactivitie)
    }

    //根据订单状态返回不同的footerview
    func ex_footerViewForSection() -> UIView? {

        
        var view:UIView?

        
        //"待付款"
        if (self.iswaybill == 0)&&(self.status == 1) {
            view =  OrderWaitToPayFooterView()
        }
        
        //"爽购"
        if (iswaybill == 0) && (status == 0){
            view = OrderCompleteFooterView()
        }
        
        //"待发货"
        if ((self.iswaybill == 1)&&(self.status == 1))||((self.iswaybill == 1)&&(self.status == 2)){
            view = OrderWaitToDeliveryFooterView()
        }
        //"待签收"
        if ((self.iswaybill == 2)&&(self.status == 1))||((self.iswaybill == 2)&&(self.status == 2) ){
            view = OrderWaitToSignInFooterView()
        }
        //"已完成"
        if (iswaybill == 3) && (status == 2){
            view = OrderCompleteFooterView()
        }
        
        return view
    }

    //订单状态
    func ex_orderStatus() -> String {
        //"待付款"
        if (self.iswaybill == 0)&&(self.status == 1) {
            return "待付款"
        }
        
        //"爽购"
        if (iswaybill == 0) && (status == 0){
            return "爽购"
        }
        
        //"待发货"
        if ((self.iswaybill == 1)&&(self.status == 1))||((self.iswaybill == 1)&&(self.status == 2)){
            return "待发货"
        }
        //"待签收"
        if ((self.iswaybill == 2)&&(self.status == 1))||((self.iswaybill == 2)&&(self.status == 2) ){
            return "待签收"
        }
        //"已完成"
        if (iswaybill == 3) && (status == 2){
            return "已完成"
        }
        
        return ""

    }
    
    //订单状态返回footer的高度
    func ex_orderStatusForFooterHeight() ->Double {
        
        if ((self.iswaybill == 1)&&(self.status == 1))||((self.iswaybill == 1)&&(self.status == 2)) {
            return 0.00
        }else{
            return 35.00
        }

    }
    
    func ex_forHeaderInfo() ->(shopName:String,orderNum:String,orderState:String){
        let shopName = self.shopname
        let orderNum = self.orderno
        
        var orderState = String()
        
        
        
        
        if (self.iswaybill == 0)&&(self.status == 1) {      //待付款：paymentid=0，iswaybill=0，status=1
            orderState = "待付款"
            
        }else if ((self.iswaybill == 1)&&(self.status == 1))||((self.iswaybill == 1)&&(self.status == 2)) {//待发货：paymentid=0，iswaybill=1，status=2
            orderState = "待发货(" + self.payment + ")"
            
        }else if ((self.iswaybill == 2)&&(self.status == 1))||((self.iswaybill == 2)&&(self.status == 2) ){//待签收：paymentid=0，iswaybill=2，status=2
            orderState = "待签收(" + self.payment + ")"
            
        }else if (self.iswaybill == 3)&&(self.status == 2) {//已完成：paymentid=0，iswaybill=3，status=2
            orderState = "已完成(" + self.payment + ")"
            
        }else{
            orderState = ""
        }
        
        return (shopName,orderNum,orderState)
    }
//
////    func ex_valueForFooterView() ->(sellCnt:Int,allPrice:Double,giftFalg:Bool) {
////        //商品件数
////        var sellCnt = 0
////        for item in self.item {
////            sellCnt += item.number
////        }
////        
////        //是否有赠送的东西
////        var giftFalg = false
////        if (isGivestate == 0) {
////            giftFalg = true
////        }else{
////            giftFalg = false
////        }
////        
////        //商品总价
////        let allPrice = Double(self.paidAmount)
////        
////
////        return (sellCnt,allPrice,giftFalg)
////    }
}
//
//
extension OrderList{
    //支付宝支付需要的参数
    func ex_payForAlipay()->(tradeNo:String,productName:String,productDescription:String,amount:Double){
        let tradeNo = self.orderno
        var  productName = String()
        for item in self.details {
            productName += item.productname + "."
        }
        let productDescription = productName
        let totalprice = self.paidamount
        return (tradeNo,productName,productDescription,totalprice!)
    }
    
}

class OrderList {

    var activitiemassage : String!
    var details : [OrderItem]!
    var hasactivitie : Bool!
    var iswaybill : Int!
    var orderno : String!
    var paidamount : Double!
    var payment : String!
    var shopid : Int!
    var shopname : String!
    var status : Int!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        activitiemassage = dictionary["activitiemassage"] as? String
        details = [OrderItem]()
        if let detailsArray = dictionary["details"] as? [NSDictionary]{
            for dic in detailsArray{
                let value = OrderItem(fromDictionary: dic)
                details.append(value)
            }
        }
        hasactivitie = dictionary["hasactivitie"] as? Bool
        iswaybill = dictionary["iswaybill"] as? Int
        orderno = dictionary["orderno"] as? String
        paidamount = dictionary["paidamount"] as? Double
        payment = dictionary["payment"] as? String
        shopid = dictionary["shopid"] as? Int
        shopname = dictionary["shopname"] as? String
        status = dictionary["status"] as? Int
    }

}