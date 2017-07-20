//
//  ClassifyCollectionCell.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/4.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit

class ClassifyCollectionCell: UICollectionViewCell {
    
    var classImage = UIImageView()
    var nameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(classImage)
        self.addSubview(nameLabel)
        classImage.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(5)
            make.top.equalTo(0).offset(5)
            make.right.equalTo(0).offset(-5)
            make.bottom.equalTo(0).offset(-20)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(classImage.snp_bottom)
            make.height.equalTo(20)
        }
        
        nameLabel.text = "我是可乐"
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.font = UIFont.systemFontOfSize(12)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
