//
//  Shakeable.swift
//  TTKGC
//
//  Created by iosnull on 16/6/12.
//  Copyright © 2016年 iosnull. All rights reserved.
//

//  Shakeable.swift

import UIKit

protocol Shakeable {
    
    
    
}

// 你可以只为 UIView 添加 shake 方法！
extension Shakeable where Self: UIView {
    // shake 方法的默认实现
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 15
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x - 4.0, self.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x + 4.0, self.center.y))
        layer.addAnimation(animation, forKey: "position")
    }
}




extension UITableView {
    func tableViewDisplayWitMsg( message:String, rowCount:Int)
    {
        if (rowCount == 0) {
            // Display a message when the table is empty
            // 没有数据的时候，UILabel的显示样式
            let messageLabel:UILabel = UILabel()
            
            messageLabel.text = message;
            //messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
            messageLabel.textColor = UIColor.lightGrayColor()//[UIColor lightGrayColor];
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.sizeToFit()
            
            self.backgroundView = messageLabel;
            self.separatorStyle = UITableViewCellSeparatorStyle.None;
        } else {
            self.backgroundView = nil;
            self.separatorStyle = UITableViewCellSeparatorStyle.SingleLine;
        }
    }
}




//+(UIImage*) createImageWithColor:(UIColor*) color
//{
//    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
//}


extension UIImage {
    class func createImageWithColor(color:UIColor) -> UIImage {
        let rect=CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return theImage
        
    }
}




