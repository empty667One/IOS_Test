//
//  MoreConditionSelectView.swift
//  TTKG_Merchant
//
//  Created by iosnull on 16/8/5.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit



class MoreConditionSelectFooterViewTwoBtn: UICollectionReusableView {
    
    var delegate:MoreConditionSelectFooterViewTwoBtnDelegate?
    
    var clearBtn = UIButton()
    var okBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(clearBtn)
        self.addSubview(okBtn)
        
        clearBtn.layer.cornerRadius = 5
        okBtn.layer.cornerRadius = 5
        
        clearBtn.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(0)
            make.width.equalTo((self.frame.size.width - 120)/2)
            make.left.equalTo(30)
            
        }
        clearBtn.setTitle("清空", forState: UIControlState.Normal)
        clearBtn.backgroundColor = UIColor(red: 228/255, green: 64/255, blue: 74/255, alpha: 1)
        clearBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        
        okBtn.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.bottom.equalTo(0)
            make.width.equalTo(clearBtn.snp_width)
            make.right.equalTo(0).offset(-30)
        }
        okBtn.setTitle("确定", forState: UIControlState.Normal)
        okBtn.backgroundColor = UIColor(red: 228/255, green: 64/255, blue: 74/255, alpha: 1)
        okBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        clearBtn.addTarget(self, action: #selector(MoreConditionSelectFooterViewTwoBtn.clearBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        okBtn.addTarget(self, action: #selector(MoreConditionSelectFooterViewTwoBtn.okBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    func clearBtnClk(){
        delegate?.clearBtnClk()
    }
    func okBtnClk(){
        delegate?.okBtnClk()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//按钮点击代理
protocol MoreConditionSelectFooterViewTwoBtnDelegate {
    func clearBtnClk()
    func okBtnClk()
}


class MoreConditionSelectFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoreConditionSelectHeaderView: UICollectionReusableView {
    var title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //
        self.addSubview(title)
        title.snp_makeConstraints { (make) in
            make.left.right.equalTo(8)
            make.top.bottom.equalTo(2)
        }
        title.font = UIFont.systemFontOfSize(14)
        title.textColor = UIColor.grayColor()
        
        self.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoreConditionSelectCell:UICollectionViewCell {
    var title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 3
        self.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
       
        self.addSubview(title)

        title.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
            title.textAlignment = .Center
        }
        title.font = UIFont.systemFontOfSize(12)
        title.userInteractionEnabled = false
        self.userInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






class MoreConditionSelectView: UIView {
    
    var delegate:MoreConditionSelectViewDelegate?
    
    var moreSelectRootClass = MoreSelectRootClass() {
        didSet{
            self.collectionView.reloadData()
        }
    }
   
    //左边半透明视图
    private var leftView = UIView()
    //右边collectionView
    private var collectionView:UICollectionView!
    private var removeSelfBtn = UIButton()
    
    //最右边顶部视图
    private var rightTopView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(leftView)
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect(x: 0 ,y:  0, width: screenWith, height: screenHeigh - 93), collectionViewLayout: layout)
        
        self.addSubview(collectionView)
        
        
        leftView.addSubview(removeSelfBtn)
        leftView.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/7)
        }
        leftView.backgroundColor = UIColor.blackColor()
        leftView.alpha = 0.3
        
        //最右边top视图
        self.addSubview(rightTopView)
        rightTopView.snp_makeConstraints { (make) in
            make.top.right.equalTo(0)
            make.left.equalTo(leftView.snp_right)
            make.height.equalTo(44)
        }
        rightTopView.backgroundColor = UIColor.whiteColor()
        //点击按钮消失视图
        let disMissBtn = UIButton()
        rightTopView.addSubview(disMissBtn)
        disMissBtn.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(120)
        }
        disMissBtn.addTarget(self, action: #selector(MoreConditionSelectView.removeSelfBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        //最左边视图消失点击背景
        let disMissImg = UIImageView()
        rightTopView.addSubview(disMissImg)
        disMissImg.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(5)
            make.bottom.equalTo(0).offset(-10)
            
            make.width.equalTo(rightTopView.snp_height)
        }
        
        disMissImg.image = UIImage(named: "disMissBtnIcon")
        disMissImg.contentMode = .ScaleAspectFit
        
        
        //筛选名称
        let viewTitle = UILabel()
        rightTopView.addSubview(viewTitle)
        viewTitle.snp_makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(0)
        }
        viewTitle.text = "筛选"
        viewTitle.font = UIFont.systemFontOfSize(17)
        viewTitle.textAlignment = NSTextAlignment.Center
        viewTitle.textColor = UIColor.grayColor()
        
        
        //移除按钮
        removeSelfBtn.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        removeSelfBtn.addTarget(self, action: #selector(MoreConditionSelectView.removeSelfBtnClk), forControlEvents: UIControlEvents.TouchUpInside)

        
        
        
        //集合视图
        collectionView.snp_makeConstraints { (make) in
            make.top.equalTo(44)
            make.right.bottom.equalTo(0)
            make.left.equalTo(leftView.snp_right)
        }

        collectionView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        
        //当前视图背景颜色
        self.backgroundColor = UIColor.clearColor()
        
        //注册需要显示的cell 和header、footer
        collectionView.registerClass(MoreConditionSelectCell.self, forCellWithReuseIdentifier: "MoreConditionSelectCell")
        
        collectionView.registerClass(MoreConditionSelectHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "MoreConditionSelectHeaderView")
        
        collectionView.registerClass(MoreConditionSelectFooterView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter , withReuseIdentifier: "MoreConditionSelectFooterView")

        collectionView.registerClass(MoreConditionSelectFooterViewTwoBtn.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter , withReuseIdentifier: "MoreConditionSelectFooterViewTwoBtn")
        
        //挂数据源和代理
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     移除当前视图
     */
    func removeSelfBtnClk()  {
        
        
        UIView.animateWithDuration(0.2, animations: { 
            self.frame = CGRect(x: screenWith, y: 20, width: screenWith, height: screenHeigh - 20)
            }) { (f) in
                self.removeFromSuperview()
        }
        
        
    }
    
}


