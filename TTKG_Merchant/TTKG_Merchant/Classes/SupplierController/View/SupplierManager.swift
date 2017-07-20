//
//  SupplierManager.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/9.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation

class SupplierManager {
    
    private var modelCnt = 0{
        didSet{
            SupplierModelChange()
        }
    }
    
    var merchantInfoDatas :[MerchantInfoData] = []{
        didSet{
            modelCnt += 1
        }
    }
    

    
    func addMerchantInfoDatas(merchantInfoData:[MerchantInfoData])  {
        for item in merchantInfoData {
            
            var flag = true
            
            for itemTemp:MerchantInfoData in self.merchantInfoDatas {
                if itemTemp.shopid == item.shopid {
                    flag = false
                    break
                }
            }
            
            if flag {
                self.merchantInfoDatas.append(item)
            }
            
        }
        
    }
    
  

    
    func SupplierModelChange() {
        
        let notice:NSNotification =  NSNotification(name: "SupplierModelChange", object: nil)
        NSNotificationCenter.defaultCenter().postNotification(notice)
        
    }
    
}