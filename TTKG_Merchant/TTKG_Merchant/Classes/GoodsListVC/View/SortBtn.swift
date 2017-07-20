//
//  SortBtn.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/5.
//  Copyright © 2016年 yd. All rights reserved.
//

import Foundation
import SnapKit


protocol SortBtnDelegate {
    func sortBtnClk(title:String,status:SortBtnStatus)
}


enum SortBtnStatus {
    case sortUp
    case sortDown
    case noSort
}

class SortBtn: UIView {
    
    var delegate:SortBtnDelegate?
    
    private var button = UIButton()
    private var img = UIImageView()
    var title = UILabel()
    
    var btnStatus = SortBtnStatus.noSort {
        didSet{
            var imgName = "noSort"
            switch btnStatus {
            case .noSort:
                imgName = "noSort"
            case .sortUp:
                imgName = "sortUp"
            case .sortDown:
                imgName = "sortDown"
            default:
                break
            }
            
            if title.text == "价格"||title.text == "销量" {
                img.image = UIImage(named: imgName)
            }
            
            if title.text == "综合" {
                img.image = nil
            }
            
            if title.text == "筛选" {
                img.image = UIImage(named: "moreSortSelect")
            }
        }
    }
    
    convenience init(frame: CGRect,img:String,title:String) {
        self.init()
        self.title.text = title
        self.img.image = UIImage(named: img)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(button)
        self.addSubview(img)
        self.addSubview(title)
        
        button.snp_makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        button.addTarget(self, action: #selector(SortBtn.sortBtnClk), forControlEvents: UIControlEvents.TouchDown)
        
        title.snp_makeConstraints { (make) in
            make.centerX.equalTo(button.snp_centerX)
            make.centerY.equalTo(button.snp_centerY)
            make.width.equalTo(30)
            make.height.equalTo(18)
        }
        title.font = UIFont.systemFontOfSize(14)
        
        img.snp_makeConstraints { (make) in
            make.left.equalTo(title.snp_right)
            make.centerY.equalTo(title.snp_centerY)
            make.width.height.equalTo(8)
        }
        
    }
    
    func sortBtnClk(){
        self.delegate?.sortBtnClk(self.title.text!,status:btnStatus)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}