//
//  GoodsDetailVC.swift
//  CLLoopScrollView
//
//  Created by iosnull on 16/6/21.
//  Copyright © 2016年 ChrisLian. All rights reserved.
//

import UIKit
import SnapKit
import SDCycleScrollView
import Alamofire

//商家活动内容
class ShopActivityCell: UITableViewCell {
    private let spareLine = UIView()
    var activityInfo = String(){
        didSet{
            self.title.text = activityInfo
            self.title.snp_makeConstraints { (make) in
                make.left.equalTo(0).offset(3)
                make.right.equalTo(0)
                make.bottom.equalTo(0).offset(-3)
                make.top.equalTo(self.spareLine.snp_bottom).offset(3)
            }
        }
    }
    
    private var title = UILabel()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(title)
        title.font = UIFont.systemFontOfSize(14)
        title.numberOfLines = 0
        title.textColor = UIColor.redColor()
        
        self.addSubview(spareLine)
        spareLine.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        spareLine.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(3)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GoodsMoreInfoCell: UITableViewCell {
    
    
    private let spareLine = UIView()
    
    //获取字符串宽高
    private func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
    //设置标题和内容
    func setForTitle(title:String,andDetail:String)  {
        let titleWidth = getTextRectSize(title, font: UIFont.systemFontOfSize(14), size: CGSize(width: screenWith/2, height: 30))
        self.title.snp_makeConstraints { (make) in
            make.top.equalTo(spareLine.snp_top).offset(2)
            make.left.equalTo(8)
            make.bottom.equalTo(0)
            make.width.equalTo(titleWidth.width)
        }
        self.detail.snp_makeConstraints { (make) in
            make.left.equalTo(self.title.snp_right).offset(8)
            make.right.equalTo(0)
            make.top.equalTo(self.title.snp_top)
            make.bottom.equalTo(0)
        }
        
        self.title.text = title
        self.detail.text = andDetail
    }
    
    private var title = UILabel()
    private var detail = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(title)
        self.addSubview(detail)
        title.font = UIFont.systemFontOfSize(14)
        detail.font = UIFont.systemFontOfSize(14)
        self.backgroundColor = UIColor.whiteColor()
        
        
        self.addSubview(spareLine)
        spareLine.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        spareLine.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(3)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//添加按钮cell
class AddBtnCell: UITableViewCell {
    let selectNumBtn = SelectNumBtn(width: 100, height: 30, center: CGPoint(x: UIScreen.mainScreen().bounds.width - 120, y: 20),num: 16)
    
    let spareView = UIView(frame: CGRect(x: 0, y: 2, width: UIScreen.mainScreen().bounds.width, height: 3))
    
    let title = UILabel(frame: CGRect(x: 10, y: 20, width: 100, height: 30))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(selectNumBtn)
        self.addSubview(title)
        self.addSubview(spareView)
        title.text = "购买数量"
        spareView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
    }
    convenience init(style: UITableViewCellStyle, reuseIdentifier: String?,startNum:Int) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class GoodsSelectCell: UITableViewCell {
    
    var moreLableShowView:MoreLableShowView?
    var titleFont:CGFloat?
    var cornerRadius:CGFloat?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加多标签
    func setSubView(frame: CGRect,lableNames: [String],selectedIndex:Int)  {
        
        let tempView = MoreLableShowView(frame: frame, lableNames: lableNames,selectedIndex:selectedIndex)
        
        
//        for item in self.subviews {
//            if item.isKindOfClass(MoreLableShowView.self) {
//                item.removeFromSuperview()
//            }
//            
//        }
        
        
        
        moreLableShowView = tempView
        self.addSubview(moreLableShowView!)
        
        moreLableShowView!.dataArr = lableNames
        
        if titleFont != nil {
            moreLableShowView?.titleFont = titleFont!
        }
        if cornerRadius != nil {
            moreLableShowView?.cornerRadius = cornerRadius!
        }
        
        //self.backgroundColor = UIColor.redColor()
    }
}


//属性展示cell
class AttributeCell: UITableViewCell {
    
    var titleStr:String?{
        didSet{
            title.text = titleStr! + ":"
        }
    }
    
    var contentStr:String?{
        didSet{
            NSLog("contentStr == \(contentStr)")
            content.text = contentStr
        }
    }
    
    private let spareView = UIView()
    private let title = UILabel()
    private let content = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(title)
        self.addSubview(content)
        title.font = UIFont.systemFontOfSize(12)
        title.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.centerY.equalTo(self.snp_centerY)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        content.font = UIFont.systemFontOfSize(12)
        content.snp_makeConstraints { (make) in
            make.left.equalTo(title.snp_left).offset(2)
            make.centerY.equalTo(title.snp_centerY)
            make.right.equalTo(0).offset(-2)
            make.height.equalTo(30)
        }
        
        self.addSubview(spareView)
        spareView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        spareView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class GoodsDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //是自己的商品吗？
    var isMySelfGoods = false
    
    var merchantProductPriceID = 0 //从满赠传过来的规格ID
    
    //默认选中第一个商品规格
    private var selectIndex:Int = 0
    //打算要购买的该商品数量
    private var numOfGoods = 1
    
    var shopid = String()//商家id
    var productid = String()//产品id
    
    private var img :UIImageView?
    
    //商品详情数据
    private var goodsDetailInfoData:GoodsDetailInfoData?
    
    private var guiGeNames = [String]()
    
    private var tableView:UITableView?
    private var tableViewHeaderView:UIView?
    
    private let http = GoodsDetailDataAPI.shareInstance
    
    private var headerView:UIView?
    private var bottomView:UIView?
    private var bottonRightView:UIView?
    private var showActivityMessage = ""
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17 / 255, green: 182 / 255, blue: 244 / 255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "商品详情"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //商店ID
        //shopid = shopID_GlobleVar
        
        let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height  - 50)
        tableView = UITableView(frame: rect, style: UITableViewStyle.Plain)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView?.registerClass(ShopActivityCell.self, forCellReuseIdentifier: "ShopActivityCell")
        tableView?.registerClass(GoodsMoreInfoCell.self, forCellReuseIdentifier: "GoodsMoreInfoCell")
        tableView?.registerClass(AddBtnCell.self, forCellReuseIdentifier: "cell2")
        tableView?.registerClass(GoodsSelectCell.self, forCellReuseIdentifier: "cell1")
        tableView?.registerClass(AttributeCell.self, forCellReuseIdentifier: "AttributeCell")
        tableView?.allowsSelection = false
        
        self.view.addSubview(tableView!)
        
        
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 30))
        let name = UILabel(frame: CGRect(x: 8, y: 0, width: 200, height: 30))
        name.text = "规格"
        name.font = UIFont.systemFontOfSize(14)
        headerView?.addSubview(name)
        headerView?.backgroundColor = UIColor.whiteColor()
        
        
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1.0)
        //导航栏左边返回按钮

