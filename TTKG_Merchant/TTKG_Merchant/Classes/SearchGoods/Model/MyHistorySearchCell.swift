//
//  MyHistorySearchCell.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/12.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import Foundation
import UIKit

class MyHistorySearchCell: UITableViewCell {
    
    
    let imgView = UIImageView()
    var title = UILabel()
    
    private let spareLine = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgView.frame = CGRect(x: 8, y: 4, width: 20, height: 20)
        title.frame = CGRect(x: 40, y: 0, width: UIScreen.mainScreen().bounds.width - 50, height: 28)
        self.addSubview(imgView)
        title.font = UIFont.systemFontOfSize(14)
        imgView.image = UIImage(named: "timer")
        self.addSubview(title)
        
        spareLine.frame = CGRect(x: 8, y: 29, width: UIScreen.mainScreen().bounds.width - 16, height: 1)
        spareLine.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        self.addSubview(spareLine)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}