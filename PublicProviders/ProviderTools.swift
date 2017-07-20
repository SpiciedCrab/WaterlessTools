//
//  ProviderTools.swift
//  Waterless
//
//  Created by Harly on 2017/7/18.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

// MARK: - URLResponse转化Branch
protocol URLBranchConvertiable
{
    /// 通过URL获取分支名
    ///
    /// - Parameter urlResponse: HTTPURLResponse
    /// - Returns: branch name
    func branchNameInURL(urlResponse : HTTPURLResponse) -> String
}

extension URLBranchConvertiable
{
    func branchNameInURL(urlResponse : HTTPURLResponse) -> String
    {
        let branchHeaders = urlResponse.allHeaderFields as! [String : Any]
        let branchName = branchHeaders[WaterlessConsts.appBranchKey] as? String
        return branchName ?? ""
    }
}