//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(GoodsDetailVC.back))
        //导航栏右边返回按钮
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "shareImg")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(GoodsDetailVC.shareGoodsBtn))
        
        
        //商品详情模型通知接收
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsDetailVC.goodsDetailInfoDataChangedProcess), name: "GoodsDetailInfoDataChanged", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GoodsDetailVC.goodDetail_SendErrorMsg(_:)), name: "goodDetail_SendErrorMsg", object: nil)
        
        http.requestGoodsDetailInfoFromServer(shopid, productid: productid, roleid:userInfo_Global.roleid.description, userid:userInfo_Global.keyid.description)
    }
    
    //商品详情模型通知处理(正常情况只执行一次)
    func goodsDetailInfoDataChangedProcess()  {
        self.goodsDetailInfoData = http.getGoodsDetailInfo()
        
        selectIndex = 0
        
        if (self.goodsDetailInfoData?.specioptions[selectIndex].isbuy) != 0{
            
            if isMySelfGoods {
                 setBottomViewTemp()
            }else{
                setBottomViewTemp01()
            }
        }else{
                setBottomViewRepeat()
            
        }
        
            let (goodsName,imgUrlArry,giftInfo,stockCnt,sellCnt,oldPrice,nowPrice,promotionStatus) = (self.goodsDetailInfoData?.ex_headerInfo(0))!//默认是第一个规格选中
            
            //设置tableHeaderView
            let (tableHeaderView,_) = setTableViewHeader(goodsName, activity: giftInfo, storeCnt: stockCnt.description, sellCnt: sellCnt.description, nowPriceStr: nowPrice.description, oldPriceStr: oldPrice.description, img: imgUrlArry, promotionFlag: promotionStatus)
            
            self.tableView?.tableHeaderView = tableHeaderView
        
        
            self.tableView?.reloadData()
        
        if merchantProductPriceID == 0 {
            didSelectLableIndex(0)
        }else{
            let index = self.goodsDetailInfoData?.returnSpecitionSelectIndex(merchantProductPriceID)
            didSelectLableIndex(index!)
        }
        
    }
    
    //当请求错误时接受通知
    func goodDetail_SendErrorMsg(notice : NSNotification){
        
        let msg = notice.object!["errorMsg"]! as! String
        let status = notice.object!["status"]! as! String
      
        
        self.view.dodo.style.bar.hideAfterDelaySeconds = 1
        self.view.dodo.style.bar.locationTop = false
        self.view.dodo.warning(msg)
    }
    
    func shareGoodsBtn()  {
        
    }
    
