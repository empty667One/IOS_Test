//
//  WXPrePay.swift
//  TTKG_Custmer
//
//  Created by yd on 16/6/24.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation


struct WXPrePay {
    let appID: String
    let noncestr: String
    let package: String
    let partnerID: String
    let prepayID: String
    let sign: String
    let timestamp: Int
    
    init(appID: String,
        noncestr: String,
        package: String,
        partnerID: String,
        prepayID: String,
        sign: String,
        timestamp: Int) {
            self.appID = appID
            self.noncestr = noncestr
            self.package = package
            self.partnerID = partnerID
            self.prepayID = prepayID
            self.sign = sign
            self.timestamp = timestamp
    }

}