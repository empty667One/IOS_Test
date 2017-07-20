//
//  GoodsCarVC.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/29.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit
import SDWebImage

class GoodsCarVC: UIViewController {
    //移除通知
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //购物车数据
    private var shoppingCarDatas = [ShoppingCarData]()
    
    //总价
    var allPrice:UILabel!
    //结算按钮
    private var checkOutBtn:UIButton!
    //选中所有商品
    private var selectAllGoodsBtn:UIButton!
    //底部视图容器
    private var bottomContainerView:UIView!
    //
    private var shoppingCarTableView:UITableView!
    
    let http = ShoppingCarAPI.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        creatUI()
        
        //接受通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsCarVC.shoppingCarModelChangedProcess(_:)), name: "shoppingCarModelChanged", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsCarVC.shoppingCarAPI_SendErrorMsgProcess(_:)), name: "ShoppingCarAPI_SendErrorMsg", object: nil)
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //请求数据
        http.removeAllShopCarData()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        dropDownRef()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func creatUI() {
        self.edgesForExtendedLayout = UIRectEdge.None
        
        //购物车tableview
        let rect01 = CGRect(x: 0, y: 0, width: screenWith, height: screenHeigh - 108)
        shoppingCarTableView = UITableView(frame: rect01, style: .Grouped)
        shoppingCarTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(shoppingCarTableView)
        shoppingCarTableView.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(self.view.snp_bottom).offset(-44)

        }
        shoppingCarTableView.registerClass(ShoppingCarCell.self, forCellReuseIdentifier: "ShoppingCarCell")
        shoppingCarTableView.delegate = self
        shoppingCarTableView.dataSource = self
        
        shoppingCarTableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(GoodsCarVC.dropDownRef))
        
        bottomContainerView = UIView()
        self.view.addSubview(bottomContainerView)
        bottomContainerView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(shoppingCarTableView.snp_bottom)
            make.bottom.equalTo(self.view.snp_bottom)
        }
        
        selectAllGoodsBtn = UIButton()
        bottomContainerView.addSubview(selectAllGoodsBtn)
        selectAllGoodsBtn.snp_makeConstraints { (make) in
            make.left.equalTo(1)
            make.centerY.equalTo(bottomContainerView.snp_centerY)
            make.width.height.equalTo(40)
        }
        selectAllGoodsBtn.setImage(UIImage(named: "购物车_10"), forState: UIControlState.Normal)
        selectAllGoodsBtn.addTarget(self, action: #selector(GoodsCarVC.selectAllGoodsBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let selectAllTitle = UILabel()
        selectAllTitle.text = "全选"
        selectAllTitle.font = UIFont.systemFontOfSize(14)
        bottomContainerView.addSubview(selectAllTitle)
        selectAllTitle.snp_makeConstraints { (make) in
            make.left.equalTo(selectAllGoodsBtn.snp_right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(50)
        }
        
        checkOutBtn = UIButton()
        bottomContainerView.addSubview(checkOutBtn)
        checkOutBtn.snp_makeConstraints { (make) in
            make.right.top.bottom.equalTo(0)
            make.width.equalTo(screenWith/3 )
        }
        checkOutBtn.backgroundColor = UIColor.grayColor()
        checkOutBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        checkOutBtn.setTitle("结算(0)", forState: UIControlState.Normal)
        checkOutBtn.userInteractionEnabled = false
        checkOutBtn.addTarget(self, action: #selector(GoodsCarVC.checkOutBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        allPrice = UILabel()
        bottomContainerView.addSubview(allPrice)
        allPrice.snp_makeConstraints { (make) in
            make.right.equalTo(checkOutBtn.snp_left).offset(-8)
            make.top.equalTo(0)
            make.bottom.equalTo(0).offset(-12)
            make.width.equalTo(screenWith/3 + 20)
        }
        allPrice.textColor = UIColor.redColor()
        allPrice.font = UIFont.systemFontOfSize(14)
        allPrice.textAlignment = .Right
        
        let attr = NSMutableAttributedString(string: "合计:￥0.00")
        attr.addAttribute(NSForegroundColorAttributeName, value:UIColor.blackColor(), range: NSRange(location:0, length:3))
        allPrice.attributedText = attr
        
        //不含运费
        let carriage = UILabel()
        self.view.addSubview(carriage)
        carriage.snp_makeConstraints { (make) in
            make.right.equalTo(allPrice.snp_right)
            make.top.equalTo(allPrice.snp_bottom)
            make.bottom.equalTo(0).offset(-5)
            make.width.equalTo(allPrice.snp_width)
        }
        carriage.text = "不含运费"
        carriage.font = UIFont.systemFontOfSize(12)
        carriage.textColor = UIColor.grayColor()
        carriage.textAlignment = .Right
        
        self.navigationItem.title = "进货单"
    }

}

extension GoodsCarVC{
    //下拉刷新
    func dropDownRef() {
        
        http.requestShoppingCarListFromServer(userInfo_Global.keyid)
    }
    
    func shoppingCarModelChangedProcess(notice:NSNotification){
        shoppingCarTableView.mj_header.endRefreshing()
        self.shoppingCarDatas = http.getShoppingCarData()
        self.shoppingCarTableView.reloadData()
        
        //刷新底部视图
        setBottomView(self.allPrice, selectAllGoodsBtn: self.selectAllGoodsBtn, checkOutBtn: self.checkOutBtn)
        
        //右上角删除按钮
        addDeleteBtn()
        
        if self.shoppingCarDatas.count == 0 {
            let backgroundView = UIImageView(image: UIImage(named:"背景"))
            
            self.shoppingCarTableView.backgroundView = backgroundView
        }else{
            self.shoppingCarTableView.backgroundView = nil
        }
        
    }
    
    func shoppingCarAPI_SendErrorMsgProcess(notice:NSNotification)  {
        shoppingCarTableView.mj_header.endRefreshing()
        
        self.shoppingCarDatas = http.getShoppingCarData()
        self.shoppingCarTableView.reloadData()
        
        
        let msg = notice.object!["errorMsg"] as! String
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)
        
        if self.shoppingCarDatas.count == 0 {
            let backgroundView = UIImageView(image: UIImage(named:"背景"))
            
            self.shoppingCarTableView.backgroundView = backgroundView
        }else{
            self.shoppingCarTableView.backgroundView = nil
        }
    }
}


