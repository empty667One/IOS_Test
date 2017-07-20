//
//  MoreLableShowView.swift
//  CLLoopScrollView
//
//  Created by iosnull on 16/6/20.
//  Copyright © 2016年 ChrisLian. All rights reserved.
//


//用于多标签展示内容
/// 首先回顾一下Collection View的构成，我们能看到的有三个部分：
/*
 Cells
 Supplementary Views 追加视图 （类似Header或者Footer）
 Decoration Views 装饰视图 （用作背景展示）
 */
import UIKit

protocol MoreLableShowViewDelegate{
    func didSelectLableIndex(num:Int)//选中了第几个
    func heigthOfThisView(heigth:CGFloat)
}

class MoreLableShowView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LayOutForGoodsClassDelegate {
    
    var delegate:MoreLableShowViewDelegate?
    
    internal let widths = UIScreen.mainScreen().bounds.width
    internal let heights = UIScreen.mainScreen().bounds.height
    
    //圆角直径
    var cornerRadius = CGFloat(8)
    //文字大小
    var titleFont = CGFloat(14)
    
    private var colltionView:UICollectionView?
    
    var dataArr = [String]()
        {
        didSet{
            self.colltionView?.reloadData()
        }
    }
    
    //标记选中
    var selectedIndex:Int? {
        didSet{
            //self.colltionView?.reloadData()
            self.delegate?.didSelectLableIndex(selectedIndex!)
        }
    }
    
    
    
    /**
     Description
     
     - parameter frame:         frame description
     - parameter lableNames:    lableNames description
     - parameter selectedIndex: selectedIndex description
     
     - returns: return value description
     */
    convenience  init(frame: CGRect,lableNames:[String],selectedIndex:Int?) {
        
        self.init(frame: frame)
        
        //设置需要显示的标签数组
        self.dataArr = lableNames
        
        //初始化collectionView
        initSub(frame)
        
        
        
        self.backgroundColor = UIColor.clearColor()
        self.colltionView?.scrollEnabled = false
        
        //最大值为10000状态下不选中cell
        if selectedIndex < 100 {
            self.selectedIndex = selectedIndex
        }
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var layout:LayOutForGoodsClass!
    
    func initSub(frame: CGRect)  {
        //布局对象
        layout  = LayOutForGoodsClass(lablesArr: dataArr)
        layout.delegate = self
        //初始化colltionView
        colltionView = UICollectionView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height), collectionViewLayout: layout)
        //注册一个cell
        colltionView!.registerClass(Home_Cell.self, forCellWithReuseIdentifier:"cell")
        //注册一个headView
        colltionView!.registerClass(Home_HeadView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        //添加数据源和代理
        colltionView?.delegate = self;
        colltionView?.dataSource = self;
        
        //设置背景
        colltionView?.backgroundColor = UIColor.clearColor()
        //设置每一个cell的宽高
        //layout.itemSize = CGSizeMake((width-30)/2, 45)
        self.addSubview(colltionView!)
        
    }
    
    
    //返回多少个组
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    //返回多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    //返回自定义的cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! Home_Cell
        
        cell.layer.borderWidth = 0.1;
        cell.layer.cornerRadius = cornerRadius
        cell.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.titleLabel?.text = dataArr[indexPath.row]
        cell.titleLabel?.font = UIFont.boldSystemFontOfSize(titleFont)
        
        guard selectedIndex != nil else{
            return cell
        }
        //设置背景
        if selectedIndex == indexPath.row {
            cell.backgroundColor = UIColor(red: 231/255, green: 31/255, blue: 24/255, alpha: 1)
            cell.titleLabel?.textColor = UIColor.whiteColor()
        }else{
            cell.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
            cell.titleLabel?.textColor = UIColor.blackColor()
        }
        return cell
    }
    
    
    //返回该view的占用高度
    func heigthOfSection(allRow: Int) {
        
        let h = 30 //每一个cell高度
        
        let height = CGFloat(h*allRow +  (allRow+1)*10)
        self.frame.size.height = height
        
        self.colltionView?.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        delegate?.heigthOfThisView(self.frame.size.height)
    }
    
    //点击了哪一个标签
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        //触发
        selectedIndex = indexPath.row
        
    }
    
    
    
    
//    override func layoutSubviews() {
//        
//    }
    
    
    
    
}

class Home_Cell: UICollectionViewCell {
    
    
    var titleLabel:UILabel?//cell上title
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        titleLabel = UILabel(frame: frame)
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.boldSystemFontOfSize(14.0)
        titleLabel?.textColor = UIColor.lightGrayColor()
        titleLabel?.textAlignment = NSTextAlignment.Center
        self .addSubview(titleLabel!)
    }
    
    
    convenience  init(frame: CGRect,title:String) {
        self.init(frame:frame)
        titleLabel?.text = title
    }
    
    override func layoutSubviews() {
        
        titleLabel?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class Home_HeadView:UICollectionReusableView{
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes){
        
    }
}


