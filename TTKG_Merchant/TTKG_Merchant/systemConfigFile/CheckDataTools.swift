//
//  CheckDataTools.swift
//  TTKG_Custmer
//
//  Created by yd on 16/6/15.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class CheckDataTools: NSObject {

    class private func baseCheckForRegEx(regEx:String,data:String)->Bool {
        let card = NSPredicate(format: "SELF MATCHES %@", regEx)//(format: regEx as String,argumentArray: nil)
        if card.evaluateWithObject(data){
            return true
        }
        return false
    }
    
    /*!
    只能输入数字
    
    */
    class func checkForNumber(number:String)->Bool {
        let regEx = "^[0-9]*$"
        return baseCheckForRegEx(regEx, data: number)
    }
    /*!
    特殊字符
    
    */
    class func checkForSpecialChar(data:String)->Bool{
        let regEx = "[^%&',;=?$" + "\" + x22]+"
        return baseCheckForRegEx(regEx, data: data)
    }
    
    
    /*!
    校验只能输入n位的数字
    
    */
    class  func checkForNumberWithLength(length:String,number:String)->Bool{
        let regEx = "^\\d{\(length)}$"
        return baseCheckForRegEx(regEx, data: number)
    }
    
    class func checkForNumbberAndStringWithLength(shortlength:String,longLongth:String,string:String)->Bool{
        let regEx = "^[A-Za-z0-9]{\(shortlength),\(longLongth)}$"
        return baseCheckForRegEx(regEx, data: string)
    }
    
    /*!
    26位英文字母
    
    */
    class func checkForLowerAndUpperCase(data:String)->Bool{
        let regEx = "^[A-Za-z]+$"
        return baseCheckForRegEx(regEx, data: data)
    }
    /*!
    大写字母
    
    */
    class func checkForUpperCase(data:String)->Bool{
        let regEx = "^[A-Z]+$"
        return baseCheckForRegEx(regEx, data: data)
    }
    /*!
    小写字母
    */
    class func checkForLowerCase(data:String)->Bool{
        let regEx = "^[a-z]+$"
        return baseCheckForRegEx(regEx, data: data)
    }
    /*!
    由数字和26个英文字母组成的字符串
    
    */
    class func checkForNumberAndCase(data:String)->Bool{
        let regEx = "^[A-Za-z0-9]+$"
        return baseCheckForRegEx(regEx, data: data)
    }
    /*!
    密码校验
    */
    class func checkForPasswordWithShortest(shortest:NSInteger,longest:NSInteger,pwd:String)->Bool{
        let regEx = String(format: "^[a-zA-Z0-9]{%ld,%ld}+$",shortest,longest)
        return baseCheckForRegEx(regEx, data: pwd)
    }
    /*!
    身份证号验证
    */
    class func checkForIDCard(idCard:String)->Bool{
        let regEx = "\\d{14}[[0-9],0-9xX]"
        return baseCheckForRegEx(regEx, data: idCard)
    }
    
    /*!
    验证电话号
    */
    class func checkForPhoneNumber(phone:String)->Bool{
        let regEx = "^(\\d{3,4}-)\\d{7,8}$"
        return baseCheckForRegEx(regEx, data: phone)
    }
    
    /*!
    验证手机号
    */
    class func checkForMobilePhoneNumber(mobilePhoneNum:String)->Bool{
        let regEx = "^1[3|4|5|7|8][0-9]\\d{8}$"
        return baseCheckForRegEx(regEx, data: mobilePhoneNum)
    }
    
    class func checkForEmail(email:String)->Bool{
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return baseCheckForRegEx(regEx, data: email)
    }
    
    
}
