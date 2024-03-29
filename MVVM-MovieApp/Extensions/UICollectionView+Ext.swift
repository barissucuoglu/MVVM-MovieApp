//
//  UICollectionView+Ext.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 28.12.2023.
//

import UIKit

extension UICollectionView {
    
    func reloadOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
}
