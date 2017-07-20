//
//  HomeVCFirstCell.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVCFirstCell: UICollectionViewCell {
    
    var name = UILabel()      //商品分类标题
    let subLabel = UILabel()  //副标题
    var icon = UIImageView()  //商品图片
    
    var iconUrl = String(){
        didSet{
//            self.icon.sd_setImageWithURL(NSURL(string : serverPicUrl + iconUrl))
            icon.image = UIImage(named: iconUrl)
        }
    }

    var nameStr = String(){
        didSet{
            self.name.text = nameStr
            
        }
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        //商品分类标题
        self.addSubview(name)
        
        name.textAlignment = NSTextAlignment.Center

        name.snp_makeConstraints { (make) in
            
            make.top.equalTo(0).offset(15)
            make.left.right.equalTo(0)
            make.height.equalTo(20)
            
        }
       
        //副标题
        self.addSubview(subLabel)
        subLabel.snp_makeConstraints { (make) in
            make.top.equalTo(name.snp_bottom).offset(0)
            make.left.right.equalTo(0)
            make.height.equalTo(0)
        }
        subLabel.text = "进入分类"
        subLabel.font = UIFont.systemFontOfSize(8)
        subLabel.textColor = UIColor.lightGrayColor()
        subLabel.textAlignment = NSTextAlignment.Center
        
        //商品图片
        
        let h = 36/27*self.frame.size.width

        self.addSubview(icon)
        icon.snp_makeConstraints { (make) in
            
//            make.top.equalTo(subLabel.snp_bottom).offset(5)
//            make.left.equalTo(5)
//            make.right.equalTo(-5)
//            make.bottom.equalTo(-5)
                make.left.equalTo(self.snp_left)
                make.right.equalTo(self.snp_right)
                make.bottom.equalTo(self.snp_bottom)
                make.height.equalTo(h - 8)

        }
//        icon.contentMode = .ScaleAspectFit
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
