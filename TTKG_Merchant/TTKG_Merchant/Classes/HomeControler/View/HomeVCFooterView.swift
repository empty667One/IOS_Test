//
//  HomeVCFooterView.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/5.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit


protocol HomeVCFooterViewDelegate {
    func FirstFooterAddImageClickToPushVC()
}

class HomeVCFooterView: UICollectionReusableView {
    
    var delegate : HomeVCFooterViewDelegate?
    
    let addImage = UIImageView()
    
    var picurl : String?{
        didSet{
            if picurl != nil {
                self.addImage.sd_setImageWithURL(NSURL(string : serverPicUrl + picurl!))
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addImage.userInteractionEnabled = true
        let tapG = UITapGestureRecognizer(target: self, action: #selector(self.addImageClick))
        addImage.addGestureRecognizer(tapG)
        self.addSubview(addImage)
        addImage.snp_makeConstraints { (make) in
            
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
    }
    
    func addImageClick()  {
        
        self.delegate?.FirstFooterAddImageClickToPushVC()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
