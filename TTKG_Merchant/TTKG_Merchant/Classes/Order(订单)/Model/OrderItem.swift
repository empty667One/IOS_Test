//
//	OrderItem.swift
//
//	Create by yd on 4/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

extension OrderItem {

    func ex_showCellInfo() -> (name:String,price:Double,num:Int,picUrl:String) {
        var name = String()
        var goodPrice = Double()
        var num = Int()
        var picUrl = String()
        
        name = self.productname
        
        goodPrice = self.price
        num = self.quantity
        picUrl = self.image
        
        return (name,goodPrice,num,picUrl)
    }
}


class OrderItem {

    var image : String!
    var price : Double!
    var productname : String!
    var quantity : Int!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        image = dictionary["image"] as? String
        price = dictionary["price"] as? Double
        productname = dictionary["productname"] as? String
        quantity = dictionary["quantity"] as? Int
    }
}