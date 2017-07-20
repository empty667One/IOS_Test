//
//	OrderModel.swift
//
//	Create by yd on 4/7/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class OrderModel{

    var code : Int!
    var data : [OrderList]!
    var msg : String!
    
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: NSDictionary){
        code = dictionary["code"] as? Int
        data = [OrderList]()
        if let dataArray = dictionary["data"] as? [NSDictionary]{
            for dic in dataArray{
                let value = OrderList(fromDictionary: dic)
                data.append(value)
            }
        }
        msg = dictionary["msg"] as? String
    }

}