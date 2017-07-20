//
//  HomeVCSecondHeaderView.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/4.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class HomeVCSecondHeaderView: UICollectionReusableView {
 
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        self.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            make.top.equalTo(0).offset(0)
            make.bottom.equalTo(0).offset(0)
            make.left.equalTo(0).offset(0)
            make.right.equalTo(0).offset(0)
            
        }
//        imageView.contentMode = .ScaleAspectFit
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
