//
//  XTNetWorkTools.swift
//  XTPhotoBrowser
//
//  Created by 李贵鹏 on 16/8/16.
//  Copyright © 2016年 李贵鹏. All rights reserved.
//

import UIKit
import AFNetworking

enum Type {
    case get
    case post
}

class XTNetWorkTools: AFHTTPSessionManager {

    static let shareInstance : XTNetWorkTools = {
        let tools = XTNetWorkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
}

extension XTNetWorkTools {
    
    func loadData(type : Type , urlString : String , parameters : [NSString : NSObject] , callBack : (result : AnyObject? , error : NSError?)->()){
        
        //定义成功之后的回调  (闭包属性)
        let successCallBack = { (task :NSURLSessionDataTask, result : AnyObject?) in
            callBack(result: result, error: nil)
        }
        
        //定义失败的回调
        let failureCallback = { (task : NSURLSessionDataTask?, error : NSError) in
            callBack(result: nil, error: error)
        }
        
    
        if type == .post {
    
            POST(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallback)

        }else{
            
            GET(urlString, parameters: parameters, progress: nil, success: successCallBack, failure:failureCallback)
            
        }
    
    }


}