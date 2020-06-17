//
//  FitCategoryDatasource.swift
//  SizyApp
//
//  Created by 임명준 on 2020/06/17.
//  Copyright © 2020 임명준. All rights reserved.
//

import Foundation
import UIKit

class FitCategoryDatasource: NSObject, UICollectionViewDataSource {
    override init() {
        debugPrint("FitCategoryDatasource")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        debugPrint("count   \(FitData.shared.fits.count)")
        return FitData.shared.fits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        debugPrint("FitCategoryDatasource  cellForItemAt")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCells.SubCategoryCell.rawValue, for: indexPath) as? SubCategoryCell else{return SubCategoryCell()}
        
        cell.subLabel.text = FitData.shared.fits[indexPath.row].getString()
        
        return cell
    }
}
