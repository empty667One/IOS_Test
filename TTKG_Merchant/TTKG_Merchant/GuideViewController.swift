//
//  GuideViewController.swift
//  ttkg_customer
//
//  Created by yd on 16/7/19.
//  Copyright © 2016年 iosnull. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {
    
     var pageControl: UIPageControl!
    
     var startButton: UIButton!

    private var scrollView : UIScrollView!
    
    private let numOfPages = 3
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: frame)
        scrollView.pagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        
        scrollView.contentSize = CGSize(width: frame.size.width*CGFloat(numOfPages), height: frame.size.height)
        scrollView.delegate = self
        
        for index in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "GuideImage\(index + 1)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
            
        }
        
        pageControl = UIPageControl(frame: CGRect(x: frame.size.width/3, y: frame.size.height*(15/16), width: frame.size.width/3, height: frame.size.height/16))
        pageControl.numberOfPages = numOfPages
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.redColor()
        self.view.addSubview(pageControl)
        
        startButton = UIButton(frame: CGRect(x: frame.size.width/3, y: frame.size.height*(7/8), width: frame.size.width/3, height: frame.size.height/16))
        startButton.setTitle("立即体验", forState: UIControlState.Normal)
        startButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        startButton.addTarget(self, action: #selector(GuideViewController.notifyControllerVC), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(startButton)
        
        self.view.insertSubview(scrollView, atIndex: 0)
        
        // 给开始按钮设置圆角
        startButton.layer.cornerRadius = 15.0
        // 隐藏开始按钮
        startButton.alpha = 0.0
    }
    
    // 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension GuideViewController : UIScrollViewDelegate{
    
    func notifyControllerVC() {
        NSNotificationCenter.defaultCenter().postNotificationName("notifyControllerVC", object: nil)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animateWithDuration(0.5) {
                self.startButton.alpha = 1.0
            }
        } else {
            UIView.animateWithDuration(0.2) {
                self.startButton.alpha = 0.0
            }
        }
    }
}





