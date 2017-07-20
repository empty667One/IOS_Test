//
//  SelectAreaTwoVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/3.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class SelectAreaTwoVC: UIViewController {
    var firstAdress = ""
    var lastAddress = ""
    var addressTemp = ""
    var countrysData : [ListCountry] = [ ]
    var streetData : [ListStreet] = [ ]
    var leftTableView = UITableView()
    var rightTableView = UITableView()
    override func viewDidLoad(){
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        leftTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWith/3, height: screenHeigh - 108), style: UITableViewStyle.Plain)
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.tag = 100
        leftTableView.registerNib(UINib(nibName: "SelectAreaCell", bundle: nil), forCellReuseIdentifier: "SelectAreaCell")
        self.view.addSubview(leftTableView)
        
        rightTableView = UITableView(frame: CGRect(x: leftTableView.frame.maxX, y: 0, width: screenWith - (screenWith/3), height: screenHeigh - 108), style: UITableViewStyle.Plain)
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.tag = 200
        rightTableView.registerNib(UINib(nibName: "SelectAreaCell", bundle: nil), forCellReuseIdentifier: "SelectAreaCell")
        self.view.addSubview(rightTableView)
    
    
    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension SelectAreaTwoVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 100 {
            return self.countrysData.count
        }else {
            return self.streetData.count
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let leftCell : SelectAreaCell = self.leftTableView.dequeueReusableCellWithIdentifier("SelectAreaCell", forIndexPath: indexPath) as! SelectAreaCell
            leftCell.nameText.text = self.countrysData[indexPath.row].countryname
            return leftCell
        }else{
            let rightCell : SelectAreaCell = self.rightTableView.dequeueReusableCellWithIdentifier("SelectAreaCell", forIndexPath: indexPath) as! SelectAreaCell
            rightCell.nameText.text = self.streetData[indexPath.row].streetname
            return rightCell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView.tag == 100 {
            self.streetData = self.countrysData[indexPath.row].streets
            self.rightTableView.reloadData()
            
            self.addressTemp = self.countrysData[indexPath.row].countryname
            let areaID = self.countrysData[indexPath.row].countryid
            
            if self.streetData.count == 0 {
                let status = ["address":self.lastAddress + self.addressTemp,"areaID":areaID]
                let notice = NSNotification(name: "selectAddress", object: status)
                
                
                self.dismissViewControllerAnimated(true, completion: { 
                    NSNotificationCenter.defaultCenter().postNotification(notice)
                })
                
            }
            
        }else{
            let areaID = self.streetData[indexPath.row].streetid
            self.firstAdress = self.streetData[indexPath.row].streetname
            
            let status = ["address":self.lastAddress + self.addressTemp + self.firstAdress,"areaID":areaID]
            let notice = NSNotification(name: "selectAddress", object: status)
            
            self.dismissViewControllerAnimated(true, completion: {
                NSNotificationCenter.defaultCenter().postNotification(notice)
            })
        }
        
    }
}


