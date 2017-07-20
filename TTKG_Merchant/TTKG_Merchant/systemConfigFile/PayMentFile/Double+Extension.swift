//
//  Double+Extension.swift
//  TTKG_Custmer
//
//  Created by yd on 16/6/24.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation


extension Double {
    func format(f:String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }
}