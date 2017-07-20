//
//  CustomNavigationBar.swift
//  TTKG_Merchant
//
//  Created by yd on 16/7/27.
//  Copyright © 2016年 yd. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let  navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.redColor(), forKey: NSForegroundColorAttributeName)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as [NSObject:AnyObject] as? [String : AnyObject]
        
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
