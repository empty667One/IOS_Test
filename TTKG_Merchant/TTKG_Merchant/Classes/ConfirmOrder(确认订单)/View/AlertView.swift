//
//  AlertView.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/16.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit

class AlertView: UIView {

    private let ScreenWidth = UIScreen.mainScreen().bounds.size.width
    private let ScreenHeight  = UIScreen.mainScreen().bounds.size.height
    private let ScreenBounds = UIScreen.mainScreen().bounds
    
    var givetableView : UITableView!
    var giftData = [GetShopCarGiftData]()
    var backView : UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        createbackView()
        show()
        
        tableView()
       
//        givetableView.reloadData()
    }
    
    override func drawRect(rect: CGRect) {
         
        self.givetableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(){
        let current  = UIApplication.sharedApplication().keyWindow
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        current?.addSubview(self)
        
        UIView.animateWithDuration(0.3) {
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
            self.backView.frame = CGRectMake(50, self.ScreenHeight/3, self.ScreenWidth - 100, self.self.ScreenHeight/3)
            let footerView = UIView(frame: CGRect(x: 50, y: self.backView.frame.maxY - 44, width: self.ScreenWidth - 100, height: 44))
            footerView.backgroundColor = UIColor.whiteColor()
            self.backView.addSubview(footerView)
            let btn = UIButton(frame: CGRect(x: footerView.frame.width/2 - 50, y: 2, width: 100, height: 40))
            btn.setTitle("确定", forState: UIControlState.Normal)
            btn.setTitleColor(UIColor(red: 83/255, green: 83/255, blue: 83/255, alpha: 1.0), forState: UIControlState.Normal)
            btn.addTarget(self, action: #selector(AlertView.didMissView), forControlEvents: UIControlEvents.TouchUpInside)
            
            footerView.addSubview(btn)

        }
    }
    
    func createbackView() -> UIView {
        if (backView == nil) {
//            self.backView = UIView(frame: CGRect(x: 50, y: 64, width: ScreenWidth - 100, height: ScreenHeight - 100))
            self.backView = UIView()
            self.backView.layer.masksToBounds = true
            self.backView.layer.cornerRadius = 10
            
            self.addSubview(backView)
            self.backView.bounds = CGRect(x: 50, y: self.ScreenHeight/3, width: ScreenWidth - 100, height: self.ScreenHeight/3)
            
        }
        return backView
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.didMissView()
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        self.frame = ScreenBounds
        self.setUpCellSeparatorInset()
    }
    
    func setUpCellSeparatorInset(){
        
    }
    
    func didMissView(){
        UIView.animateWithDuration(0.3, animations: { 
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseIn)
            self.backView.frame = CGRectMake(50, self.ScreenHeight/3, self.ScreenWidth - 100, self.self.ScreenHeight/3)
            }) { (Bool) in
                self.removeFromSuperview()
        }
    }
    
    func tableView() -> UITableView {
        if (givetableView == nil) {
            self.givetableView = UITableView(frame: CGRect(x: 50, y: self.ScreenHeight/3, width: ScreenWidth - 100, height: self.ScreenHeight/3 - 44), style: UITableViewStyle.Grouped)
            givetableView.delegate = self
            givetableView.dataSource = self
            self.backView.addSubview(givetableView)
//            givetableView.registerClass(AlertViewHeader.self, forHeaderFooterViewReuseIdentifier: "alertViewHeader")
            givetableView.registerClass(AlertViewCell.self, forCellReuseIdentifier: "alertCell")
        }
        return givetableView
    }
    

}

extension AlertView : UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return (self.giftData.count)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.giftData[section].items.count)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var  str = ""
        
        str = self.giftData[section].shopname + self.giftData[section].actitiemassage
        
        let rect = getTextRectSize(str, font: UIFont.systemFontOfSize(18), size: CGSize(width: 100, height: 60))
        
        return rect.height
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let str = self.giftData[indexPath.section].items[indexPath.row].productname + " : " + self.giftData[indexPath.section].items[indexPath.row].activitiemassage
        let rect = getTextRectSize(str, font: UIFont.systemFontOfSize(18), size: CGSize(width: 100, height: 60))
        
        return rect.height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : AlertViewCell = givetableView.dequeueReusableCellWithIdentifier("alertCell", forIndexPath: indexPath) as! AlertViewCell
        cell.productName.text = self.giftData[indexPath.section].items[indexPath.row].productname + " : \n    \(self.giftData[indexPath.section].items[indexPath.row].activitiemassage)" 
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = AlertViewHeader()
        
        header.shopName.text = self.giftData[section].shopname + " : " + "\n     \(self.giftData[section].actitiemassage)" 
        
        return header
    }
    

    
    
    //获取字符串宽高
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
}
