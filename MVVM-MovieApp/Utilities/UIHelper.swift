//
//  UIHelper.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 27.12.2023.
//

import UIKit

enum UIHelper {
    
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        let itemWidth = CGFloat.deviceWidth
        let itemHeight = itemWidth * 1.5
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumLineSpacing = 40
        
        return flowLayout
    }
}
