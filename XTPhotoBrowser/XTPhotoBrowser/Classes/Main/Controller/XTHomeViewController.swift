//
//  XTHomeViewController.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit

private let homeID = "cell"

class XTHomeViewController: UICollectionViewController {
    
    private lazy var shopsArray = [XTSHopsItem]()
    
     private lazy var animator : XTPhotoBrowserAnimator = XTPhotoBrowserAnimator()
    
    override func viewDidLoad() {
        loadHomeData(0)
    }
    
}

// MARK:- 发送网络请求
extension XTHomeViewController {
    private func loadHomeData(offset : Int){
        
        let urlString = "http://mobapi.meilishuo.com/2.0/twitter/popular.json"
        
        let parameters = ["offset" : "\(offset)",
                          "limit" : "30",
                          "access_token" : "b92e0c6fd3ca919d3e7547d446d9a8c2"]
        
        XTNetWorkTools.shareInstance.loadData(.get, urlString: urlString, parameters: parameters) { (result, error) in
            if error != nil {
                print(error)
                return
            }
        // result?.writeToFile("/Users/liguipeng/Desktop/123.plist", atomically: true)
            
            guard let resDict = result as? [String : NSObject] else {
                return
            }
            
            guard let shopsArray = resDict["data"] as? [[String : NSObject]] else{
                return
            }
            
            //字典转模型
            for dict in shopsArray {
               self.shopsArray.append(XTSHopsItem(dict: dict))
            }
     
            //刷新数据
            self.collectionView?.reloadData()
        }
    }
}

// MARK:- 数据源方法
extension XTHomeViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopsArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(homeID, forIndexPath: indexPath) as! XTHomeViewCell

        cell.shopItem = shopsArray[indexPath.item]
        
        if indexPath.item == shopsArray.count - 1 {
            loadHomeData(shopsArray.count)
        }
        return cell
    }
}

// MARK:- 代理方法
extension XTHomeViewController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       let vc = XTPhotoBrowserViewController()
//        vc.modalTransitionStyle = .FlipHorizontal
        vc.transitioningDelegate = animator
        vc.modalPresentationStyle = .Custom
        vc.indexPath = indexPath;
        vc.shopsArray = shopsArray
        
        animator.indexPath = indexPath
        animator.presentedDelegate = self
        animator.dismissedDelegate = vc
            
        presentViewController(vc, animated: true, completion: nil)
    }
}

extension XTHomeViewController : AnimatorPresentedDelegate {
    
    func startRect(indexPath: NSIndexPath) -> CGRect {
        
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else {
            return CGRectZero
        }
        
        let cellFrame  = cell.frame
        
        let startRect = collectionView!.convertRect(cellFrame, toView: UIApplication.sharedApplication().keyWindow!)
//        let startRect = self.view.convertRect(cellFrame, toView: UIApplication.sharedApplication().keyWindow!)
        
        return startRect
    }
    
    
    func endRect(indexPath: NSIndexPath) -> CGRect {
        // 1.获取cell
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? XTHomeViewCell else {
            return CGRectZero
        }
        
        // 2.获取image
        guard let image = cell.imageView.image else {
            return CGRectZero
        }
        
        // 3.计算image放大之后的frame
        return calculateFrameWithImage(image)
    }
    
    
    func imageView(indexPath: NSIndexPath) -> UIImageView {
        // 0.创建UIImageView对象
        let imageView = UIImageView()
        
        // 1.获取cell
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? XTHomeViewCell else {
            return imageView
        }
        
        // 2.获取image
        guard let image = cell.imageView.image else {
            return imageView
        }
        
        
        // 3.设置imageView的属性
        imageView.image = image
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    
    
}
