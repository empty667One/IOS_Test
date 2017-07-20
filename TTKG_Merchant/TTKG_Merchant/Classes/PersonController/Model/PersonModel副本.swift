//
//  PersonModel.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

extension OrderListData{
    
    /**
     返回大品牌名称和图片url
     
     - returns:
     */
//    func ex_ex_dataForCellShow()->(name:String,imgUrl:String){
//        return (self.name,self.icon)
//    }
}

class OrderListData{
    
    var orderno : String!
    var creattime : String!
    var producttitle : String!
    var number : Int!
    var price : Int!
    var totalprice : Int!
    var detail_remark : String!

    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        orderno = dictionary["orderno"] as? String
        creattime = dictionary["creattime"] as? String
        producttitle = dictionary["producttitle"] as? String
        number = dictionary["number"] as? Int
        price = dictionary["price"] as? Int
        totalprice = dictionary["totalprice"] as? Int
        detail_remark = dictionary["detail_remark"] as? String

    }
    
}