//    func back()  {
//        self.navigationController?.popViewControllerAnimated(true)
//    }
    
    
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
    /**
     Description
     
     - parameter name:          name description
     - parameter activity:      activity description
     - parameter storeCnt:      storeCnt description
     - parameter sellCnt:       sellCnt description
     - parameter nowPriceStr:   nowPriceStr description
     - parameter oldPriceStr:   oldPriceStr description
     - parameter img:           img description
     - parameter promotionFlag: promotionFlag description
     
     - returns: return value description
     */
    func setTableViewHeader(name:String,activity:String,storeCnt:String,sellCnt:String,nowPriceStr:String,oldPriceStr:String,img:[String],promotionFlag:Int) ->(UIView,CGFloat) {
        
        let nameRect = getTextRectSize(name, font: UIFont.systemFontOfSize(14), size: CGSize(width: UIScreen.mainScreen().bounds.width - 20, height: 500))
        
        let activityRect = getTextRectSize(activity, font: UIFont.systemFontOfSize(12), size: CGSize(width: UIScreen.mainScreen().bounds.width - 20, height: 500))
        
        let bottomLableHeigth = CGFloat(30)
        
        let allHeigth = UIScreen.mainScreen().bounds.width + 8 +  nameRect.height + activityRect.height + bottomLableHeigth
        
        
        tableViewHeaderView = UIView(frame: CGRect(x: 0 , y: 0, width: UIScreen.mainScreen().bounds.width, height: allHeigth))
        
        //商品名称
        let goodsName = UILabel()
        goodsName.font = UIFont.systemFontOfSize(14)
        goodsName.textColor = UIColor(red: 40/255, green: 43/255, blue: 53/255, alpha: 1)
        goodsName.numberOfLines = 0
        goodsName.frame = CGRect(x: 10, y: allHeigth - (nameRect.height + activityRect.height + bottomLableHeigth ) , width: UIScreen.mainScreen().bounds.width - 20, height: nameRect.height)
        goodsName.text = name
        
        let goodsActImage = UIImageView(frame: CGRect(x: 0, y: allHeigth - ( activityRect.height + bottomLableHeigth ) , width: 20 , height: nameRect.height))
        goodsActImage.image = UIImage(named: "broadcastIcon")
        //商品活动
        let goodsActivity = UILabel()
        goodsActivity.font = UIFont.systemFontOfSize(12)
        goodsActivity.textColor = UIColor(red: 252/255, green: 137/255, blue: 0/255, alpha: 1)
        goodsActivity.numberOfLines = 0
        goodsActivity.frame = CGRect(x: 20, y: allHeigth - ( activityRect.height + bottomLableHeigth ) , width: UIScreen.mainScreen().bounds.width - 20 , height: nameRect.height)
        goodsActivity.text = activity
        
        self.showActivityMessage = activity
        
        let showActBtn = UIButton()
        showActBtn.frame = goodsActivity.frame
        showActBtn.addTarget(self, action: #selector(GoodsDetailVC.showActivityDetail), forControlEvents: UIControlEvents.TouchUpInside)
        
        if activity == "" {
            
        }else{
            tableViewHeaderView?.addSubview(showActBtn)
            tableViewHeaderView?.addSubview(goodsActImage)
        }
        tableViewHeaderView?.addSubview(goodsName)
        tableViewHeaderView?.addSubview(goodsActivity)
        
        
        let spareLine = UIView(frame: CGRect(x: 0, y: tableViewHeaderView!.frame.height - 3, width: UIScreen.mainScreen().bounds.width, height: 3))
        spareLine.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        tableViewHeaderView?.addSubview(spareLine)
        tableViewHeaderView?.backgroundColor = UIColor.whiteColor()
        
        let imgView = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: screenWith, height: screenWith), imageURLStringsGroup: nil)
        tableViewHeaderView?.addSubview(imgView)
        imgView.imageURLStringsGroup = img
        
        //库存
        let storeCntLable = UILabel()
        storeCntLable.frame = CGRect(x: 15, y: tableViewHeaderView!.frame.height - 30 , width: 100, height: 30)
        storeCntLable.text = "库存:" + storeCnt + "件"
        storeCntLable.font = UIFont.systemFontOfSize(10)
        tableViewHeaderView?.addSubview(storeCntLable)
        storeCntLable.textColor = UIColor(red: 174/255, green: 174/255, blue: 174/255, alpha: 1)
        //销量
        let sellCntLable = UILabel()
        sellCntLable.frame = CGRect(x: UIScreen.mainScreen().bounds.width/2 - 50, y: tableViewHeaderView!.frame.height - 30 , width: 100, height: 30)
        sellCntLable.text = "已售:" + sellCnt + "件"
        sellCntLable.font = UIFont.systemFontOfSize(10)
        tableViewHeaderView?.addSubview(sellCntLable)
        sellCntLable.textColor = UIColor(red: 174/255, green: 174/255, blue: 174/255, alpha: 1)
        //现价格
        let priceLable = UILabel()
        priceLable.font = UIFont.systemFontOfSize(14)
        priceLable.textColor = UIColor.redColor()
        priceLable.textAlignment = NSTextAlignment.Center
        tableViewHeaderView?.addSubview(priceLable)
        priceLable.snp_makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(sellCntLable.snp_bottom)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        //原价
        let oldPrice = UILabel()
        oldPrice.font = UIFont.systemFontOfSize(12)
        tableViewHeaderView?.addSubview(oldPrice)
        oldPrice.snp_makeConstraints { (make) in
            make.right.equalTo(priceLable.snp_left)
            make.height.equalTo(priceLable.snp_height)
            make.centerY.equalTo(priceLable.snp_centerY)
            make.width.equalTo(60)
        }
        
        
        if promotionFlag == 0 {//有促销活动显示促销价(//是否促销 0：开启，1：关闭)
            priceLable.text = "￥" + nowPriceStr
            
            //中划线
            let value = "￥" + oldPriceStr
            let attr = NSMutableAttributedString(string: "￥" + oldPriceStr)
            let str = String(stringInterpolationSegment: value)
            let length =  str.characters.count
            
            attr.addAttribute(NSStrikethroughStyleAttributeName, value:1 , range: NSMakeRange(0, length))
            //赋值
            oldPrice.attributedText = attr
            
        }else{//没有促销活动显示原价
            priceLable.text = "￥" + oldPriceStr
            oldPrice.text = ""
        }
        
        return (tableViewHeaderView!,allHeigth)
    }
    
    func showActivityDetail(){
        let alert = UIAlertView(title: "活动详情", message: self.showActivityMessage, delegate: nil, cancelButtonTitle: "知道了~")
        alert.show()
        
    }
    
    func setBottomViewTemp()  {
        if bottomView?.superview != nil {
            bottomView?.removeFromSuperview()
        }
        
        if bottonRightView?.superview != nil {
            bottonRightView?.removeFromSuperview()
        }
        
        if self.img?.superview != nil {
            self.img?.removeFromSuperview()
        }
        
        //底部视图
        bottomView = UIView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - 44, width: UIScreen.mainScreen().bounds.height, height: 44))
        bottomView?.backgroundColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1)
        let addToCartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        bottomView?.addSubview(addToCartBtn)
        addToCartBtn.setTitle("本店商品只能查看!", forState: UIControlState.Normal)
        addToCartBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        addToCartBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
        self.view.addSubview(bottomView!)
        
      
    }
    
    func setBottomViewTemp01()  {
        
        if bottomView?.superview != nil {
            bottomView?.removeFromSuperview()
        }
        
        if bottonRightView?.superview != nil {
            bottonRightView?.removeFromSuperview()
        }
        
        if self.img?.superview != nil {
            self.img?.removeFromSuperview()
        }
        
        //底部视图
        bottomView = UIView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - 44, width: UIScreen.mainScreen().bounds.height, height: 44))
        bottomView?.backgroundColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1)
        let addToCartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        bottomView?.addSubview(addToCartBtn)
        addToCartBtn.setTitle("如需购买，请联系该商家", forState: UIControlState.Normal)
        addToCartBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        addToCartBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
        self.view.addSubview(bottomView!)
        
        
    }
    
    
    func setBottomViewRepeat()  {
        
        if bottomView?.superview != nil {
            bottomView?.removeFromSuperview()
        }
        
        if bottonRightView?.superview != nil {
            bottonRightView?.removeFromSuperview()
        }
        
        if self.img?.superview != nil {
            self.img?.removeFromSuperview()
        }
        
        //底部视图
        bottomView = UIView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - 44, width: UIScreen.mainScreen().bounds.height, height: 44))
        bottomView?.backgroundColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1)
        let addToCartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        bottomView?.addSubview(addToCartBtn)
        addToCartBtn.setTitle("加入购物车", forState: UIControlState.Normal)
        addToCartBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        addToCartBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
        self.view.addSubview(bottomView!)
        
        //底部最右边的视图
        bottonRightView = UIView(frame: CGRect(x: UIScreen.mainScreen().bounds.width - 70, y: UIScreen.mainScreen().bounds.height - 70, width: 60, height: 60))
        self.view.addSubview(bottonRightView!)
        bottonRightView!.backgroundColor = UIColor.clearColor()
        bottonRightView!.layer.cornerRadius = 30
        bottonRightView!.layer.borderWidth = 4
        bottonRightView!.layer.borderColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1).CGColor
        bottonRightView!.backgroundColor = UIColor.whiteColor()
        img = UIImageView(frame: CGRect(x: UIScreen.mainScreen().bounds.width - 70, y: UIScreen.mainScreen().bounds.height - 70, width: 60, height: 60))
        img!.image = UIImage(named: "shopcar1234")
        img!.contentMode = .ScaleAspectFit
        img!.layer.cornerRadius = 30
        img!.layer.borderWidth = 4
        img!.layer.borderColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1).CGColor
        self.view.addSubview(img!)
        
        
        let goToShoppingCart = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        goToShoppingCart.addTarget(self, action: #selector(GoodsDetailVC.goToShoppingCartClk), forControlEvents: UIControlEvents.TouchUpInside)
        bottonRightView!.addSubview(goToShoppingCart)
        
        addToCartBtn.addTarget(self, action: #selector(GoodsDetailVC.addToCartBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
    }
    
    
    func setBottomView()  {
        
        if bottomView?.superview != nil {
            bottomView?.removeFromSuperview()
        }
        
        if bottonRightView?.superview != nil {
            bottonRightView?.removeFromSuperview()
        }
        
        if self.img?.superview != nil {
            self.img?.removeFromSuperview()
        }
        
        //底部视图
        bottomView = UIView(frame: CGRect(x: 0, y: UIScreen.mainScreen().bounds.height - 44, width: UIScreen.mainScreen().bounds.height, height: 44))
        bottomView?.backgroundColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1)
        let addToCartBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        bottomView?.addSubview(addToCartBtn)
        addToCartBtn.setTitle("加入购物车", forState: UIControlState.Normal)
        addToCartBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        addToCartBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
        self.view.addSubview(bottomView!)
        
        //底部最右边的视图
        bottonRightView = UIView(frame: CGRect(x: UIScreen.mainScreen().bounds.width - 70, y: UIScreen.mainScreen().bounds.height - 70, width: 60, height: 60))
        self.view.addSubview(bottonRightView!)
        bottonRightView!
            .backgroundColor = UIColor.clearColor()
        bottonRightView!.layer.cornerRadius = 30
        bottonRightView!.layer.borderWidth = 4
        bottonRightView!.layer.borderColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1).CGColor
        bottonRightView!.backgroundColor = UIColor.whiteColor()
        let img = UIImageView(frame: CGRect(x: UIScreen.mainScreen().bounds.width - 70, y: UIScreen.mainScreen().bounds.height - 70, width: 60, height: 60))
        img.image = UIImage(named: "shopcar1234")
        img.contentMode = .ScaleAspectFit
        img.layer.cornerRadius = 30
        img.layer.borderWidth = 4
        img.layer.borderColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1).CGColor
        self.view.addSubview(img)
        
        
        let goToShoppingCart = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        goToShoppingCart.addTarget(self, action: #selector(GoodsDetailVC.goToShoppingCartClk), forControlEvents: UIControlEvents.TouchUpInside)
        bottonRightView!.addSubview(goToShoppingCart)
        
        addToCartBtn.addTarget(self, action: #selector(GoodsDetailVC.addToCartBtnClk), forControlEvents: UIControlEvents.TouchUpInside)
        
        bottonRightView!.hidden = false
        
    }
    
    
    func goToShoppingCartClk()  {
        self.tabBarController?.selectedIndex = ((self.tabBarController?.childViewControllers.count)! - 2 )

        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    func addToCartBtnClk() {
        if !onlineState {
            let msg = "无网络连接"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            return
        }
        
        
        
        
        
        let priceID = self.goodsDetailInfoData?.specioptions[selectIndex].merchantkeyid

        if  goodsDetailInfoData?.specioptions[selectIndex].images.count > 0 {
            
        }else{
                let msg = "无对应商品图片，暂时不能添加到购物车"
                self.view.dodo.style.bar.hideAfterDelaySeconds = 1
                self.view.dodo.style.bar.locationTop = false
                self.view.dodo.warning(msg)
                return
        }
        
        
        if (self.goodsDetailInfoData?.specioptions[selectIndex].isbuy) == 0{
          addToShoppingCart((priceID?.description)!, quantity: numOfGoods)
        }else{
            let msg = "不能添加到购物车"
            self.view.dodo.style.bar.hideAfterDelaySeconds = 1
            self.view.dodo.style.bar.locationTop = false
            self.view.dodo.warning(msg)
            
        }
        

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0://规格
            guard self.goodsDetailInfoData?.ex_allSpecificationName() != nil else{
                return 0
            }
            return 1
        case 1://属性
            guard let goodsMoreInfo:[String:String]? =  self.goodsDetailInfoData?.ex_goodsMoreInfo()  else{
                return 0
            }
            
            guard goodsMoreInfo != nil else{
                return 0
            }
            
            
            var keyArry = [String]()
            for (key,value) in goodsMoreInfo! {
                
                
                keyArry.append(key)
            }
            return keyArry.count
        case 2://商家活动
//            guard self.goodsDetailInfoData?.shopActivity != nil else{
//                return 0
//            }
            return 1
        
        
        default://加减按钮
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0://规格
            return 30
        case 1://属性
            return 0
        case 2://商家活动
            return 0
        default://加减按钮
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            return cell01Heigth
        }
        
        if indexPath.section == 1 {//商品属性
            return 30
        }
        
        if indexPath.section == 2 {//商家活动要说的话
//            if let activityInfo = self.goodsDetailInfoData?.shopActivity() {
//                let titleWidth = getTextRectSize(activityInfo, font: UIFont.systemFontOfSize(14), size: CGSize(width: screenWith - 8, height: 300))
//                return titleWidth.height + 6 //(上下各留3个像素)
//            }else{
//                return 0
//            }
            return 0
        }
        
        return 160
    }
    
    
    
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return headerView
        }
        return nil
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //规格展示
        if indexPath.section == 0 {

            let  lableNames = self.goodsDetailInfoData?.ex_allSpecificationName()!
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! GoodsSelectCell
            let rect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: cell01Heigth)
            cell.setSubView(rect, lableNames:lableNames!,selectedIndex: self.selectIndex)
            cell.moreLableShowView?.delegate = self
            cell.backgroundColor = UIColor.whiteColor()
            
            return cell
   
        }else if indexPath.section == 1 {//属性展示
            let cell = tableView.dequeueReusableCellWithIdentifier("GoodsMoreInfoCell") as! GoodsMoreInfoCell
            guard let goodsMoreInfo:[String:String]? =  self.goodsDetailInfoData?.ex_goodsMoreInfo()  else{
                return cell
            }
            
            guard goodsMoreInfo != nil else{
                return cell
            }
            
            var keyArry = [String]()
            var valueArry = [String]()
            
            for (key,value) in goodsMoreInfo! {
                
                
                keyArry.append(key)
                valueArry.append(value)
            }
            
            cell.setForTitle(keyArry[indexPath.row], andDetail: valueArry[indexPath.row])
            return cell
            
        }else if indexPath.section == 2 {//商家活动要说的话
            let cell = tableView.dequeueReusableCellWithIdentifier("ShopActivityCell") as! ShopActivityCell
//            if let activityInfo = self.goodsDetailInfoData?.shopActivity() {
//                cell.activityInfo = activityInfo
//            }
            
            return cell
        }else{//属性展示{//加减按钮
            let cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! AddBtnCell
            cell.selectNumBtn.delegate = self
            cell.selectNumBtn.numValue = self.numOfGoods
            return cell
        }
        
        
    }
    
    
    
    
    //规格cell的高度
    var cell01Heigth = CGFloat(0)
    
    
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


