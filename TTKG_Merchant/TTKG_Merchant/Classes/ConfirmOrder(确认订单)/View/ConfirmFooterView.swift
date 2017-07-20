//
//  ConfirmFooterView.swift
//  ttkg_customer
//
//  Created by yd on 16/7/11.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

protocol ConfirmFooterViewDelegate {
    func getLeaveMessageText(index:Int,text:String)
}


class ConfirmFooterView: UIView {

    var delegates : ConfirmFooterViewDelegate!
    
    let name = UILabel()//备注名
    
    let leaveMessage = UITextField()//留言信息
    
    let lineView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(name)
        self.addSubview(leaveMessage)
        self.addSubview(lineView)
        
        name.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(10)
            make.top.equalTo(0).offset(10)
            make.bottom.equalTo(0).offset(-10)
            make.width.equalTo(70)
        }
        name.text = "买家留言 :"
        name.font = UIFont.systemFontOfSize(13)
        leaveMessage.snp_makeConstraints { (make) in
            make.left.equalTo(name.snp_right)
            make.top.equalTo(0).offset(8)
            make.right.equalTo(0)
            make.bottom.equalTo(0).offset(-8)
        }
        leaveMessage.font = UIFont.systemFontOfSize(13)
        leaveMessage.placeholder = "选填，可填写您和卖家达成一致的要求"
        leaveMessage.addTarget(self, action: #selector(ConfirmFooterView.getString(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
        
        
        lineView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        lineView.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 247/255, alpha: 1.0)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getString(text:UITextField){
        
        self.delegates.getLeaveMessageText(text.tag,text: text.text!)
    }
    

}
