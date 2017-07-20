//
//  ConfigurationProvider.swift
//  Waterless
//
//  Created by Harly on 2017/7/19.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

// MARK: - Plist转化
protocol PlistConvertiable
{
    func model<Element : BaseConfig>(from  plistName : String) -> [Element]?
}

extension PlistConvertiable
{
    func model<Element : BaseConfig>(from  plistName : String) -> [Element]?
    {
        guard let path = Bundle.main.path(forResource: plistName, ofType:"plist") else
        {
            return nil
        }
        
        guard let configs = NSArray(contentsOfFile:path) else
        {
            return nil
        }
        
        guard let realModels = configs as? [[String : Any]] else
        {
            return nil
        }
        
        return realModels.map { Element(with: $0) }
        
    }
}


