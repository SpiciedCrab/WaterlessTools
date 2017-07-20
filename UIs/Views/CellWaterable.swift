//
//  CellWaterable.swift
//  Waterless
//
//  Created by Harly on 2017/7/19.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

// MARK: - 共通Cell 配置
protocol CellWaterable
{
    /// 阴影
    weak var shadowView: UIView! { get }
    
    /// 实用的content
    weak var cellContentView: UIView! { get }
    
    weak var icon: UIImageView! { get }
    weak var titleLabel: UILabel! { get }
    weak var subTitleLabel: UILabel! { get }
}

extension CellWaterable
{
    func configCell()
    {
        shadowView.layer.cornerRadius = WaterlessConsts.waterCorner
        cellContentView.layer.cornerRadius = WaterlessConsts.waterCorner
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowOpacity = 0.2
    }
}

// MARK: - 共通Data 配置
protocol CellDataConvertiable
{
    func configData(config : CellConfiguration)
}

extension CellDataConvertiable where Self : CellWaterable
{
    func configData(config : CellConfiguration)
    {
        icon.image = UIImage(named: config.iconImage)
        titleLabel.text = config.title
        subTitleLabel.text = config.subtitle
    }
}
