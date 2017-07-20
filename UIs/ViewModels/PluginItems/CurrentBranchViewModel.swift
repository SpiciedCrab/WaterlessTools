//
//  CurrentBranchViewModel.swift
//  Waterless
//
//  Created by Harly on 2017/7/19.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

class CurrentBranchViewModel: CellConfiguratble
{
    required init()
    {
    }
    
    var cellConfiguration : CellConfiguration?
}

extension CurrentBranchViewModel
{
    func configCell()
    {
        guard let config = cellConfiguration else { return }
        config.title = "hahahaha"
    }
}
