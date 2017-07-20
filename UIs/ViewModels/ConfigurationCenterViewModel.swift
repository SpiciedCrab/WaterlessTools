//
//  ConfigurationCenterViewModel.swift
//  Waterless
//
//  Created by Harly on 2017/7/19.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

// MARK: - 主ViewModel对外暴露
protocol ViewModelConfigurable
{
    var configViewModels : [ItemConfiguration] { get set }
    
    func configPluginItems()
    
}

// MARK: - 主ViewModel
class ConfigurationCenterViewModel
{
    var configViewModels : [ItemConfiguration] = [ItemConfiguration]()
}

extension ConfigurationCenterViewModel : ViewModelConfigurable , ViewModelConveniable , PlistConvertiable
{
    func configPluginItems()
    {
        guard let items : [ItemConfiguration] = model(from: WaterlessConsts.configFileName) else { return }
        
        configViewModels = items
        
        configViewModels.forEach { (config) in
            
            let finalViewModel = viewModel(from: config.itemViewModelName)
            
            if let realVm = finalViewModel
            {
                realVm.cellConfiguration = config.itemUIConfigure
                
                realVm.configCell()
                
                config.itemViewModel = realVm
            }
        }
    }
}
