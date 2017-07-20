//
//	ShoppingCarData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


extension ShoppingCarData {
    //选中该商家下所有商品了吗？
    func ex_selectedAllGoodsFlag()->Bool {
        for item in products {
            if !item.selectedFlag {
                return false
            }
        }
        return true
    }
    
    //某一个商品需要展示到界面的信息
    func ex_goodsInfo(index:Int)->(name:String,price:Double,img:String,num:Int,selectedFlag:Bool){
        var name:String
        var price:Double
        var img:String
        var num:Int
        var selectedFlag:Bool
        
        let goods:ShoppingCarProduct = self.products[index]
        name = goods.productname
        price = goods.price
        img = goods.image
        num = goods.quantity
        selectedFlag = goods.selectedFlag
        return (name,price,img,num,selectedFlag)
    }
    
    func ex_checkMerchantQPCondition() -> Bool {
        var priceTemp = 0.00
        
        for item in self.products {
            if item.selectedFlag {
                priceTemp = item.price * Double(item.quantity)
            }
        }
        
        if self.carryingamount < priceTemp {
            return true
        }else{
            return false
        }
    }
    
    
    
    
    
}

class ShoppingCarData{

	var activitie : String!
	var carryingamount : Double!
	var products : [ShoppingCarProduct]!
	var shopid : Int!
	var shopname : String!

    //当商家活动内容多，需要多行显示时候用
    var showMoreLineActivitie = false
	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		activitie = dictionary["activitie"] as? String
		carryingamount = dictionary["carryingamount"] as? Double
		products = [ShoppingCarProduct]()
		if let productsArray = dictionary["products"] as? [NSDictionary]{
			for dic in productsArray{
				let value = ShoppingCarProduct(fromDictionary: dic)
				products.append(value)
			}
		}
		shopid = dictionary["shopid"] as? Int
		shopname = dictionary["shopname"] as? String
	}

}