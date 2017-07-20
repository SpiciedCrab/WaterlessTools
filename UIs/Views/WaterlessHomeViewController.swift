//
//  WaterlessHomeViewController.swift
//  Waterless
//
//  Created by Harly on 2017/7/18.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit

// MARK: - 主Controller
class WaterlessHomeViewController: UIViewController {
    
    // MARK: - Xibs
    @IBOutlet weak var collectionView: UICollectionView!
        {
        didSet
        {
            collectionView.register(UINib(nibName: "LongTermStyleCell", bundle: Bundle.main), forCellWithReuseIdentifier: "LongTermStyleCell")
            collectionView.register(UINib(nibName: "ShortTermStyleCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ShortTermStyleCell")
            
        }
    }
    
    // MARK: - Private Fields
    fileprivate let viewModel : ViewModelConfigurable = ConfigurationCenterViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad(){
        
        super.viewDidLoad()
        
        viewModel.configPluginItems()
        
        collectionView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func backTapped(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
}

// MARK: - CollectionView Delegates
extension WaterlessHomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.configViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let configViewModel = viewModel.configViewModels[indexPath.row]
        
        guard let style = configViewModel.realItemStyle else { return UICollectionViewCell() }
        
        var realCellName = ""
        
        switch style {
            
        case .long(let cellName, widthDelta: _ , height: _):
            realCellName = cellName
            
        case .short(let cellName, widthDelta: _ , height: _):
            realCellName = cellName
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: realCellName, for: indexPath) as! CellDataConvertiable
        
        if let outConfig = configViewModel.itemUIConfigure
        {
            cell.configData(config: outConfig)
        }
        
        if let itemVm = configViewModel.itemViewModel , let itemConfig = itemVm.cellConfiguration
        {
            cell.configData(config: itemConfig)
        }
        
        return cell as! UICollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let configViewModel = viewModel.configViewModels[indexPath.row]
        
        guard let style = configViewModel.realItemStyle else { return CGSize.zero }
        
        var height : CGFloat = 100
        var widthMultiply : CGFloat = 1
        
        switch style {
            
        case .long(_ , let width , let realHeight):
            
            height = realHeight
            widthMultiply = width
            
        case .short(_ , let width , let realHeight):
            
            height = realHeight
            widthMultiply = width
        }
        
        return CGSize(width: collectionView.frame.size.width/widthMultiply, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
