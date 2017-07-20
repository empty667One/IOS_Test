//
//	MoreSelectRootClass.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation



class SlectGoodsByCondition{
    //从商品分类进入的还是从大品牌进入的
    var enterFromClassOrBigBrandFlag = false
    
    
//    AjaxParams params = new AjaxParams();
//    params.put("categoryid", categoryid);// 类别id
    var categoryidTemp = String()
    var  categoryid = String()
    
//    params.put("areaid", areaid);// 区域id
    var  areaid = String()
//    params.put("roleid", roleid);// 角色id
    var  roleid = String()
//    params.put("pageindex", pageindex + "");// 当前页数
    var  pageindex = String()
//    params.put("pagesize", pagesize); //每页页数大小
    var  pagesize = String()
//    params.put("brandid", brandid);// 品牌id
    var  brandidTemp = String()
    var  brandid = String()
//    params.put("carryingamount", carryingamount);// 起配金额
    var  carryingamount = String()
//    params.put("minprice", minprice);//最小价格
    var  minprice = String()
//    params.put("maxprice", maxprice);//最大价格
    var  maxprice = String()
//    params.put("sort", tempSales); //排序 价格（传1） 销量（传0）
    var  sort = String()
//    params.put("asc", tempAsc); //排序，0：升序，1：降序
    var  asc = String()
    
    func setDefaultCondition() {
        self.carryingamount = ""
        self.sort = ""
        self.asc = ""
        self.maxprice = ""
        self.maxprice = ""
        
        //还原默认值
        self.brandid = brandidTemp
        self.categoryid = categoryidTemp
    }
}


extension MoreSelectRootClass{

    //返回用户筛选
    func requestPara()->(brandid:String,carryingamount:String,minprice:String,maxprice:String,sort:String,asc:String) {
        
        requiredGoodsByConditions()
        
        return (self.slectGoodsByCondition.brandid,self.slectGoodsByCondition.carryingamount,self.slectGoodsByCondition.minprice,self.slectGoodsByCondition.maxprice,self.slectGoodsByCondition.sort,self.slectGoodsByCondition.asc)
    }
    
    //筛选结果处理
    func requiredGoodsByConditions()  {
        
        
        if self.condition.count == 3 {
            //1、品牌()
            if self.condition[0].selectedFlag < 1000 {
                let cnt = self.condition[0].selectedFlag
                self.slectGoodsByCondition.brandid = self.brandID[cnt]
            }
            
            //2、起配金额
            var carryingamount = String()
            do {
                let index = self.condition[1].selectedFlag
                switch index {
                case 0:
                    carryingamount = "0"
                case 1:
                    carryingamount = "100"
                case 2:
                    carryingamount = "300"
                case 3:
                    carryingamount = "500"
                default:
                    carryingamount = "0"
                }
            }catch _{
                carryingamount = ""
            }
            self.slectGoodsByCondition.carryingamount = carryingamount
            
            //3、价格区间
            var minprice = String()
            var maxprice = String()
            
            let index = self.condition[2].selectedFlag
            switch index {
            case 0:
                minprice = "0"
                maxprice = "20"
            case 1:
                minprice = "20"
                maxprice = "100"
            case 2:
                minprice = "100"
                maxprice = "200"
            case 3:
                minprice = "200"
                maxprice = "2000"
            default:
                minprice = ""
                maxprice = ""
            }
            
            
            self.slectGoodsByCondition.minprice = minprice
            self.slectGoodsByCondition.maxprice = maxprice
        }
        
        
        
        
        
        
        
        //升序或降序或默认
        var upOrDownSort = String()
        if self.sort == "sortDown" {
            upOrDownSort = "1"
        }else if "sortUp" == self.sort{
            upOrDownSort = "0"
        }else{
            upOrDownSort = ""
        }
        
        self.slectGoodsByCondition.asc = upOrDownSort
        
        //按价格或销量排序
        var sellCntOrPrice = String()
        switch sortName {
        case "综合":
            sellCntOrPrice = ""
            upOrDownSort = ""
            self.slectGoodsByCondition.sort = ""
            self.slectGoodsByCondition.asc = ""
            
        case "销量":
            self.slectGoodsByCondition.sort = "0"
        case "价格":
            self.slectGoodsByCondition.sort = "1"
        default:
            self.slectGoodsByCondition.asc = ""
        }
        
        
        
    }
}

class MoreSelectRootClass{

    //大品牌ID数组
    var brandID = [String]()
    
	var condition = [MoreSelectCondition]()
	var sort = String()
	var sortName = String()
    
    
    //筛选模型
    var slectGoodsByCondition = SlectGoodsByCondition()

    init(condition:[MoreSelectCondition]){
        self.condition = condition
        
    }
    
    
    init(){
        
    }
    



}