//
//  BranchService.swift
//  Waterless
//
//  Created by Harly on 2017/7/18.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

protocol BranchServable {
    
    /// 当前分支
    var currentBranch : Branch? { get set }
    
    /// 观察分支变化
    ///
    /// - Parameter urlResponse: urlresponse
    /// - Returns: 是否存在
    func watch(urlResponse : HTTPURLResponse) -> Bool
    
    
    /// 修改分支
    ///
    /// - Parameter branch: branch
    /// - Returns: 是否成功
    func modify(branch : Branch) -> Bool
    
    
    /// 获取branch名字
    ///
    /// - Parameter response: response
    /// - Returns: 名字
    func branchName(on response : HTTPURLResponse) -> String
}

class BranchService : BranchServable , CurrentBranchProvider , BranchesOperator , URLBranchConvertiable, LeanCloudObjectable
{
    var currentBranch : Branch?
    
    func watch(urlResponse : HTTPURLResponse) -> Bool
    {
        return watchCurrentBranch(with: branchName(on: urlResponse))
    }
    
    func modify(branch : Branch) -> Bool
    {
        return save(branch: branch)
    }
    
    func branchName(on response : HTTPURLResponse) -> String
    {
        return branchNameInURL(urlResponse: response)
    }
}
