//
//  HalfAlphaBroadcoastImageView.swift
//  ttkg_customer
//
//  Created by iosnull on 16/7/13.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit
import SnapKit

class HalfAlphaBroadcoastImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var broadCoastStr = String(){
        didSet{
            broadCoast.text = broadCoastStr
        }
    }
    
    private var title = UILabel()
    private var broadCoast = UILabel()
    private var disImg = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.userInteractionEnabled = true
        
        self.image = UIImage(named: "halfAlphaImg")
        self.contentMode = .ScaleAspectFill
        
        broadCoast.font = UIFont.systemFontOfSize(17)
        broadCoast.textColor = UIColor.redColor()
        self.addSubview(title)
        title.text = "小店公告"
        title.textAlignment = .Center
        title.textColor = UIColor.redColor()
        title.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(100)
            make.height.equalTo(40)
        }
        
        
        self.addSubview(broadCoast)
        broadCoast.font = UIFont.systemFontOfSize(14)
        broadCoast.textColor = UIColor.redColor()
        broadCoast.textAlignment = .Center
        broadCoast.numberOfLines = 0
        broadCoast.snp_makeConstraints { (make) in
            make.top.equalTo(title.snp_bottom)
            make.left.equalTo(0).offset(10)
            make.right.equalTo(0).offset(-10)
            make.height.equalTo(120)
        }
        self.addSubview(disImg)
        disImg.image = UIImage(named: "disMissBtnImg")
        disImg.snp_makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.bottom.equalTo(self.snp_bottom).offset(-60)
            make.centerX.equalTo(self.snp_centerX)
        }
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HalfAlphaBroadcoastImageView.disBtnClk))
        gestureRecognizer.numberOfTapsRequired=1
        gestureRecognizer.numberOfTouchesRequired=1
        
        self.addGestureRecognizer(gestureRecognizer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func disBtnClk(){
        self.removeFromSuperview()
    }
    
}
