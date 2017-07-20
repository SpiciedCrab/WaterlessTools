//
//  BranchesProvider.swift
//  Waterless
//
//  Created by Harly on 2017/7/16.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import LeanCloud

// MARK: - Branch provider(fetcher)
protocol BranchesProvider
{
    /// Fetch all branch
    ///
    /// - Returns: branches
    func fetchAllBranches() -> [Branch]?
    
    
    /// Fetch branch with branchName
    ///
    /// - Parameter branchName: Branch Name
    /// - Returns: branch info
    func fetchBranch(with branchName : String) -> Branch?
}

extension BranchesProvider where Self : LeanCloudObjectable
{
    func fetchAllBranches() -> [Branch]?
    {
        let query = LCQuery(className: "Branch")
        switch query.find() {
        case .success(let branches):
            
            let realBranches : [Branch] = branches.flatMap { normalObject(from: $0) }
            
            return realBranches
            
        case .failure(let error):
            
            print(error)
            
            return nil
        }
    }
    
    func fetchBranch(with branchName : String) -> Branch?
    {
        let query = LCQuery(className: "Branch")
        
        query.whereKey("branchName", .equalTo(branchName))
        
        switch query.getFirst() {
            
        case .success(let branch):
            
            return normalObject(from: branch)
            
        case .failure(let error):
            
            print(error)
            
            return nil
        }
    }
}