// MARK: - 数量按钮点击
extension GoodsDetailVC:SelectNumBtnDelegate{
    func selectNums(num: Int) {
        self.numOfGoods = num
        
    }
}

// MARK: - 添加商品到购物车
extension GoodsDetailVC{
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
                    print("error")
                }
                
            case .Failure(let error):
                print(error)
            }
            
        }
        
    }
}

extension GoodsDetailVC:MoreLableShowViewDelegate{
    
    
    func didSelectLableIndex(num:Int){//选中了第几个
        
        
        
        
        //选中的规格不一样就刷新界面
        if self.selectIndex != num {
            self.selectIndex = num
            
            if (self.goodsDetailInfoData?.specioptions[selectIndex].isbuy) != 0{
                
                if isMySelfGoods {
                    setBottomViewTemp()
                }else{
                    setBottomViewTemp01()
                }
            }else{
                setBottomViewRepeat()
                
            }
            
            let (goodsName,imgUrlArry,giftInfo,stockCnt,sellCnt,oldPrice,nowPrice,promotionStatus) = (goodsDetailInfoData?.ex_headerInfo(num))!//选中了哪一个规格选中
            
            //设置tableHeaderView
            let (tableHeaderView,_) = setTableViewHeader(goodsName, activity: giftInfo, storeCnt: stockCnt.description, sellCnt: sellCnt.description, nowPriceStr: nowPrice.description, oldPriceStr: oldPrice.description, img: imgUrlArry, promotionFlag: promotionStatus)
            
            self.tableView?.tableHeaderView = tableHeaderView
            
            self.tableView?.reloadData()
            
            
        }
        
    }
    
    func heigthOfThisView(heigth:CGFloat){
        
        //高度不相等就需要重新刷新界面
        if cell01Heigth != heigth{
            cell01Heigth = heigth
            self.tableView?.reloadData()
        }
    }
}


