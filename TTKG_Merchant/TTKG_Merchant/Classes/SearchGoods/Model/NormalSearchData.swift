//
//	NormalSearchData.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class NormalSearchData : NSObject, NSCoding{

	var adminid : Int!
	var list : [NormalSearchList]!
	var pageindex : Int!
	var pagesize : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		adminid = dictionary["adminid"] as? Int
		list = [NormalSearchList]()
		if let listArray = dictionary["list"] as? [NSDictionary]{
			for dic in listArray{
				let value = NormalSearchList(fromDictionary: dic)
				list.append(value)
			}
		}
		pageindex = dictionary["pageindex"] as? Int
		pagesize = dictionary["pagesize"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if adminid != nil{
			dictionary["adminid"] = adminid
		}
		if list != nil{
			var dictionaryElements = [NSDictionary]()
			for listElement in list {
				dictionaryElements.append(listElement.toDictionary())
			}
			dictionary["list"] = dictionaryElements
		}
		if pageindex != nil{
			dictionary["pageindex"] = pageindex
		}
		if pagesize != nil{
			dictionary["pagesize"] = pagesize
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         adminid = aDecoder.decodeObjectForKey("adminid") as? Int
         list = aDecoder.decodeObjectForKey("list") as? [NormalSearchList]
         pageindex = aDecoder.decodeObjectForKey("pageindex") as? Int
         pagesize = aDecoder.decodeObjectForKey("pagesize") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encodeWithCoder(aCoder: NSCoder)
	{
		if adminid != nil{
			aCoder.encodeObject(adminid, forKey: "adminid")
		}
		if list != nil{
			aCoder.encodeObject(list, forKey: "list")
		}
		if pageindex != nil{
			aCoder.encodeObject(pageindex, forKey: "pageindex")
		}
		if pagesize != nil{
			aCoder.encodeObject(pagesize, forKey: "pagesize")
		}

	}

}