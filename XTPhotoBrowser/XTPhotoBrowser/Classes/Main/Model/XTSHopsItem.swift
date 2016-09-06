//
//  XTSHopsItem.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit

class XTSHopsItem: NSObject {

    var z_pic_url = ""
    var q_pic_url = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
