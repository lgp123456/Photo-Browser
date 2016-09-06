//
//  UIButton-Extension.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit

extension UIButton {
    
    class func createBtn (title : String , bgColor : UIColor , font : CGFloat) -> UIButton {
    
        let btn = UIButton()
        btn.setTitle(title, forState: .Normal)
        btn.backgroundColor = bgColor
        btn.titleLabel?.font = UIFont.systemFontOfSize(font)
        
        return btn
    }
   
    convenience init(title : String , bgColor : UIColor , font : CGFloat) {
        self.init()
        setTitle(title, forState: .Normal)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFontOfSize(font)
    }
    
}
