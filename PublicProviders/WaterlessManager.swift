//
//  WaterlessManager.swift
//  Waterless
//
//  Created by Harly on 2017/7/16.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import LeanCloud

/// Public funcs
public protocol ManagerOpened
{
    /// manager是否正在运行
    ///
    /// - Returns: aaa
    func isWorking() -> Bool
    
    /// 注册调用，不调就不鸟你
    func startWorking()
    
    /// 注册调用，不调就不鸟你
    func stopWorking()
    
    
    /// 在网络请求返回中调用这个
    ///
    /// - Parameter urlResponse: Response inf
    func watch(urlResponse : HTTPURLResponse)
}

/// Manager Provider
public final class WaterlessManager : NSObject
{
    /// shared
    static public let sharedManager : WaterlessManager = WaterlessManager()
    
    //正在运行
    fileprivate var isManagerWorking : Bool = false
    
    fileprivate let branchService : BranchServable = BranchService()

    
}

extension WaterlessManager : ManagerOpened , WaterlessNavigatable
{
    public func startWorking()
    {
        LeanCloud.initialize(applicationID: "PLOb7P25JX4D90BDKv6uiWfc-gzGzoHsz", applicationKey: "dk69G3svHSOkoPp96SNJ3Es0")
        
        isManagerWorking = true
    }
    
    public func stopWorking()
    {
        isManagerWorking = false
    }
    
    public func isWorking() -> Bool
    {
        return isManagerWorking
    }
    
    public func watch(urlResponse : HTTPURLResponse)
    {
        guard isManagerWorking else { return }
        guard !branchService.watch(urlResponse: urlResponse) else { return }
        
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else
        {
            return
        }
        
        
        let branchName = branchService.branchName(on: urlResponse)
        
        let cancelAction = UIAlertAction(title: "我不", style: .cancel) { (action) in
            
        }
        
        let confirmAction = UIAlertAction(title: "好吧我登记就是了", style: .default) { (action) in
            self.navigateToWaterless()
        }
        
        let alertVc = UIAlertController(title: "当前分支是个黑户口啊", message: "\(branchName)", preferredStyle: .alert)
        
        alertVc.addAction(cancelAction)
        
        alertVc.addAction(confirmAction)
        
        rootController.pushViewController(alertVc, animated: true)
    }

}