protocol LayOutForGoodsClassDelegate {
    func heigthOfSection(numOfRow:Int)
}

//布局类
class LayOutForGoodsClass: UICollectionViewFlowLayout {
    
    //获取布局高度
    func getMapInfo() -> Double {
        
        return Double()
    }
    
    override init() {
        super.init()
    }
    
    var delegate:LayOutForGoodsClassDelegate?
    
    convenience init(lablesArr:[String]) {
        self.init()
        dataArr = lablesArr
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //cell数量
    private var _cellCount:Int?
    //cell尺寸
    private var _collectSize:CGSize?
    //cell位置
    private var _center:CGPoint?
    private var _radius:CGFloat?
    
    //一般在该方法中设定一些必要的layout的结构和初始需要的参数等
    override func prepareLayout() {
        super.prepareLayout()
        _collectSize = self.collectionView?.frame.size
        _cellCount = self.collectionView?.numberOfItemsInSection(0)
        _center = CGPointMake(_collectSize!.width / 2.0, _collectSize!.height / 2.0);
        _radius = min(_collectSize!.width, _collectSize!.height)/2.5
        
        //先判断数组一定有内容
        guard dataArr.count > 0 else{
            return
        }
        
        let (_,_,row) = centerForCell(dataArr.count-1, names: dataArr)
        delegate?.heigthOfSection(row)
    }
    
    //内容区域的总大小 （不是可见区域）
    override func collectionViewContentSize() -> CGSize {
        _collectSize?.height += 20
        return _collectSize!   //这里不用可见区域吧
    }
    
    //可见区域
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attributesArray = [UICollectionViewLayoutAttributes]()
        if let count = self._cellCount {
            for i in 0 ..< count{
                //这里利用了-layoutAttributesForItemAtIndexPath:来获取attributes
                let indexPath = NSIndexPath(forItem: i, inSection: 0)
                let attributes =  self.layoutAttributesForItemAtIndexPath(indexPath)
                attributesArray.append(attributes!)
            }
        }
        return attributesArray
    }
    
    
    var dataArr = [String]()
    
    //获取字符串宽高
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
    
    //返回字符串宽度
    func widthOfAllStr(names:[String]) -> [CGFloat] {
        var widthArr = [CGFloat]()
        
        for item in names {
            let rect = getTextRectSize(item, font: UIFont.systemFontOfSize(17), size: CGSize(width: 800, height: 25))
            widthArr.append(rect.width)
        }
        
        return widthArr
    }
    
    
    private var allRow = 1
    
    //根据标签数组返回排版后所有的行号，中心点，每一个cell的坐标
    func centerForCell(allCnt:Int,names:[String]) -> (CGPoint,[CGFloat],allRow:Int) {
        
        let widthArr = widthOfAllStr(names)
        
        var center:CGPoint = CGPointMake(50, 20)
        
        
        
        for var i = 0 ; i <= allCnt ;   {
            
            if i == 0 {
                center.x = widthArr[i]/2 + lineSpace
                center.y = 25
                
            }else{
                //在当前行后面进行布局
                let a = width - widthArr[i] - lineSpace //除去最右边行间距10
                let b = center.x + widthArr[i-1]/2 + lineSpace //加上cell末端行间距
                if a - b > lineSpace  {//宽度够用
                    center.x += (widthArr[i-1]/2 + widthArr[i]/2) + lineSpace
                    
                }else{//换一行进行布局
                    center.y += (30) + lineSpace
                    center.x = widthArr[i]/2 + lineSpace
                    
                    allRow += 1 //行号加一
                }
                
            }
            i+=1
        }
        
        return (center,widthArr,allRow)
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        let (center,size,_) = centerForCell(indexPath.row, names: dataArr)
        
        
        attrs.center = center
        attrs.size = CGSize(width: size[indexPath.row] , height: 30)
        
        
        return attrs
    }
    
    
    /**
     返回true只要显示的边界发生改变就重新布局:(默认是false)
     内部会重新调用prepareLayout和调用
     layoutAttributesForElementsInRect方法获得部分cell的布局属性
     */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    private let width = UIScreen.mainScreen().bounds.width
    private let height = UIScreen.mainScreen().bounds.height
    private let lineSpace = CGFloat(10) //cell行间距
    
}









// MARK: - 获取该标签需要的rect
extension UILabel {
    
    private func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        
        return rect;
    }
    
    func getSelfTextNeededRectSize() ->CGRect? {
        guard self.text != nil else{
            return nil
        }
        return getTextRectSize(self.text!, font: self.font, size: CGSize(width: self.frame.width, height: self.frame.height))
    }
}


