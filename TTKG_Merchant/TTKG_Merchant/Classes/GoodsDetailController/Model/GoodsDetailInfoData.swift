//
//	GoodsDetailInfoData.swift
//
//	Create by yd on 12/8/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

extension GoodsDetailInfoData {
    func ex_headerInfo(index:Int)->(goodsName:String,imgUrlArry:[String],giftInfo:String,stockCnt:Int,sellCnt:Int,oldPrice:Double,nowPrice:Double,promotionStatus:Int) {
        //商品名称
        let goodsName:String = self.producttitle
        //对应规格的活动
        var giftInfo = String()
        if self.specioptions[index].isgivestate == true {//产品活动 0：开启，1：关闭
            giftInfo = self.specioptions[index].givemsg
        }
        //对应规格的库存
        var stockCnt = Int()
        stockCnt = self.specioptions[index].stock
        //对应规格的销量
        var sellCnt = Int()
        sellCnt = self.specioptions[index].salesvolume
        //对应规格的原价
        var oldPrice = Double()
        oldPrice = self.specioptions[index].originalprice
        //对应规格的现价(当开启促销状态时该价格为促销价)
        let nowPrice = self.specioptions[index].promotionalprice
        //该商品的促销状态(//产品活动 0：开启，1：关闭)
        var promotionStatus = Int()
        promotionStatus = self.specioptions[index].ispromotional
        
        var imgUrlArry = [String]()
        for item in self.specioptions[index].images {
            imgUrlArry.append(serverPicUrl + item.url)
        }
        
        return (goodsName,imgUrlArry,giftInfo,stockCnt,sellCnt,oldPrice,nowPrice,promotionStatus)
    }
    


    //返回该商品的首页规格名称
    func ex_allSpecificationName()-> [String]?{
        var allSpecificationName = [String]()
        for name in self.specioptions {
            allSpecificationName.append(name.specioptiontitle)
        }
        return allSpecificationName
    }


//    //返回该商家的活动
//    func shopActivity() -> String? {
//        var activity:String?
//        if  self.isGivestate == 0 {
//            activity = self.giveMsg
//        }
//        return activity
//    }

    //返回该商品的其他属性
    func ex_goodsMoreInfo() -> [String:String]? {
        var moreInfo = [String:String]()
        for item in self.propertys {
            let name = item.propertytitle
            
            if let value = item.propertyoptions.first?.title {
                moreInfo[ name] = value
            }
            
        }
        return moreInfo
    }
    
    
    func returnSpecitionSelectIndex(merchantkeyid : Int) ->Int {
    
        for index in 0..<self.specioptions.count {
            if merchantkeyid == self.specioptions[index].merchantkeyid {
                    return index
            }
        }
        return 0
    }
    
    

}




class GoodsDetailInfoData : NSObject, NSCoding{

	var pictureurl : String!
	var pricerang : String!
	var productid : Int!
	var producttitle : String!
	var propertys : [GoodsDetailInfoProperty]!
	var specioptions : [GoodsDetailInfoSpecioption]!
	var specititle : String!
	var totalsales : Int!
    

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		pictureurl = dictionary["pictureurl"] as? String
		pricerang = dictionary["pricerang"] as? String
		productid = dictionary["productid"] as? Int
		producttitle = dictionary["producttitle"] as? String
		propertys = [GoodsDetailInfoProperty]()
		if let propertysArray = dictionary["propertys"] as? [NSDictionary]{
			for dic in propertysArray{
				let value = GoodsDetailInfoProperty(fromDictionary: dic)
				propertys.append(value)
			}
		}
		specioptions = [GoodsDetailInfoSpecioption]()
		if let specioptionsArray = dictionary["specioptions"] as? [NSDictionary]{
			for dic in specioptionsArray{
				let value = GoodsDetailInfoSpecioption(fromDictionary: dic)
				specioptions.append(value)
			}
		}
		specititle = dictionary["specititle"] as? String
		totalsales = dictionary["totalsales"] as? Int
        
	}

	/**
	 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if pictureurl != nil{
			dictionary["pictureurl"] = pictureurl
		}
		if pricerang != nil{
			dictionary["pricerang"] = pricerang
		}
		if productid != nil{
			dictionary["productid"] = productid
		}
		if producttitle != nil{
			dictionary["producttitle"] = producttitle
		}
		if propertys != nil{
			var dictionaryElements = [NSDictionary]()
			for propertysElement in propertys {
				dictionaryElements.append(propertysElement.toDictionary())
			}
			dictionary["propertys"] = dictionaryElements
		}
		if specioptions != nil{
			var dictionaryElements = [NSDictionary]()
			for specioptionsElement in specioptions {
				dictionaryElements.append(specioptionsElement.toDictionary())
			}
			dictionary["specioptions"] = dictionaryElements
		}
		if specititle != nil{
			dictionary["specititle"] = specititle
		}
		if totalsales != nil{
			dictionary["totalsales"] = totalsales
		}
        
        
        
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         pictureurl = aDecoder.decodeObjectForKey("pictureurl") as? String
         pricerang = aDecoder.decodeObjectForKey("pricerang") as? String
         productid = aDecoder.decodeObjectForKey("productid") as? Int
         producttitle = aDecoder.decodeObjectForKey("producttitle") as? String
         propertys = aDecoder.decodeObjectForKey("propertys") as? [GoodsDetailInfoProperty]
         specioptions = aDecoder.decodeObjectForKey("specioptions") as? [GoodsDetailInfoSpecioption]
         specititle = aDecoder.decodeObjectForKey("specititle") as? String
         totalsales = aDecoder.decodeObjectForKey("totalsales") as? Int
        

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if pictureurl != nil{
			aCoder.encodeObject(pictureurl, forKey: "pictureurl")
		}
		if pricerang != nil{
			aCoder.encodeObject(pricerang, forKey: "pricerang")
		}
		if productid != nil{
			aCoder.encodeObject(productid, forKey: "productid")
		}
		if producttitle != nil{
			aCoder.encodeObject(producttitle, forKey: "producttitle")
		}
		if propertys != nil{
			aCoder.encodeObject(propertys, forKey: "propertys")
		}
		if specioptions != nil{
			aCoder.encodeObject(specioptions, forKey: "specioptions")
		}
		if specititle != nil{
			aCoder.encodeObject(specititle, forKey: "specititle")
		}
		if totalsales != nil{
			aCoder.encodeObject(totalsales, forKey: "totalsales")
		}
        
        

	}

}