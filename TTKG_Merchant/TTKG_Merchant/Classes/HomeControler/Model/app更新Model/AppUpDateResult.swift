//
//	AppUpDateResult.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class AppUpDateResult{

	var advisories : [AnyObject]!
	var appletvScreenshotUrls : [AnyObject]!
	var artistId : Int!
	var artistName : String!
	var artistViewUrl : String!
	var artworkUrl100 : String!
	var artworkUrl512 : String!
	var artworkUrl60 : String!
	var bundleId : String!
	var contentAdvisoryRating : String!
	var currency : String!
	var currentVersionReleaseDate : String!
	var descriptionField : String!
	var features : [String]!
	var fileSizeBytes : String!
	var formattedPrice : String!
	var genreIds : [String]!
	var genres : [String]!
	var ipadScreenshotUrls : [String]!
	var isGameCenterEnabled : Bool!
	var isVppDeviceBasedLicensingEnabled : Bool!
	var kind : String!
	var languageCodesISO2A : [String]!
	var minimumOsVersion : String!
	var price : Int!
	var primaryGenreId : Int!
	var primaryGenreName : String!
	var releaseDate : String!
	var releaseNotes : String!
	var screenshotUrls : [String]!
	var sellerName : String!
	var sellerUrl : String!
	var supportedDevices : [String]!
	var trackCensoredName : String!
	var trackContentRating : String!
	var trackId : Int!
	var trackName : String!
	var trackViewUrl : String!
	var version : String!
	var wrapperType : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		advisories = dictionary["advisories"] as? [AnyObject]
		appletvScreenshotUrls = dictionary["appletvScreenshotUrls"] as? [AnyObject]
		artistId = dictionary["artistId"] as? Int
		artistName = dictionary["artistName"] as? String
		artistViewUrl = dictionary["artistViewUrl"] as? String
		artworkUrl100 = dictionary["artworkUrl100"] as? String
		artworkUrl512 = dictionary["artworkUrl512"] as? String
		artworkUrl60 = dictionary["artworkUrl60"] as? String
		bundleId = dictionary["bundleId"] as? String
		contentAdvisoryRating = dictionary["contentAdvisoryRating"] as? String
		currency = dictionary["currency"] as? String
		currentVersionReleaseDate = dictionary["currentVersionReleaseDate"] as? String
		descriptionField = dictionary["description"] as? String
		features = dictionary["features"] as? [String]
		fileSizeBytes = dictionary["fileSizeBytes"] as? String
		formattedPrice = dictionary["formattedPrice"] as? String
		genreIds = dictionary["genreIds"] as? [String]
		genres = dictionary["genres"] as? [String]
		ipadScreenshotUrls = dictionary["ipadScreenshotUrls"] as? [String]
		isGameCenterEnabled = dictionary["isGameCenterEnabled"] as? Bool
		isVppDeviceBasedLicensingEnabled = dictionary["isVppDeviceBasedLicensingEnabled"] as? Bool
		kind = dictionary["kind"] as? String
		languageCodesISO2A = dictionary["languageCodesISO2A"] as? [String]
		minimumOsVersion = dictionary["minimumOsVersion"] as? String
		price = dictionary["price"] as? Int
		primaryGenreId = dictionary["primaryGenreId"] as? Int
		primaryGenreName = dictionary["primaryGenreName"] as? String
		releaseDate = dictionary["releaseDate"] as? String
		releaseNotes = dictionary["releaseNotes"] as? String
		screenshotUrls = dictionary["screenshotUrls"] as? [String]
		sellerName = dictionary["sellerName"] as? String
		sellerUrl = dictionary["sellerUrl"] as? String
		supportedDevices = dictionary["supportedDevices"] as? [String]
		trackCensoredName = dictionary["trackCensoredName"] as? String
		trackContentRating = dictionary["trackContentRating"] as? String
		trackId = dictionary["trackId"] as? Int
		trackName = dictionary["trackName"] as? String
		trackViewUrl = dictionary["trackViewUrl"] as? String
		version = dictionary["version"] as? String
		wrapperType = dictionary["wrapperType"] as? String
	}

}