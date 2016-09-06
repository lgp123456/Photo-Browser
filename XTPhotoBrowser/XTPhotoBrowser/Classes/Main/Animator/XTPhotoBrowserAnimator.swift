//
//  XTPhotoBrowserAnimator.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/20.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit

protocol AnimatorPresentedDelegate : class {
    func startRect(indexPath : NSIndexPath)->CGRect
    func endRect(indexPath : NSIndexPath)->CGRect
    func imageView (indexPath : NSIndexPath)->UIImageView
}

protocol AnimatorDismissedDelegate : class {
    func getCurrentIndexPath() -> NSIndexPath
    func getCurrentImageView() -> UIImageView
}


class XTPhotoBrowserAnimator : NSObject {
    
    var indexPath : NSIndexPath?
    
    var isPresent : Bool = true
    //代理属性
    weak var presentedDelegate : AnimatorPresentedDelegate?
    weak var dismissedDelegate : AnimatorDismissedDelegate?
}

extension XTPhotoBrowserAnimator :  UIViewControllerTransitioningDelegate{
      func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        return self
    }
    
      func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        return self
    }
}



extension XTPhotoBrowserAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        if isPresent {
            
            //判断代理是否有值
            guard let presentedDelegate = presentedDelegate else {
                return
            }
            
            guard let indexPath = indexPath else {
                return
            }
            
            //获取弹出的view
            let presentView = transitionContext.viewForKey(UITransitionContextToViewKey)!
             transitionContext.containerView()?.addSubview(presentView)
            presentView.alpha = 0
            transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
            
            //获取动画需要的元素
            let ImageView = presentedDelegate.imageView(indexPath)
            let startRect = presentedDelegate.startRect(indexPath)
            ImageView.frame = startRect
            transitionContext.containerView()?.addSubview(ImageView)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            
                let endRect = presentedDelegate.endRect(indexPath)
                
                ImageView.frame = endRect
                
            }) { (isFinished:Bool) in
                ImageView.removeFromSuperview()
                presentView.alpha = 1
                transitionContext.containerView()?.backgroundColor = UIColor.clearColor()
                transitionContext.completeTransition(isFinished)
            }
        }else{
            
            // 0.对可选类型进行校验
            guard let dismissedDelegate = dismissedDelegate else {
                return
            }
            
            guard let presentedDelegate = presentedDelegate else {
                return
            }
            
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            dismissView.removeFromSuperview()
            
            let indexPath = dismissedDelegate.getCurrentIndexPath()
            
            
            // 获取UIImageView对象
            let imageView = dismissedDelegate.getCurrentImageView()
            transitionContext.containerView()?.addSubview(imageView)
            
//            // 获取起始位置
//            let startRect = presentedDelegate.endRect(indexPath)
//            imageView.frame = startRect
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
                let endRect = presentedDelegate.startRect(indexPath)
                
                if endRect == CGRectZero{
                     imageView.alpha = 0.0
                }else{
                    imageView.frame = endRect
                }
                
                
                }, completion: { (isFinished : Bool) in
                    
                    transitionContext.completeTransition(isFinished)
            })
        }
    
    }
  
}