extension GoodsCarVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.shoppingCarDatas.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shoppingCarDatas[section].products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ShoppingCarCell") as! ShoppingCarCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.delegate = self
        
        let (name,price,img,num,selectedFlag) = self.shoppingCarDatas[indexPath.section].ex_goodsInfo(indexPath.row)
        
        cell.index = indexPath
        cell.shopName.text = name
        cell.goodsPrice.text = "￥\(String(format: "%.2f",price))"
        cell.shopActivity.text = ""
        cell.selectFlag = selectedFlag
        cell.shopImage.sd_setImageWithURL(NSURL(string: serverPicUrl + img)!)
        cell.selectNumBtn = SelectNumBtn(width: 100, height: 30, center: CGPoint(x: 0,y: 0), num: num)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (self.shoppingCarDatas[section].shopname != nil) {
            let headerView = ShoppingCarHeaderView()
            
            //标记
            headerView.tag = section
            
            headerView.delegate = self
            headerView.headerBtn.tag = section
            
            headerView.selectFlag = self.shoppingCarDatas[section].ex_selectedAllGoodsFlag()
            headerView.headerName.text = self.shoppingCarDatas[section].shopname
            return headerView
        }else{
            return nil
        }
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (self.shoppingCarDatas[section].shopname != nil) {
            let footerView = ShoppingCarFooterView()
            
            footerView.shippingAmount.text = "起配金额" + String(format: "%.2f",self.shoppingCarDatas[section].carryingamount)
            
            if self.shoppingCarDatas[section].activitie.characters.count == 0 {
                footerView.merchantWantSay = ""
            }else{
                footerView.merchantWantSay = "店铺活动:" + String(self.shoppingCarDatas[section].activitie)
            }
            
            footerView.delegate = self
            footerView.tag = section
            
            //具备多行显示的条件
            if footerView.moreInfoShowFlag {
                footerView.moreInfoShowBtn.hidden = false
                //判断底部是否需要显示更多标记
                if self.shoppingCarDatas[section].showMoreLineActivitie {
                    //footerView.moreInfoShowBtn.setImage(UIImage(named: "indicateUp"), forState: UIControlState.Normal)
                    footerView.showMoreInfoImg.image = UIImage(named: "indicateUp")
                    
                }else{
                    //footerView.moreInfoShowBtn.setImage(UIImage(named: "indicateDown"), forState: UIControlState.Normal)
                    footerView.showMoreInfoImg.image = UIImage(named: "indicateDown")
                    
                }
            }else{//不具备多行显示的条件,隐藏按钮
                footerView.moreInfoShowBtn.hidden = false
                footerView.showMoreInfoImg.image = nil
            }
            
            
            return footerView
        }else{
            return nil
        }
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        //计算需要展示的内容宽高
        let rect = getTextRectSize(self.shoppingCarDatas[section].activitie, font: UIFont.systemFontOfSize(9), size: CGSize(width: screenWith-55, height: 100))
        
        if self.shoppingCarDatas[section].showMoreLineActivitie {
           return 20 + rect.height
        }else{
           return 30
        }
        
        
    }
    
    //
    //滑动删除必须实现的方法
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        removeGoodsFromShoppingCar(indexPath)
    }
    //滑动删除
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    //设置删除按钮的文字
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "移除进货单";
    }
    
}


