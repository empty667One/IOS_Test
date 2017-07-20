//
//  MyOrderList.swift
//  TTKG_Merchant
//
//  Created by 123 on 17/7/8.
//  Copyright © 2017年 yd. All rights reserved.
//

import UIKit
import Alamofire

class MyOrderList: UIViewController {

    var tableview :UITableView!
    var orderno = String()
    var creatTime = String()
    
    var orderListModel : DetailOrderListModel!
    var orderList = [DetalOrderListData]()
    var listAry : NSArray!

    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //网络请求
        requestClist_Detail(self.orderno)

        createUI()
        self.tableview.reloadData()
    
        
    }
    
    //创建界面
    func createUI() {
        
        tableview = UITableView(frame: CGRectMake(0, 0, screenWith, screenHeigh), style: .Plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 50
        tableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableview.showsVerticalScrollIndicator = false
        
        //表头
        let headerView = UIView()
        headerView.frame = CGRectMake(0, 0, screenWith, 40)
        headerView.backgroundColor = UIColor.blackColor()
        //订单编号显示
        let titleLabel = UILabel()
        titleLabel.frame = CGRectMake(6, 0, screenWith, 40)
        titleLabel.text = "订单编号:" + self.orderno
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.font = UIFont.systemFontOfSize(15)
        tableview.tableHeaderView = headerView
        headerView.addSubview(titleLabel)

        self.view.addSubview(tableview)
        
         tableview.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.requestClist_Detail))
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}

//代理
extension MyOrderList : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.orderList.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.orderList.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.grayColor()
        headerView.hidden = true
        
        if section == 0 {
            headerView.hidden = false
            let productLabel = UILabel()
            productLabel.frame = CGRectMake(6,10,150,20)
            productLabel.text = "产品";
            productLabel.textAlignment = NSTextAlignment.Left
            productLabel.font = UIFont.systemFontOfSize(14)
            headerView.addSubview(productLabel)
            
            
            let width = (screenWith - 185)/3
            
            //数量
            let numLabel = UILabel()
            numLabel.frame = CGRectMake(155,10,width,20)
            numLabel.text = "数量";
            numLabel.textAlignment = NSTextAlignment.Center
            numLabel.font = UIFont.systemFontOfSize(14)
            headerView.addSubview(numLabel)
            
            
            //单位
            let danweiLabel = UILabel()
            danweiLabel.frame = CGRectMake(screenWith-20-width*2,10,width,20)
            danweiLabel.text = "单位";
            danweiLabel.textAlignment = NSTextAlignment.Center
            danweiLabel.font = UIFont.systemFontOfSize(14)
            headerView.addSubview(danweiLabel)
            
            //金额
            let moneyLabel = UILabel()
            moneyLabel.frame = CGRectMake(screenWith-10-width,10,width,20)
            moneyLabel.text = "金额";
            moneyLabel.textAlignment = NSTextAlignment.Center
            moneyLabel.font = UIFont.systemFontOfSize(14)
            headerView.addSubview(moneyLabel)
            
            return headerView

        }
        //产品Label
