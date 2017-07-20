//
//  HomeVCHeaderView.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/2.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SDCycleScrollView


protocol HomeVCHeaderViewDelegate {
    
    func noticeMessageClick(index:Int)
    func scrollImageClick(index:Int)
}

class HomeVCHeaderView: UICollectionReusableView  {
    

    var delegate : HomeVCHeaderViewDelegate?
    
    let bottomView = UIView()
    let separateView = UIView()
    let img = UIImageView()
    //快购资讯
    let message = UILabel()
    //轮播文字
    var scrollMessage:SDCycleScrollView!
    //轮播图片
    var scrollView : SDCycleScrollView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        bottomView.backgroundColor = UIColor.whiteColor()
        separateView.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
      
        //添加分割线
        self.addSubview(separateView)
        separateView.snp_makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(2)
            
            
        }
        
        //添加底部白色view
        self.addSubview(bottomView)
        bottomView.snp_makeConstraints { (make) in
            make.bottom.equalTo(separateView.snp_top).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(30)
            
        }

          //添加轮播图
        let height = self.height - 32
        
        scrollView = SDCycleScrollView(frame: CGRectMake(0, 0, screenWith, height), imageURLStringsGroup: nil)
        
        scrollView.autoScrollTimeInterval = 5
        
        scrollView.tag = 0
        
        scrollView.delegate = self
        
        self.addSubview(scrollView)
        
        
        //添加快购资讯
        self.bottomView.addSubview(message)
        message.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(15)
            make.top.equalTo(0).offset(5)
        }

        
        //富文本设置
        let attributeString = NSMutableAttributedString(string:"快购资讯 : ")

        //设置字体颜色
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(),
                                     range: NSMakeRange(2, 2))
        //从文本0开始4个字符字体HelveticaNeue-Bold,14号
        attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue", size: 13)!,
        range: NSMakeRange(0,4))
    
        message.attributedText = attributeString
        
        
        //添加轮播文字
        scrollMessage = SDCycleScrollView(frame: CGRectMake(50, 10, 100, 30), imageURLStringsGroup: nil)
        scrollMessage.onlyDisplayText = true
        scrollMessage.scrollDirection = UICollectionViewScrollDirection.Vertical
        scrollMessage.showPageControl = false
        scrollMessage.titleLabelBackgroundColor = UIColor.whiteColor()
        scrollMessage.titleLabelTextColor = UIColor.blackColor()
        scrollMessage.titleLabelTextFont = UIFont.systemFontOfSize(13)
        scrollMessage.autoScrollTimeInterval = 5
        scrollMessage.delegate = self
        scrollMessage.tag = 1
        
        self.bottomView.addSubview(scrollMessage)
        
        
        //添加小喇叭
        self.bottomView.addSubview(img)
        img.snp_makeConstraints { (make) in
            make.left.equalTo(message.snp_right).offset(5)
            make.top.equalTo(0).offset(5)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        img.image = UIImage(named: "broadcastIcon")
        
    }
    
    override func layoutSubviews() {
        scrollMessage.snp_makeConstraints { (make) in
            make.left.equalTo(message.snp_right).offset(20)
//            make.centerY.equalTo(img.centerY)
            make.right.equalTo(0).offset(-15)
            make.bottom.equalTo(0).offset(-5)
            make.top.equalTo(0).offset(6)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}

extension HomeVCHeaderView : SDCycleScrollViewDelegate{
    
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        if cycleScrollView.tag == 0{
           
            self.delegate?.scrollImageClick(index)
        }
        if cycleScrollView.tag == 1{
            
        
            self.delegate?.noticeMessageClick(index)
            
        }
    }
    
    
}