extension GoodsCarVC:ShoppingCarCellDelegate,ShoppingCarHeaderVIewDelegate {
    
    /**
     进入商家
     
     - parameter section: section description
     */
    func enterMerchantBtnClk(section:Int){
        
        
        let merchantdetailVC = MerchantDetailVC()
        merchantdetailVC.shopid = String(self.shoppingCarDatas[section].shopid)
        merchantdetailVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(merchantdetailVC, animated: false)
        
    }
    
    //对某一个商品进行勾选或取消勾选
    func selectCellBtn(section:NSIndexPath,status:Bool){
        //需要修改模型对应的按钮选中状态
        http.setSelectCellBtn(section, status: status)
    }
    
    //加减购物车数量
    func addOrReduceShopCarGoodsNum(index:NSIndexPath,num:Int){
        
        if num == 100 {
            let msg = "每次最多100件啦"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
        if num == 1 {
            let msg = "最小数量为1啦"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
        }
        
        let cartid = self.shoppingCarDatas[index.section].products[index.row].cartid
        http.resetShopCarGoodsNum(cartid, quantity: num)
    }
    
    //该商家下的商品全选状态
    func selectHeaderBtn(sender: Int,status : Bool){
        http.setAllSelectCellBtn(sender, selectedFlag: status)
    }
    
    /**
     底部容器需要的内容
     
     - returns: return value description
     */
    func dataForBottomView()->(allSelectedFlag:Bool,selectedGoodsAllPrice:Double,allNumOfSelectedGoods:Int){
        var allSelectedFlag = true
        var selectedGoodsAllPrice = 0.00
        var allNumOfSelectedGoods = 0
        
        //1全选标记
        for item in self.shoppingCarDatas {
            let selectAllGoods = item.ex_selectedAllGoodsFlag()
            if !selectAllGoods {
                allSelectedFlag = false
                break
            }
        }
        
        //没有一个商家的时候
        if shoppingCarDatas.count == 0 {
            allSelectedFlag = false
        }
        
        //2计算选中商品的所有价格和选中商品的件数
        for item in self.shoppingCarDatas {
            for  goods in item.products {
                if goods.selectedFlag {
                    selectedGoodsAllPrice += goods.price*(Double(goods.quantity))
                    allNumOfSelectedGoods += 1
                }
            }
        }
        
        return (allSelectedFlag,selectedGoodsAllPrice,allNumOfSelectedGoods)
    }
    
    //获取底部视图需要的数据
    func setBottomView(allPrice:UILabel,selectAllGoodsBtn:UIButton,checkOutBtn:UIButton)  {
        let (allSelectedFlag,selectedGoodsAllPrice,allNumOfSelectedGoods) = dataForBottomView()
        
        let price = String(format: "%.2f",selectedGoodsAllPrice)
        let attr = NSMutableAttributedString(string: "合计:￥\(price)")
        attr.addAttribute(NSForegroundColorAttributeName, value:UIColor.blackColor(), range: NSRange(location:0, length:3))
        allPrice.attributedText = attr
        
        //全选标记
        if allSelectedFlag {
            selectAllGoodsBtn.setImage(UIImage(named: "勾"), forState: UIControlState.Normal)
        }else{
            selectAllGoodsBtn.setImage(UIImage(named: "购物车_10"), forState: UIControlState.Normal)
        }
        checkOutBtn.setTitle("结算(\(allNumOfSelectedGoods))", forState: UIControlState.Normal)
        
        //没有商品，不能点击
        if allNumOfSelectedGoods == 0 || selectedGoodsAllPrice == 0.0 {
            checkOutBtn.backgroundColor = UIColor.grayColor()
            checkOutBtn.userInteractionEnabled = false
        }else{
            checkOutBtn.backgroundColor = UIColor.redColor()
            checkOutBtn.userInteractionEnabled = true
        }
    }
    
    /**
     全选按钮动作
     */
    func selectAllGoodsBtnClk(){
        if self.selectAllGoodsBtn.imageForState(UIControlState.Normal) == UIImage(named: "勾"){
            
            for (index,_) in (self.shoppingCarDatas.enumerate()) {
                http.setAllSelectCellBtn(index, selectedFlag: false)
            }
        }else{
            
            for (index,_) in (self.shoppingCarDatas.enumerate()) {
              http.setAllSelectCellBtn(index, selectedFlag: true)
            }
        }
    }
    
    /**
     删除选中的商品
     */
    func deleteSelectedGoods()  {
        var cartids = [Int]()
        for shoppingCarData in self.shoppingCarDatas {
            for item in shoppingCarData.products {
                if item.selectedFlag {
                    cartids.append(item.cartid)
                }
            }
        }
        http.removeGoodsFromShoppingCar(cartids)
    }
    
    /**
     将商品移除购物车
     
     - parameter indexPath: indexPath description
     */
    func removeGoodsFromShoppingCar(indexPath: NSIndexPath)  {
        http.removeGoodsFromShoppingCar([self.shoppingCarDatas[indexPath.section].products[indexPath.row].cartid])
        dropDownRef()
    }
    
    //添加右上角删除按钮
    func addDeleteBtn()  {
        for value:ShoppingCarData in shoppingCarDatas {
            for goods in value.products {
                if goods.selectedFlag {
                   
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "删除", style: UIBarButtonItemStyle.Done, target: self, action: #selector(GoodsCarVC.deleteSelectedGoods))
                    return
                }
            }
        }
        self.navigationItem.rightBarButtonItem = nil
    }
    
    
    /**
     结算按钮点击事件
     */
    func checkOutBtnClk(){
        
        var merchantName = String()
        var condition = true
        
        for merchant in self.shoppingCarDatas {
            let merchantPrice = merchant.carryingamount
            var priceTemp = 0.00
            var someGoodsSelected = false
            for goods in merchant.products {
                if goods.selectedFlag {
                    someGoodsSelected = true
                    //计算该商家下选中商品的总价
                   priceTemp  += goods.price * Double(goods.quantity)
                }
            }
            
            
            if someGoodsSelected {
                if merchantPrice > priceTemp {
                    condition = false
                    merchantName = merchant.shopname
                    break
                }else{
                    condition = true
                }
            }else{
                
            }
            
           
            
        }
        
        
        if !condition {
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(merchantName + "的商品不满足起配条件")
            return
        }
        
        
        //给商家商品重新赋值
        var dataTemp = self.shoppingCarDatas
        for item in dataTemp {
            var productTemp = [ShoppingCarProduct]()
            for items in item.products {
                if items.selectedFlag {
                    productTemp.append(items)
                }
            }
            item.products = productTemp
        }
        
        
        //只添加有商品的商家
        var dataTempMerchantInfo = [ShoppingCarData]()
        for item in dataTemp {
            if item.products.count != 0 {
                dataTempMerchantInfo.append(item)
            }
        }
        
        let confirmVC = ConfirmOrderVC()
        confirmVC.confirmOrderDatas = dataTempMerchantInfo
        confirmVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(confirmVC, animated: true)
    }
}


extension GoodsCarVC:ShoppingCarFooterViewDelegate{
    //更多信息需要进行显示标记
    func moreInfoNeedShow(flag:Bool,section:Int){
        
        let showFlag = self.shoppingCarDatas[section].showMoreLineActivitie
        
        self.shoppingCarDatas[section].showMoreLineActivitie = !showFlag
        self.shoppingCarTableView.reloadData()
        
    }
    
    
    //获取字符串宽高
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
}


