//
//  XTPhotoLayout.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit

class XTPhotoLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
//        let magin : CGFloat = 10
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        scrollDirection = .Horizontal
        
        itemSize = (collectionView?.bounds.size)!
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
        
    }
    
}
