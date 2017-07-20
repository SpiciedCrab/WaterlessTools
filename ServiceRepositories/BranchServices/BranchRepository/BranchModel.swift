//
//  BranchModel.swift
//  Waterless
//
//  Created by Harly on 2017/7/16.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import LeanCloud

class Branch : NSObject
{
    var objectId : String?
    
    var branchName : String = ""
    
    var branchTimeStamp : String = ""
    
    var developer : String = ""
    
    var releaseDate : String?
    
    var comment : String?
}
