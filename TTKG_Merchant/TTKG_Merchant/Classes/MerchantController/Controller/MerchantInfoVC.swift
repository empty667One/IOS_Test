//
//  MerchantInfoVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/6.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class MerchantInfoVC: UIViewController {
    

    private var merchantInfoModel = [MerchantBottominfo](){
        didSet{
            self.merchantInfoVC.reloadData()
        }
    }
    var merchantInfoVC = UITableView()    //主界面
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MerchantInfoVC.merchantInfoDataChanged), name: "merchantInfoDataChange", object: nil)
    
        merchantInfoVC = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        merchantInfoVC.delegate = self
        merchantInfoVC.dataSource = self
        merchantInfoVC.estimatedRowHeight = 88
        merchantInfoVC.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(merchantInfoVC)
        merchantInfoVC.registerClass(MerchantInfoCell.self, forCellReuseIdentifier: "MerchantInfoCell")
        
    }

    func merchantInfoDataChanged(notice:NSNotification){
        
        self.merchantInfoModel = notice.object!["merchantInfoData"] as! [MerchantBottominfo]
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
}

//MARK:Delegate
extension MerchantInfoVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.merchantInfoModel.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : MerchantInfoCell = merchantInfoVC.dequeueReusableCellWithIdentifier("MerchantInfoCell", forIndexPath: indexPath) as! MerchantInfoCell
        cell.infoLabel.text = merchantInfoModel[indexPath.row].title
        cell.detailLabel.text  = merchantInfoModel[indexPath.row].value
        return cell
        
    }
    
//    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = prototypeCell
//        cell.detailLabel.text = merchantInfoModel[indexPath.row].value
//        return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
//    }
    
    
}


extension MerchantInfoVC {
    
}
