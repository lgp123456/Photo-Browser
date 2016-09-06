//
//  XTHomeLayout.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit

class XTHomeLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        super.prepareLayout()
        
        let magin : CGFloat = 10
        let cols : CGFloat = 3
        
        let itemWH = (UIScreen.mainScreen().bounds.width - (cols + 1) * magin) / cols
        
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = magin
        minimumInteritemSpacing = 0
        
        collectionView?.contentInset = UIEdgeInsets(top: magin + 64, left: magin, bottom: magin, right: magin)
    }
    
    
}
