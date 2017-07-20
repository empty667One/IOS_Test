//
//  ShoppingCarAPI.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/3.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation


class ShoppingCarAPI:ShoppingCarHTTPClientDelegate{
    
    /*单例*/
    static let shareInstance = ShoppingCarAPI()
    private  init() {
    
    persistencyManager = ShoppingCarManager()
    httpClient = ShoppingCarHTTPClient()
    httpClient.delegate = self
    }
    
    private let persistencyManager:ShoppingCarManager
    private let httpClient:ShoppingCarHTTPClient
    
    /**
     请求购物车数据
     
     - parameter userid: 
     */
    func requestShoppingCarListFromServer(userid: Int)  {
        if onlineState {
            httpClient.requestShoppingCarList(userid)
        }else{
            shoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    func removeAllShopCarData(){
        persistencyManager.removeShopCarAllGoods()
    }
    
    func getShoppingCarData() -> [ShoppingCarData] {
        return persistencyManager.shoppingCarDatas
    }
    
    
    /**
     设置哪一家下面对应的商品选中状态
     
     - parameter section: section description
     - parameter status:  status description
     */
    func setSelectCellBtn(section:NSIndexPath,status:Bool) {
        persistencyManager.shoppingCarDatas[section.section].products[section.row].selectedFlag = status
    }
    
    
    
    
    
    /**
     移除购物车
     
     - parameter indexPath: indexPath description
     */
    func removeGoodsFromShoppingCar(cartids:[Int]){
        if onlineState {
            var cartidsStr = String()
            
            for value in cartids {
                if value != cartids.last {
                    cartidsStr += String(value) + ","
                }else{
                    cartidsStr += String(value)
                }
            }
            
            httpClient.removeGoods(cartidsStr,cartids: cartids)
        }else{
            shoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    
    
    /**
     设置对应商家下所有选中状态
     
     - parameter selectedFlag:
     */
    func setAllSelectCellBtn(index:Int,selectedFlag:Bool) {
        for item in persistencyManager.shoppingCarDatas[index].products {
            item.selectedFlag = selectedFlag
        }
    }
    
    
    
    
    
    
    /**
     重置商品数量
     
     - parameter cartid:   cartid description
     - parameter quantity: quantity description
     */
    func resetShopCarGoodsNum(cartid:Int,quantity:Int) {
        if onlineState {
           httpClient.requestResetShopCarGoodsNum(cartid,quantity: quantity)
        }else{
           shoppingCarAPI_SendErrorMsg(onlineErrorMsg, status: "404")
        }
    }
    
    
    /********************************************************/
    /********************************************************/
    /********************************************************/
    private func shoppingCarAPI_SendErrorMsg(errorMsg:String,status:String){
        let errorContent = ["errorMsg":errorMsg,"status":status]
        let notice:NSNotification =  NSNotification(name: "ShoppingCarAPI_SendErrorMsg", object: errorContent)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
    
    
    /**
     获取购物车信息
     
     - parameter model: model description
     */
   internal func responseShoppingCarListData(model:ShoppingCarRootClass){
        if model.code == 0 {
            persistencyManager.shoppingCarDatas = model.data
        }else{
            shoppingCarAPI_SendErrorMsg(model.msg, status: "404")
        }
    }
    
    /**
     移除购物车响应
     
     - parameter cede:    cede description
     - parameter msg:     msg description
     - parameter cartids: cartids description
     */
    internal func responseRemoveShoppingCar(code:Int,msg:String,cartids:[Int]){
        if code == 0 {//删除成功
            var shoppingCarDatas = persistencyManager.shoppingCarDatas
            //遍历所有需要删除的id
            for cartid in cartids {                     //商品购物车ID
                for shop in shoppingCarDatas { //商家
                    //由于保存没有被删除的商品数据
                    var productsTemp = [ShoppingCarProduct]()
                    
                    for (index,item) in shop.products.enumerate() {

                        if item.cartid != cartid {
                            productsTemp.append(item)
                        }
                    }
                    shop.products = productsTemp
                }
            }
            
        
            //再次给商家下商品再次赋值
            var dataTemp = [ShoppingCarData]()
            for (index,shop) in shoppingCarDatas.enumerate() { //商家
                if shop.products.count != 0 {
                    dataTemp.append(shop)
                    
                }
            }
            
            persistencyManager.shoppingCarDatas = dataTemp
            
            shoppingCarAPI_SendErrorMsg(msg, status: "404")
        }else{
            shoppingCarAPI_SendErrorMsg(msg, status: "404")
        }
    }
    
    /**
     重置商品数量
     
     - parameter code:   code description
     - parameter msg:    msg description
     - parameter cartid: cartid description
     */
    internal func responseResetShopCarGoodsNum(code:Int,msg:String,cartid:Int,num:Int){
        if code == 0 {
            //shoppingCarAPI_SendErrorMsg(msg, status: "404")
            
            let shoppingCarDatas = persistencyManager.shoppingCarDatas
            
                for shop in shoppingCarDatas { //商家
                    for (index,item) in shop.products.enumerate() {
                        if item.cartid == cartid {
                            shop.products[index].quantity = num
                            break
                        }
                    }
                }
            
            persistencyManager.shoppingCarDatas = shoppingCarDatas
            
            
        }else{
            shoppingCarAPI_SendErrorMsg(msg, status: "404")
        }
    }
    
}