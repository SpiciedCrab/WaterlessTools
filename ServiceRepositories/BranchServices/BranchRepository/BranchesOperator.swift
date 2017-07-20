//
//  BranchesOperator.swift
//  Waterless
//
//  Created by Harly on 2017/7/18.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import LeanCloud

// MARK: - Branch operator(存储／删除等)
protocol BranchesOperator
{
    /// 存储／更新branch
    ///
    /// - Parameter branch: branch
    /// - Returns: 操作是否正确
    func save(branch : Branch) -> Bool
}

extension BranchesOperator where Self : LeanCloudObjectable
{
    func save(branch : Branch) -> Bool
    {
        let cloudObj = lcObject(from: branch, on: branch.description, with: branch.objectId)
        
        guard let realObj = cloudObj else { return false }
        
        let saveResult = realObj.save()
        
        switch saveResult {
            
        case .success:
            return true
            
        case .failure(let error):
            print(error)
            return false
        }
    }
}
