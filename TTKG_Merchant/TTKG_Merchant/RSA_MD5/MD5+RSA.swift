//
//  MD5+RSA.swift
//  MD5+RSA
//
//  Created by yd on 16/7/22.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit


extension String {
    func md5() -> String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        let hashStr = NSMutableString()
        
        
        
        for i in 0 ..< digestLen {
            hashStr.appendFormat("%02x", result[i])
            print( "result[\(i)] =  \(result[i])")
        }
        
        
        let tempData = NSData(bytes: result, length: Int(CC_MD5_DIGEST_LENGTH))
        let strTemp = tempData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        result.destroy()
        
        return String(format: strTemp as String)
        
    }
}

extension NSDate {
    func  getLocationTime() -> Int64 {
        let refDate = NSDate()
        let timeTemp = Int64(refDate.timeIntervalSince1970*1000)
        
        return timeTemp
    }
}




