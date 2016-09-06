//
//  XTHomeViewCell.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit
import SDWebImage

class XTHomeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    var shopItem : XTSHopsItem? {
        didSet{
            guard let shopItem = shopItem else {
                
                return
            }
            
            let url = NSURL(string: shopItem.q_pic_url)
         
            imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named:"empty_picture"))
        }
        
    }
    
}
