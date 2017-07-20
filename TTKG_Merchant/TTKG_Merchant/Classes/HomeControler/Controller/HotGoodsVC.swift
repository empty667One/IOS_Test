//
//  HotGoodsVC.swift
//  TTKG_Merchant
//
//  Created by macmini on 16/8/10.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import Alamofire

class HotGoodsVC: UIViewController {

    
    var collection : UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    var page = 1
    
    var hotGoodsModel : HotGoodsModel!
    var hotGoodsData = [HotGoodsData]()
  
    override func viewWillAppear(animated: Bool) {
        
        
        dropDownRef()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.title = "热卖商品"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

    
    override func viewDidLoad() {
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        //加载控件
        createUI()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
    }
    
    
    //MARK: Getter
    func createUI() {
        
        collection = UICollectionView(frame: CGRect(x: 0 ,y:  0, width: screenWith, height: screenHeigh - 64), collectionViewLayout: layout)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSizeMake((screenWith - 15 )/2 , screenHeigh / 3 + 40)
        
        
        collection.backgroundColor = UIColor(red: 236 / 255, green: 237 / 255, blue: 239 / 255, alpha: 1)
        collection!.delegate = self
        collection!.dataSource = self
        
        self.view.addSubview(collection)
        
        collection.registerClass(HotGoodsCell.self, forCellWithReuseIdentifier: "hotGoods")
        
        collection.registerClass(HomeVCSecondHeaderView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader , withReuseIdentifier: "secondHeaderView")
        
        
        //下拉刷新
        collection.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(self.dropDownRef))
        
        //上拉加载更多
        self.collection.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.pullUpRef))
        

    }
    
    //MARK:Request   LoadData
    func dropDownRef()  {
        
        if onlineState {
            self.hotGoodsData = []
            page = 1
            requestHotGoodsData(userInfo_Global.roleid, areaid: userInfo_Global.areaid, page: page)
            
            
        }
        
    }
    
    //LoadMoreData
    func pullUpRef()  {
        
        if onlineState {
            
            page = page + 1
            requestHotGoodsData(userInfo_Global.roleid, areaid: userInfo_Global.areaid, page: page )
            
        }else{
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }

        
        
       
    }
}

//MARK:UICollectionViewDelegate
extension HotGoodsVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.hotGoodsData.count
        
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell : HotGoodsCell = self.collection.dequeueReusableCellWithReuseIdentifier("hotGoods", forIndexPath: indexPath) as! HotGoodsCell
        
        cell.contentLabel.text = ("\(self.hotGoodsData[indexPath.row].productname)[\(self.hotGoodsData[indexPath.row].specititle)]")
        
        cell.imgUrl = self.hotGoodsData[indexPath.row].image
        cell.priceLabel.text = String(format: "￥%.2f", self.hotGoodsData[indexPath.row].price)
        cell.shopname.text = ("【\(self.hotGoodsData[indexPath.row].shopname)】")
        cell.buyBtn.tag = indexPath.row
        cell.delegate = self

        if self.hotGoodsData[indexPath.row].giftmassage == ""{
            
            cell.smallLaBa.image = UIImage(named: "")
        }
        
        if self.hotGoodsData[indexPath.row].hassale == true {
            cell.smallImg.image = UIImage(named: "促销")
            cell.priceLabel.text = String(format: "￥%.2f", self.hotGoodsData[indexPath.row].saleprice)
            cell.saleprice.text = String(format: "￥%.2f", self.hotGoodsData[indexPath.row].price)
            
            //中划线
            let value = cell.saleprice.text!
            let attr = NSMutableAttributedString(string:cell.saleprice.text!)
            let str = String(stringInterpolationSegment: value)
            let length =  str.characters.count
            
            attr.addAttribute(NSStrikethroughStyleAttributeName, value:1 , range: NSMakeRange(0, length))
            
            //赋值
            cell.saleprice.attributedText = attr
            
        }else{
            cell.smallImg.image = UIImage(named: "")
            cell.priceLabel.text = String(format: "￥%.2f", self.hotGoodsData[indexPath.row].price)
            cell.saleprice.text = ""
        }
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
        
    }
    
    
}

