//
//  XTPhotoBrowserViewController.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit
import SDWebImage

private let ID = "PhotoBrowserCellID"

class XTPhotoBrowserViewController: UIViewController {
    
    var indexPath : NSIndexPath?
    
     var collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: XTPhotoLayout())
    
    var shopsArray : [XTSHopsItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0.让控制器的View的宽度 + 15
        view.frame.size.width += 15
        
        view.backgroundColor = UIColor.blueColor()
        setupUi()
        
        //滚动到正确的位置
        collectionView.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: false)
    }
    
}

// MARK:- 设置ui界面
extension XTPhotoBrowserViewController {
    func setupUi(){
        setupCollectionView()
        setupTwoButton()
    }
    
    private func setupCollectionView() {
        //创建collectionView
       collectionView.frame = view.bounds
        //注册cell
        collectionView.registerClass(XTPhotoBrowserViewCell.self, forCellWithReuseIdentifier: ID)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    
    private func setupTwoButton() {
        //创建按钮
        let closeBtn = UIButton(title: "关 闭", bgColor:UIColor.darkGrayColor(), font: 17)
        let saveBtn = UIButton(title: "保 存", bgColor:UIColor.darkGrayColor(), font: 17)
        //把按钮添加到View上
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
 
        // 设置btn的frame
        let btnW : CGFloat = 90
        let btnH : CGFloat = 35
        let margin : CGFloat = 30
        
        let closeBtnX = margin
        let BtnY = UIScreen.mainScreen().bounds.height - btnH - margin
        closeBtn.frame = CGRect(x: closeBtnX, y: BtnY, width: btnW, height: btnH)
        
        let saveBtnX = UIScreen.mainScreen().bounds.width - btnW - margin
        saveBtn.frame = CGRect(x: saveBtnX, y: BtnY, width: btnW, height: btnH)
        
        //监听按钮点击
        closeBtn.addTarget(self, action: #selector(XTPhotoBrowserViewController.closeBtnClick), forControlEvents: .TouchUpInside)
        saveBtn.addTarget(self, action: #selector(XTPhotoBrowserViewController.saveBtnClick), forControlEvents: .TouchUpInside)
    }
}

// MARK:- 监听按钮点击
extension XTPhotoBrowserViewController {
    @objc private func closeBtnClick(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func saveBtnClick(){
    
        let cell = collectionView.visibleCells()[0]  as! XTPhotoBrowserViewCell
        
        guard let image = cell.imageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
}

// MARK:- 数据源方法
extension XTPhotoBrowserViewController : UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopsArray?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath) as! XTPhotoBrowserViewCell
        
        let item = shopsArray![indexPath.item]
        
        cell.item = item
        

        return cell
    }
}

// MARK:- UICollectionView的代理方法
extension XTPhotoBrowserViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        closeBtnClick()
    }
}

extension XTPhotoBrowserViewController : AnimatorDismissedDelegate {
    
    func getCurrentIndexPath() -> NSIndexPath {
        
        // 1.获取在屏幕中显示的cell
        let cell = collectionView.visibleCells()[0]
        
        // 2.获取cell对应的indexPath
        let indexPath = collectionView.indexPathForCell(cell)!
        
        return indexPath
    }
    
    func getCurrentImageView() -> UIImageView {
        // 1.创建UIImageView
        let imageView = UIImageView()
        
        // 2.设置imageView属性
        let cell = collectionView.visibleCells()[0] as! XTPhotoBrowserViewCell
        imageView.image = cell.imageView.image
        imageView.frame = calculateFrameWithImage(imageView.image!)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
}
