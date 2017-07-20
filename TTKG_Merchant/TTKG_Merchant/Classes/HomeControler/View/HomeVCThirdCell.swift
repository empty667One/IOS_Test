//
//  HomeVCThirdCell.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/1.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

protocol HomeVCThirdCellDelegate {
    func entenrShop(shopId:Int)
    func goodDatail(productid : Int, shopid : Int)

}

class HomeVCThirdCell: UICollectionViewCell {

    
    var delegate : HomeVCThirdCellDelegate?
    
    @IBOutlet weak var deliverImage: UIImageView!

    @IBOutlet weak var deliverName: UILabel!
    
    @IBOutlet weak var entenBtn: UIButton!
    
    @IBOutlet weak var qiDing: UILabel!
    
    @IBOutlet weak var orderLabel: UILabel!
    
    //高度约束
    @IBOutlet weak var imagHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var imageTop: NSLayoutConstraint!
    
    @IBOutlet weak var viewTop: NSLayoutConstraint!
    
    @IBOutlet weak var brands: UILabel!
    var brandsStr = String(){
        didSet{
            brands.text = "主营 : \(brandsStr)"
        }
        
    }
    
    
    @IBOutlet weak var goodImage1: UIImageView!
   
    @IBOutlet weak var goodImage2: UIImageView!
    
    @IBOutlet weak var goodImage3: UIImageView!
    
    @IBOutlet weak var goodImage4: UIImageView!
    
   
    @IBOutlet weak var price1: UILabel!
    
    @IBOutlet weak var price2: UILabel!
    
    @IBOutlet weak var price3: UILabel!
    
    @IBOutlet weak var price4: UILabel!
    
    var productId1 : Int!
    var productId2 : Int!
    var productId3 : Int!
    var productId4 : Int!
    
    var shopId : Int!

    
    var imageArray = [MerchantInfoProduct]()
        
    
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        entenBtn.layer.borderWidth = 1
        entenBtn.layer.borderColor = UIColor.redColor().CGColor
        entenBtn.layer.cornerRadius = 6
        entenBtn.layer.masksToBounds = true
        
        qiDing.layer.cornerRadius = 8
        qiDing.layer.masksToBounds = true
        
       
        entenBtn.addTarget(self, action: #selector(HomeVCThirdCell.enterBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        entenBtn.adjustsImageWhenHighlighted = false
        
        
        
        
        
        //为图片添加手势
        goodImage1.userInteractionEnabled = true
        let tapG1 = UITapGestureRecognizer(target: self, action: #selector(self.goodImage1Click))
        goodImage1.addGestureRecognizer(tapG1)
        
        goodImage2.userInteractionEnabled = true
        let tapG2 = UITapGestureRecognizer(target: self, action: #selector(self.goodImage2Click))
        goodImage2.addGestureRecognizer(tapG2)
        
        goodImage3.userInteractionEnabled = true
        let tapG3 = UITapGestureRecognizer(target: self, action: #selector(self.goodImage3Click))
        goodImage3.addGestureRecognizer(tapG3)
        
        goodImage4.userInteractionEnabled = true
        let tapG4 = UITapGestureRecognizer(target: self, action: #selector(self.goodImage4Click))
        goodImage4.addGestureRecognizer(tapG4)
    }

    
    func enterBtnClick(btn : UIButton) {
        
       delegate?.entenrShop(shopId)
    }
    
    
    //图片的点击事件
    func goodImage1Click() {
        

        self.delegate?.goodDatail(productId1, shopid : shopId)
        
    }
    func goodImage2Click() {
        

        self.delegate?.goodDatail(productId2, shopid : shopId)
    }

    func goodImage3Click() {
        
        self.delegate?.goodDatail(productId3, shopid : shopId)
    }

    func goodImage4Click() {
        
        self.delegate?.goodDatail(productId4, shopid : shopId)
    }

}
