//
//  XTPhotoBrowserViewCell.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/20.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit
import SDWebImage

class XTPhotoBrowserViewCell: UICollectionViewCell {
    // MARK:- 懒加载控件
     lazy var imageView : UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item : XTSHopsItem? {
        didSet{
            guard let item = item else{
                return
            }
            
            //获取小图
            var smallImage = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(item.q_pic_url)
            
            if smallImage == nil {
                smallImage = UIImage(named: "empty_picture")
            }

            // 3.根据image计算出来放大之后的frame
            imageView.frame = calculateFrameWithImage(smallImage)
            // 4.设置图片
            let url = NSURL(string: item.z_pic_url)
            imageView.sd_setImageWithURL(url, placeholderImage: smallImage) { (image : UIImage!, error : NSError!,  type : SDImageCacheType,  url : NSURL!) in
                self.imageView.frame = calculateFrameWithImage(image)
            }
        }
    }
}
