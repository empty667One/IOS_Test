//
//  Data_Access_MD5_RSA.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/27.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class Data_Access_MD5_RSA: NSObject {

    func DataAccessTo_MD5_RSA(time:Int64) -> String {
        
        
        let key = "68A6BB9A2E47F5D620A20F34D399FC698DEB77DE"//待加密的key，参数加密成功后拼接在后面
        let str_MD5 = (key + "\(time)" ).md5()
        
        let rsa = RSA_Encryptor.sharedRSA_Encryptor()
        let publicKeyPath = NSBundle.mainBundle().pathForResource("public_key", ofType: "der")
        rsa.loadPublicKeyFromFile(publicKeyPath)
        let encryptedString = rsa.rsaEncryptString(str_MD5)
        
        return encryptedString
    }
    
    
}
