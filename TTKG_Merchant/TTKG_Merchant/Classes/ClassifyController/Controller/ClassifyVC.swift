//
//  ClassifyVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/29.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class ClassifyVC: UIViewController {
    var classMode : ClassifyModel!
    
    var classData = [CData]()
    var classListData = [CList]()
    var selectFlag = 0
    
    var lefttableView = UITableView()
    var rightCollectionView : UICollectionView!
    
    let layout = UICollectionViewFlowLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分类"
        //UIColor(red: 50 / 255, green: 133 / 255, blue: 255 / 255, alpha: 1)
        //设置navigationItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"扫一扫" ), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ClassifyVC.scanQRCodeBtn))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"搜索" ), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ClassifyVC.gotoSearchVC))
        
        self.view.backgroundColor = UIColor(red: 197/255, green: 197/255, blue: 197/255, alpha: 1.0)
        self.edgesForExtendedLayout = UIRectEdge.None
        createUI()
        
    }
    
    //去全局搜索商品
    internal func gotoSearchVC(){
        //        var enterFlag = EnterFromWhereFlag.全局搜索
        //        var merchantId = String()//商家ID
        let searchVC = SearchGoodsVC()
        searchVC.hidesBottomBarWhenPushed = true
        searchVC.enterFlag = EnterFromWhereFlag.全局搜索
        
        self.navigationController?.pushViewController(searchVC, animated: true)
        
    }
    
    func createUI()  {
        lefttableView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWith/4 - 2, height: screenHeigh - 113), style: UITableViewStyle.Plain)
        lefttableView.delegate = self
        lefttableView.dataSource = self
        self.view.addSubview(lefttableView)
        lefttableView.tableFooterView = UIView() //去除多余的分割线显示
        lefttableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0)
        lefttableView.separatorStyle = UITableViewCellSeparatorStyle.None
        lefttableView.registerClass(ClassifyCell.self, forCellReuseIdentifier: "classifyCellID")
        
        layout.minimumInteritemSpacing = 1//2.5
        layout.minimumLineSpacing = 1//2.5
        rightCollectionView = UICollectionView(frame: CGRect(x: lefttableView.frame.maxX + 2, y: 0, width: screenWith - (screenWith/4), height: screenHeigh - 113), collectionViewLayout: layout)
        rightCollectionView!.delegate = self
        rightCollectionView!.dataSource = self
        rightCollectionView.backgroundColor =  UIColor(red: 236/255, green: 237/255, blue: 239/255, alpha: 1.0)
        self.view.addSubview(rightCollectionView)
        rightCollectionView.registerClass(ClassifyCollectionCell.self, forCellWithReuseIdentifier: "ClassifyCollectionCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        if onlineState {

            if self.classListData.count == 0 {
                requestForClassify()
            }else{
                
            }

        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
        
    }
    
}


extension ClassifyVC {
    func scanQRCodeBtn(){
        let scanQRcodeVC = QRCodeViewController()
        scanQRcodeVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(scanQRcodeVC, animated: false)
        
    }
}

// MARK: - tableView代理方法实现
extension ClassifyVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        for item in self.classData {
            if item.selectFlag {
                item.selectFlag = false
            }
        }
        self.classData[indexPath.row].selectFlag = true
        self.selectFlag = indexPath.row
        self.classListData = self.classData[indexPath.row].list
        
        if self.classListData.count == 0 {
            let backgroundView = UIImageView(image: UIImage(named:"背景"))
            rightCollectionView.backgroundView = backgroundView
            
            self.view.dodo.style.bar.hideAfterDelaySeconds = 2
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning("我们即将丰富我们的产品")
        }else{
            rightCollectionView.backgroundView = nil
        }
        
        
        
        lefttableView.reloadData()
        rightCollectionView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let leftCell : ClassifyCell = self.lefttableView.dequeueReusableCellWithIdentifier("classifyCellID", forIndexPath: indexPath) as! ClassifyCell
        leftCell.nameLabel.text = self.classData[indexPath.row].name
        
        if self.classData[indexPath.row].selectFlag {
            leftCell.backgroundColor = UIColor.whiteColor()
            leftCell.selectLine.backgroundColor = UIColor.redColor()
        }else{
            leftCell.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
            leftCell.selectLine.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
        }
        
        return leftCell
        
    }
    
    
    
}

// MARK: - collection代理方法

extension ClassifyVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classListData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let classImage : ClassifyCollectionCell = rightCollectionView.dequeueReusableCellWithReuseIdentifier("ClassifyCollectionCell", forIndexPath: indexPath) as! ClassifyCollectionCell
        classImage.nameLabel.text = self.classListData[indexPath.row].name
        classImage.classImage.sd_setImageWithURL(NSURL(string: serverPicUrl + self.classListData[indexPath.row].icon))
        return classImage
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        var size = CGSize(width: 0, height: 0)
        let width = screenWith - (screenWith/4)
        
        let w = (width - 4)/3
        let h = 100 as CGFloat
        size =  CGSize(width: w , height: h )
        
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        
        var edge = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
        //商品列表
        edge = UIEdgeInsets(top: 1, left: 1, bottom: 1, right:1)
        
        return edge
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let goodsListVC = GoodsListVC()
        goodsListVC.moreSelectRootClass.slectGoodsByCondition.enterFromClassOrBigBrandFlag = true //从分类进入的
        
        //设置分类ID
        goodsListVC.moreSelectRootClass.slectGoodsByCondition.categoryid = String(classListData[indexPath.row].categoryid)
        //备份分类ID
        goodsListVC.moreSelectRootClass.slectGoodsByCondition.categoryidTemp = String(classListData[indexPath.row].categoryid)
        
        goodsListVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(goodsListVC, animated: false)
        
    }
    
    
}

extension ClassifyVC {
    
    func requestForClassify() {
        let url = serverUrl + "/product/category"
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        let parameters = ["sign":MD5_time,"timespan":timeTemp.description]
        Alamofire.request(.GET, url, parameters:parameters )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        self.classMode = ClassifyModel.init(fromDictionary: dict!)
                        if self.classMode.code == 0 {
                            self.classData = self.classMode.data
                            
                            if self.selectFlag  > self.classData.count {
                                self.classData[0].selectFlag = true
                            }else{
                                self.classData[self.selectFlag].selectFlag = true
                            }
                            
                            
                            
//                            self.classListData = (self.classData.first?.list)!
                            self.classListData = self.classData[self.selectFlag].list
                            self.lefttableView.reloadData()
                            self.rightCollectionView.reloadData()
                        }
                        
                    }catch _ {
                        let msg = "无网络连接"
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.warning(msg)
                    }
                    
                    
                    
                case .Failure( _):
                    let msg = "无网络连接"
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.warning(msg)
                    
                }
                
        }
        
    }
    
}