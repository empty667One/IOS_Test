//
//  HomeVCSecondCell.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class HomeVCSecondCell: UICollectionViewCell {
    
    
    var name = UILabel()

    var icon = UIImageView()
    
    var iconUrl = String(){
        didSet{
            self.icon.sd_setImageWithURL(NSURL(string : serverPicUrl + iconUrl))
        }
    }

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(name)
        
        name.font = UIFont.systemFontOfSize(14)
        
        name.textAlignment = NSTextAlignment.Center
        
        name.snp_makeConstraints { (make) in
            
            make.top.equalTo(0).offset(10)
            make.width.equalTo(self.frame.width)
        }
        
        
        self.addSubview(icon)
        icon.snp_makeConstraints { (make) in
            
            make.height.equalTo(50)
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.bottom.equalTo(0).offset(-10)
        }
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
        
}