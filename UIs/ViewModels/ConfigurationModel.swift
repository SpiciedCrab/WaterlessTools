//
//  ConfigurationModel.swift
//  Waterless
//
//  Created by Harly on 2017/7/19.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

// MARK: - 共通Config Model
class BaseConfig: NSObject {
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("啊 我神马都不知道")
    }
    
    required init(with dic : [String : Any]) {
        super.init()
        self.setValuesForKeys(dic)
    }
}

// MARK: - Item Model
class ItemConfiguration: BaseConfig
{
    var itemId : Int = 0
    var itemSortOrder : Int = 0
    var itemName : String = ""
    var itemViewModelName : String = ""
    var itemStyle : Int = 0
    var itemUIConfigure : CellConfiguration?
    
    var itemViewModel : CellConfiguratble?
    var realItemStyle : ConfigueStyle?
    
    required init(with dic : [String : Any]) {
        super.init(with: dic)

        guard let internalDic = dic["itemUIConfigure"] as? [String : Any] else { return }
        itemUIConfigure = CellConfiguration(with: internalDic)
        
        realItemStyle = ConfigueStyle.style(code: itemStyle)
    }
}

// MARK: - Cell Model
class CellConfiguration: BaseConfig
{
    var title : String = ""
    var subtitle : String = ""
    var iconImage : String = ""

}

enum ConfigueStyle
{
    case long(cellName : String , widthDelta : CGFloat , height : CGFloat)
    case short(cellName : String , widthDelta : CGFloat , height : CGFloat)
    
    static func style(code : Int) -> ConfigueStyle
    {
        if code == 0
        {
            return .long(cellName: "LongTermStyleCell", widthDelta: 1, height: 100)
        }
        else
        {
            return .short(cellName: "ShortTermStyleCell", widthDelta: 3, height: 150)
        }
    }
}

