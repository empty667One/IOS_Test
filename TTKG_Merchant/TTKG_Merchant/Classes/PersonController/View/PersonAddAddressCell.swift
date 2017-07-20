//
//  PersonAddAddressCell.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/16.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit



class PersonAddAddressCell: UITableViewCell, UITextFieldDelegate {

    let title = UILabel()
    
    let textView = UITextField()
    
//    let textView = UITextView()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        title.font = UIFont.systemFontOfSize(14)
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(10)
            make.top.equalTo(0).offset(15)
            make.bottom.equalTo(0).offset(-15)
            make.width.equalTo(64)
            
        }
        

                

        //textView.addTarget(PersonAddAddressVC(), action: #selector(PersonAddAddressVC.didChangeText(_:)), forControlEvents: .EditingChanged)
        //textView.addTarget(PersonModifyAddressVC(), action: #selector(PersonModifyAddressVC.didChangeText(_:)), forControlEvents: .EditingChanged)
        //textView.addTarget(PersonDataVC(), action: #selector(PersonDataVC.didChangeText(_:)), forControlEvents: .EditingChanged)
        textView.font = UIFont.systemFontOfSize(14)
        self.addSubview(textView)
        textView.snp_makeConstraints { (make) in
            make.left.equalTo(title.snp_right).offset(6)
            make.top.equalTo(0).offset(0)
            make.bottom.equalTo(0).offset(0)
            make.right.equalTo(0).offset(-10)
        }

    }
        
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