// MARK: - 数据源
extension MoreConditionSelectView:UICollectionViewDataSource{
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
            
        case 0 :
            if self.moreSelectRootClass.condition.count > 0 {
                return self.moreSelectRootClass.condition[0].title.count
            }else{
                return 0
            }
            
            
            
        case 1 :
            if self.moreSelectRootClass.condition.count > 1 {
                return self.moreSelectRootClass.condition[1].title.count
            }else{
                return 0
            }
                
        case 2 :
            if self.moreSelectRootClass.condition.count > 2 {
                return self.moreSelectRootClass.condition[2].title.count
            }else{
                return 0
            }
        
        default:
            return 0
        }
        
    }
    
    
    func renderCell(section:Int,row:Int,cell:MoreConditionSelectCell,title:String){
        if moreSelectRootClass.condition[section].selectedFlag == row {
            cell.backgroundColor = UIColor(red: 228/255, green: 64/255, blue: 74/255, alpha: 1)
            cell.title.textColor = UIColor.whiteColor()
        }else{
            cell.backgroundColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
            cell.title.textColor = UIColor.blackColor()
        }
        cell.title.text = title
    }
    
    //设置cell内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MoreConditionSelectCell", forIndexPath: indexPath) as! MoreConditionSelectCell
        
        
        
        renderCell(indexPath.section, row: indexPath.row, cell: cell, title: moreSelectRootClass.condition[indexPath.section].title[indexPath.row])
        

        return cell
    }
    
    
    
    
    
    
}

// MARK: - 代理
extension MoreConditionSelectView:UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        moreSelectRootClass.condition[indexPath.section].selectedFlag = indexPath.row
        self.collectionView.reloadData()
    
    }
    
    
}


protocol MoreConditionSelectViewDelegate {
    func selectConditions(conditions:MoreSelectRootClass)
    
    func clearConditionsFlag(flag:Bool)
}


extension MoreConditionSelectView:MoreConditionSelectFooterViewTwoBtnDelegate{
    /**
     清除按钮点击事件
     */
    func clearBtnClk(){
        for item in self.moreSelectRootClass.condition {
            item.selectedFlag = 10000
        }
        self.collectionView.reloadData()
        
        self.delegate!.clearConditionsFlag(false)
    }
    /**
     确认按钮点击事件
     */
    func okBtnClk(){
        //self.delegate!.clearConditionsFlag(true)
        delegate?.selectConditions(self.moreSelectRootClass)
        
        removeSelfBtnClk()
    }
}

extension MoreConditionSelectView:UICollectionViewDelegateFlowLayout{
    
    //设置头部／尾部视图
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        
        
        switch kind {
            
        //头部视图
        case UICollectionElementKindSectionHeader:
            var headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "MoreConditionSelectHeaderView", forIndexPath: indexPath) as!MoreConditionSelectHeaderView
            var title = UILabel()
            headerView.addSubview(title)
            title.snp_makeConstraints { (make) in
                make.left.top.bottom.right.equalTo(0)
            }
            
            switch indexPath.section {
            case 0:
                headerView.title.text = "品牌"
            case 1:
                headerView.title.text = "配送条件"
            case 2:
                headerView.title.text = "价格"
            default:
                break
            }
            
            
            
            
            
            
            return headerView
            
        //尾部视图
        case UICollectionElementKindSectionFooter:
            if indexPath.section != 2 {
            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "MoreConditionSelectFooterView", forIndexPath: indexPath) as! MoreConditionSelectFooterView
                return footerView
            }else{
                
                
            let footerView  =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "MoreConditionSelectFooterViewTwoBtn", forIndexPath: indexPath) as! MoreConditionSelectFooterViewTwoBtn
                
                footerView.delegate = self
                
                return footerView
            }
            
            
            
            
        default:
            return UICollectionReusableView()
        }
        
        
        
    }
    
    //设置item的宽高
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let w = (screenWith - self.leftView.frame.size.width - 40 )/3
        
        return  CGSize(width: w, height: 30)
    }
    
    //设置每行间隔
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    
    //Section中每个Cell的左右边距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 8, bottom: 8, right:8)
        
    }
    
    
    //    设置头部视图高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: screenWith, height: 30)
        
    }
    
    // 设置尾部视图高度
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section != 2 {
            return CGSize(width: screenWith - leftView.frame.size.width, height: 1)
        }else{
            return CGSize(width: screenWith - leftView.frame.size.width, height: 50)
        }
        
        
    }
}


