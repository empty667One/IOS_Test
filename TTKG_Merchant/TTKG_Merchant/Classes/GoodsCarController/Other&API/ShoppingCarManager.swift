//
//  ShoppingCarManager.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/3.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

class ShoppingCarManager {
    var shoppingCarDatas = [ShoppingCarData](){
        didSet{
            shoppingCarModelChanged()
        }
    }
    
    /********************************************************/
    func removeShopCarAllGoods(){
        self.shoppingCarDatas = [ ]
    }
    
    
    /********************************************************/
    /********************************************************/
    
    private func shoppingCarModelChanged(){
        let notice:NSNotification =  NSNotification(name: "shoppingCarModelChanged", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notice)
    }
}