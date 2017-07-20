//
//  ViewModelProvider.swift
//  Waterless
//
//  Created by Harly on 2017/7/19.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

// MARK: - ViewModel 必须用这个
protocol CellConfiguratble : class
{
    init()
    
    var cellConfiguration : CellConfiguration? { get set }
    
    func configCell()
}

// MARK: - ViewModel 转化
protocol ViewModelConveniable
{
    func viewModel(from vmName : String) -> CellConfiguratble?
}

extension ViewModelConveniable
{
    func viewModel(from vmName : String) -> CellConfiguratble?
    {
        let vmClass = NSClassFromString("Waterless." + vmName) as? CellConfiguratble.Type
        
        guard let realVmClass = vmClass else { return nil }
        
        let realVMProperty = realVmClass.init()
        
        return realVMProperty
    }
}