//        let productLabel = UILabel()
//        productLabel.frame = CGRectMake(6,10,150,20)
//        productLabel.text = "产品";
//        productLabel.textAlignment = NSTextAlignment.Left
//        productLabel.font = UIFont.systemFontOfSize(14)
//        headerView.addSubview(productLabel)
//        
//       
//        let width = (screenWith - 185)/3
//        
//         //数量
//        let numLabel = UILabel()
//        numLabel.frame = CGRectMake(155,10,width,20)
//        numLabel.text = "数量";
//        numLabel.textAlignment = NSTextAlignment.Center
//        numLabel.font = UIFont.systemFontOfSize(14)
//        headerView.addSubview(numLabel)
//        
//
//        //单位
//        let danweiLabel = UILabel()
//        danweiLabel.frame = CGRectMake(screenWith-20-width*2,10,width,20)
//        danweiLabel.text = "单位";
//        danweiLabel.textAlignment = NSTextAlignment.Center
//        danweiLabel.font = UIFont.systemFontOfSize(14)
//        headerView.addSubview(danweiLabel)
//        
//        //金额
//        let moneyLabel = UILabel()
//        moneyLabel.frame = CGRectMake(screenWith-10-width,10,width,20)
//        moneyLabel.text = "金额";
//        moneyLabel.textAlignment = NSTextAlignment.Center
//        moneyLabel.font = UIFont.systemFontOfSize(14)
//        headerView.addSubview(moneyLabel)
//
        return headerView
    }
    
    //返回分区头部高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0
        {
            return 40
        }
        else
        {
            return 0.001

        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        footerView.backgroundColor = UIColor.grayColor()
        
        //订单时间
        let timeLabel = UILabel()
        timeLabel.frame = CGRectMake(6, 0, screenWith - 150, 40)
        timeLabel.text = "订单时间:" + self.creatTime
        timeLabel.textColor = UIColor.whiteColor()
        timeLabel.textAlignment = NSTextAlignment.Left
        timeLabel.font = UIFont.systemFontOfSize(15)
        footerView.addSubview(timeLabel)
        
        //合计
        let allMoneyLabel = UILabel()
        allMoneyLabel.frame = CGRectMake(screenWith - 140, 0,  150, 40)
//        allMoneyLabel.text =  "合计:"
        allMoneyLabel.text = "合计:" + String(format: "%.2f元", self.orderList[section].hj)
        allMoneyLabel.textColor = UIColor.whiteColor()
        allMoneyLabel.textAlignment = NSTextAlignment.Left
        allMoneyLabel.font = UIFont.systemFontOfSize(15)
        footerView.addSubview(allMoneyLabel)
        


        return footerView
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0
        {
            return 40
        }
        else
        {
            return 0.001

        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 40
        }
        
        else
        {
            return 0.01

        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.hidden = true
       
        if indexPath.section == 0
        {
            cell.hidden = false
            //产品Label
            let productLabel = UILabel()
            productLabel.frame = CGRectMake(6,10,150,20)
            productLabel.text = self.orderList[indexPath.row].mc
            productLabel.textAlignment = NSTextAlignment.Left
            productLabel.font = UIFont.systemFontOfSize(14)
            cell.addSubview(productLabel)
            
            
            let width = (screenWith - 185)/3
            
            //数量
            let numLabel = UILabel()
            numLabel.frame = CGRectMake(155,10,width,20)
            numLabel.text = String(format: "%d", self.orderList[indexPath.row].sl)
            numLabel.textAlignment = NSTextAlignment.Center
            numLabel.font = UIFont.systemFontOfSize(14)
            cell.addSubview(numLabel)
            
            
            //单位
            let danweiLabel = UILabel()
            danweiLabel.frame = CGRectMake(screenWith-20-width*2,10,width,20)
            danweiLabel.text = self.orderList[indexPath.row].dw
            danweiLabel.textAlignment = NSTextAlignment.Center
            danweiLabel.font = UIFont.systemFontOfSize(14)
            cell.addSubview(danweiLabel)
            
            //总金额
            let moneyLabel = UILabel()
            moneyLabel.frame = CGRectMake(screenWith-10-width,10,width,20)
            moneyLabel.text = String(format: "%.02f元", self.orderList[indexPath.row].zj)
            moneyLabel.textAlignment = NSTextAlignment.Center
            moneyLabel.font = UIFont.systemFontOfSize(14)
            cell.addSubview(moneyLabel)
            
            //cell下边的分割线
            let bottomLabel = UILabel()
            bottomLabel.frame = CGRectMake(0,40,screenWith,1)
            bottomLabel.backgroundColor = UIColor.lightGrayColor()
            cell.addSubview(bottomLabel)
            
             return cell
            

        }
            return cell
        
    }
    
    //设置cell的点击
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
     
        print("111111111111")
        
    }
    
}

//reloadUp
extension MyOrderList
{
    func requestClist_Detail(orderno:NSString) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let parameters = ["orderno":orderno,"sign":MD5_time,"timespan":timeTemp.description]
        
        let url = serverUrl + "/Order/Clist_Detail"
        Alamofire.request(.GET, url, parameters:parameters)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        if dict!["code"] as! Int == 0 {
                            self.orderListModel = DetailOrderListModel.init(fromDictionary: dict!)
                            self.orderList = self.orderListModel.data
                            self.tableview.reloadData()

                        }
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    
                case .Failure(let error): break
                    
                }
                
        }
        
    }
    
    

}

