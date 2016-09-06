//
//  AppDelegate.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

// MARK:- 根据image计算放大之后的frame
func calculateFrameWithImage(image : UIImage) -> CGRect {
    // 1.取出屏幕的宽度和高度
    let screenW = UIScreen.mainScreen().bounds.width
    let screenH = UIScreen.mainScreen().bounds.height
    
    // 2.计算imageView的frame
    let w = screenW
    let h = screenW / image.size.width * image.size.height
    let x : CGFloat = 0
    let y : CGFloat = (screenH - h) * 0.5
    
    return CGRect(x: x, y: y, width: w, height: h)
}