//
//  CustomTabBar.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/27.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {

    let vc1 = HomeVC()
    let vc2 = ClassifyVC()
    let vc3 = GoodsCarVC()
    let vc4 = PersonCenterVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: vc1)
        let nvc2 : UINavigationController = CustomNavigationBar(rootViewController: vc2)
        let nvc3 : UINavigationController = CustomNavigationBar(rootViewController: vc3)
        let nvc4 : UINavigationController = CustomNavigationBar(rootViewController: vc4)
        
        
        let tabBar1 = UITabBarItem(title: "首页", image: (Pubilc.getImageView("home")), selectedImage: (Pubilc.getImageView("home_selected")))
        let tabBar2 = UITabBarItem(title: "分类", image: (Pubilc.getImageView("classify")), selectedImage:(Pubilc.getImageView("classify_select")))
        let tabBar3 = UITabBarItem(title: "进货单", image: (Pubilc.getImageView("goodscar")), selectedImage: (Pubilc.getImageView("goodscar_selected")))
        let tabBar4 = UITabBarItem(title: "我的", image: (Pubilc.getImageView("person")), selectedImage: (Pubilc.getImageView("person_select")))
        
        
        nvc1.tabBarItem = tabBar1
        nvc2.tabBarItem = tabBar2
        nvc3.tabBarItem = tabBar3
        nvc4.tabBarItem = tabBar4
        
        
        
        
        self.tabBar.tintColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1.0)
        self.viewControllers = [nvc1,nvc2,nvc3,nvc4]
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}



class CustomTabBarPeiSong: UITabBarController {
    
    let vc1 = HomeVC()
    let vc2 = ClassifyVC()
    let vc3 = MySelfShopVC()
    
    let vc4 = GoodsCarVC()
    let vc5 = PersonCenterVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nvc1 : UINavigationController = CustomNavigationBar(rootViewController: vc1)
        let nvc2 : UINavigationController = CustomNavigationBar(rootViewController: vc2)
        let nvc3 : UINavigationController = CustomNavigationBar(rootViewController: vc3)
        let nvc4 : UINavigationController = CustomNavigationBar(rootViewController: vc4)
        let nvc5 : UINavigationController = CustomNavigationBar(rootViewController: vc5)
        
        
        let tabBar1 = UITabBarItem(title: "首页", image: (Pubilc.getImageView("home")), selectedImage: (Pubilc.getImageView("home_selected")))
        let tabBar2 = UITabBarItem(title: "分类", image: (Pubilc.getImageView("classify")), selectedImage:(Pubilc.getImageView("classify_select")))
        
        let tabBar3 = UITabBarItem(title: "本店", image: (Pubilc.getImageView("mySelfShopNotSel")), selectedImage: (Pubilc.getImageView("mySelfShopSel")))
        
        let tabBar4 = UITabBarItem(title: "进货单", image: (Pubilc.getImageView("goodscar")), selectedImage: (Pubilc.getImageView("goodscar_selected")))
        let tabBar5 = UITabBarItem(title: "我的", image: (Pubilc.getImageView("person")), selectedImage: (Pubilc.getImageView("person_select")))
        
        
        nvc1.tabBarItem = tabBar1
        nvc2.tabBarItem = tabBar2
        nvc3.tabBarItem = tabBar3
        nvc4.tabBarItem = tabBar4
        nvc5.tabBarItem = tabBar5
        
        self.tabBar.tintColor = UIColor(red: 17/255, green: 182/255, blue: 244/255, alpha: 1.0)
        self.viewControllers = [nvc1,nvc2,nvc3,nvc4,nvc5]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
