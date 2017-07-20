//
//  CurrentBranchProvider.swift
//  Waterless
//
//  Created by Harly on 2017/7/16.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

// MARK: - 当前分支处理
protocol CurrentBranchProvider : class , BranchesProvider
{
    /// 当前分支
    var currentBranch : Branch? { get set }
    
    
    /// 观察当前分支
    ///
    /// - Parameter branchName: branchName
    /// - Returns: 是否存在
    func watchCurrentBranch(with branchName : String) -> Bool
    
    /// 获取当前分支
    ///
    /// - Parameter branchName: branchName
    /// - Returns: 分支
    func fetchCurrentBranchInfo(with branchName : String) -> Branch?
}

extension CurrentBranchProvider
{
    func fetchCurrentBranchInfo(with branchName : String) -> Branch?
    {
        if let current = currentBranch
        {
            if current.branchName == branchName
            {
                return current
            }
        }
        
        return fetchBranch(with: branchName)
    }
    
    func watchCurrentBranch(with branchName : String) -> Bool
    {
        currentBranch = fetchCurrentBranchInfo(with : branchName)
        
        return currentBranch == nil
    }
}


