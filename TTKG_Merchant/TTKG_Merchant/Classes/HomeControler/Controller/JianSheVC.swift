//
//  JianSheVC.swift
//  TTKG_Merchant
//
//  Created by 123 on 17/3/20.
//  Copyright © 2017年 yd. All rights reserved.
//

import UIKit

class JianSheVC: UIViewController {
    
    var tableview :UITableView!
    var titleArray : [String]!
    var imageArray : [String]!
    

    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "建设银行信用卡服务"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        titleArray = ["建设银行微企贷", "工商银行信用卡","民生银行信用卡","aaaaa","aaaaa","aaaaa","aaaaa"]
        imageArray = ["sehuo","ic_user_img","menu_address","menu_address","menu_address","menu_address","menu_address"]
        
    }
    
    func createUI() {
        
        tableview = UITableView(frame: CGRectMake(0, 0, screenWith, screenHeigh), style: .Plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 50
        //        tableview.backgroundColor = UIColor.redColor()
        
        tableview.showsVerticalScrollIndicator = false
        
        self.view.addSubview(tableview)
        
        tableview.registerClass(PersonCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}


extension JianSheVC : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : PersonCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PersonCell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.img.image = UIImage(named: imageArray[indexPath.row])
        cell.label.text = titleArray[indexPath.row]
        
        return cell
        
    }
    
    //设置cell的点击
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //建设银行
        if indexPath.row == 0
        {
            let jiansheVC = JianSheVC()
            
            jiansheVC.hidesBottomBarWhenPushed = true
            
//            self.navigationController?.pushViewController(jiansheVC, animated: false)
            
        }
        
        //工商银行
        if indexPath.row == 1
        {
            
            let gongshangVC = GongShangVC()
            
            gongshangVC.hidesBottomBarWhenPushed = true
            
//            self.navigationController?.pushViewController(gongshangVC, animated: false)
        }
        
        //民生银行
        if indexPath.row == 2
        {
            let minShengVC = MinShengVC()
            minShengVC.hidesBottomBarWhenPushed = true
            
//            self.navigationController?.pushViewController(minShengVC, animated: false)
        }
        
        
        
    }
    
}