extension HotGoodsVC : UICollectionViewDelegateFlowLayout, HotGoodsCellDelegate{
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
        
    }
    
    //设置头部视图
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView : HomeVCSecondHeaderView = collection.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "secondHeaderView", forIndexPath: indexPath) as! HomeVCSecondHeaderView
        
        
        headerView.imageView.image = UIImage(named: "2_06")
        return headerView
        
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSizeMake(screenWith, screenHeigh / 4)
    }
    
    //cell的点击
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        
        let productVC = GoodsDetailVC()
        productVC.shopid = self.hotGoodsData[indexPath.row].shopid.description
        productVC.productid = self.hotGoodsData[indexPath.row].productid.description
        productVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(productVC, animated: true)
    }
    
    func giftMessageBtnClickToView(message: String) {
        
    }
    
    //加入进货单
    func buyBtnClickPushToVC(index:Int) {
        
        
        addToShoppingCart(self.hotGoodsData[index].merchantid.description, quantity:1 )
        
    }
    func addToShoppingCart(merchantid:String,quantity:Int)  {
        
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl  + "/shoppingcart/add"
        let parameters = [
            "usertype": 1,//买家类别 1：商家，2：会员
            "userid": (userInfo_Global.keyid).description,//用户id
            
            "merchantid": merchantid,//价格id
            
            "quantity":quantity.description,//产品数量
            "sign":MD5_time,"timespan":timeTemp.description
        ]
        
        
        let HUD = MBProgressHUD.showHUDAddedTo(view, animated: true)
        
        HUD.mode = MBProgressHUDMode.Indeterminate
        
        
        Alamofire.request(.POST, url, parameters: parameters as? [String : AnyObject]).responseString { response -> Void in
            
            switch response.result {
            case .Success:
                let dict:NSDictionary?
                do {
                    dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    
                    //let data = dict!["data"] as? String
                    let message = dict!["msg"] as? String
                    let status = dict!["code"] as? Int
                    
                    
                    HUD.label.text = message
                    if (status == 0)  {
                        
                        HUD.hideAnimated(true, afterDelay: 0.5)
                    }else{
                        HUD.hideAnimated(true, afterDelay: 1)

                    }
                    
                    
                }catch _ {
                    let msg = "无网络连接"
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.warning(msg)
                    self.collection.mj_header.endRefreshing()
                    self.collection.mj_footer.endRefreshing()
                    
                }
                
            case .Failure(let _):
                let msg = "无网络连接"
                self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                self.view.dodo.style.bar.locationTop = false
                self.view.dodo.warning(msg)
                self.collection.mj_header.endRefreshing()
                self.collection.mj_footer.endRefreshing()
            }
            
        }
        
    }

}

//MARK:LoadUp
extension HotGoodsVC{
    
    //获取热卖商品
    func requestHotGoodsData(roleid:Int,areaid:String,page:Int) {
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/sales/hotlist"
        let p = ["roleid":roleid.description,"areaid":areaid,"page":page.description,"userid":userInfo_Global.keyid,"sign":MD5_time,"timespan":timeTemp.description]
        
        
        Alamofire.request(.GET, url, parameters:p as! [String : AnyObject] )
            .responseString { response -> Void in
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                        if dict!["code"] as! Int == 0 {
                            self.hotGoodsModel = HotGoodsModel.init(fromDictionary: dict!)
                            
                            self.hotGoodsData += self.hotGoodsModel.data
                            
                            
                            self.collection.reloadData()
                            
                            self.collection.mj_header.endRefreshing()
                            self.collection.mj_footer.endRefreshing()
                        }else{
                            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                            self.view.dodo.style.bar.locationTop = false
                            self.view.dodo.warning(dict!["msg"] as! String)
                            self.collection.mj_header.endRefreshing()
                            self.collection.mj_footer.endRefreshing()
                        }

                        
                    }catch _ {
                        let msg = "无网络连接"
                        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                        self.view.dodo.style.bar.locationTop = false
                        self.view.dodo.warning(msg)
                        self.collection.mj_header.endRefreshing()
                        self.collection.mj_footer.endRefreshing()
                    }
                    
                    
                case .Failure(let _):
                    let msg = "无网络连接"
                    self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                    self.view.dodo.style.bar.locationTop = false
                    self.view.dodo.warning(msg)
                    self.collection.mj_header.endRefreshing()
                    self.collection.mj_footer.endRefreshing()
                }
                
        }
    }

}
