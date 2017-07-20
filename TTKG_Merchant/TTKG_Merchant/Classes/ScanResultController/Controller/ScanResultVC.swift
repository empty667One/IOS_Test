//
//  ScanResultVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/8/13.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class ScanResultVC: UIViewController {

    var scanResultModel : MerchantGoodsModel!
    
    var scanResultGoods = [MerchantGoodsData]()
    
    var scanBarCode = "" {
        didSet{
            requestForScanQRCode(scanBarCode)
        }
    }
    
    
    var QRCodeCollection : UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.minimumInteritemSpacing = 1//2.5
        layout.minimumLineSpacing = 1//2.5
        self.edgesForExtendedLayout = UIRectEdge.None
        let rect = CGRect(x: 0, y: 40, width: screenWith, height: screenHeigh - 104)
        QRCodeCollection = UICollectionView(frame: rect,collectionViewLayout: layout)
        self.view.addSubview(QRCodeCollection)
        QRCodeCollection.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(0)
        }
        QRCodeCollection!.delegate = self
        QRCodeCollection!.dataSource = self
        QRCodeCollection.backgroundColor =  UIColor(red: 236/255, green: 237/255, blue: 239/255, alpha: 1.0)
        
        QRCodeCollection.registerClass(GoodsListCell.self, forCellWithReuseIdentifier: "GoodsListCell")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ScanResultVC :  UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //商品列表cell
        let cell = QRCodeCollection.dequeueReusableCellWithReuseIdentifier("GoodsListCell", forIndexPath: indexPath) as!  GoodsListCell
        
        cell.goodsImage.sd_setImageWithURL(NSURL(string: serverPicUrl + self.scanResultGoods[indexPath.row].pictureurl))
        cell.goodsName.text = self.scanResultGoods[indexPath.row].title
        cell.nowPriceStr = String(format: "%.2f", self.scanResultGoods[indexPath.row].originalprice)//(self.goodsDatas[indexPath.row].originalprice).description
        cell.saleNumStr = (self.scanResultGoods[indexPath.row].salesvolume).description
        cell.oldPriceStr =  (self.scanResultGoods[indexPath.row].originalprice).description
        cell.shopName.text = "【" + self.scanResultGoods[indexPath.row].shopname + "】"
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let productVC = GoodsDetailVC()
        productVC.shopid = (self.scanResultGoods[indexPath.row].shopid).description
        productVC.productid = (self.scanResultGoods[indexPath.row].productid).description
        self.navigationController?.pushViewController(productVC, animated: true)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.scanResultGoods.count)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        let screenWith = UIScreen.mainScreen().bounds.width
        let size =  CGSize(width: (screenWith - 10)/2 , height: screenWith/2 + 40 )
        return size
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let edge = UIEdgeInsets(top: 1, left: 3.5, bottom: 2, right:3.5)
        return edge
    }
    
}


extension ScanResultVC {
    func requestForScanQRCode(code:String){
        let timeTemp = NSDate().getLocationTime() + userInfo_Global.timeStemp
        let MD5_time = Data_Access_MD5_RSA().DataAccessTo_MD5_RSA(timeTemp)
        
        let url = serverUrl + "/product/scancode"
        let parameters = ["code":code,"areaid":(userInfo_Global.areaid),"roleid":(userInfo_Global.roleid).description,"sign":MD5_time,"timespan":timeTemp.description]
        
        
        Alamofire.request(.GET, url, parameters: parameters)
            .responseString { response -> Void in
                
                switch response.result {
                case .Success:
                    let dict:NSDictionary?
                    do {
                        dict = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                        
                    }catch _ {
                        dict = nil
                    }
                    
                    self.scanResultModel = MerchantGoodsModel.init(fromDictionary: dict!)
                    
                    if (self.scanResultModel.code == 0){
                        self.scanResultGoods = self.scanResultModel.data
                        self.QRCodeCollection.reloadData()
                    }else{
                        
                        let alert = UIAlertView(title: "提示", message: "该产品条码:\(code)\n该平台没有该商品信息,我们正在丰富我们商品", delegate: self, cancelButtonTitle: "确定")
                        alert.show()
                    }
                    
                    
                case .Failure(let error):
                    print(error)
                }
        }

    }
}

extension ScanResultVC : UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}



