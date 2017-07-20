//
//  ShortTermStyleCell.swift
//  Waterless
//
//  Created by Harly on 2017/7/19.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

class ShortTermStyleCell: UICollectionViewCell , CellWaterable , CellDataConvertiable{

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configCell()
    }
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var cellContentView: UIView!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
