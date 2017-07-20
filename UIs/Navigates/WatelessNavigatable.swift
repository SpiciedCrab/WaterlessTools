//
//  WatelessNavigatable.swift
//  Waterless
//
//  Created by Harly on 2017/7/18.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

protocol WaterlessNavigatable
{
    func navigateToWaterless()
    
}

extension WaterlessNavigatable
{
    func navigateToWaterless()
    {
        guard let rootController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else
        {
            return
        }
        
        let waterStoryBoard = UIStoryboard(name: "WaterlessMain", bundle: Bundle.main)
        let homeVc = waterStoryBoard.instantiateViewController(withIdentifier: "WaterlessHomeViewController")
        rootController.pushViewController(homeVc, animated: true)
    }
    
}
