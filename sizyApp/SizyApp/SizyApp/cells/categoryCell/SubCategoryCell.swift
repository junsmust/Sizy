//
//  SubCategoryCell.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/30.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class SubCategoryCell: UICollectionViewCell {

    @IBOutlet weak var basedView: UIView!
    @IBOutlet weak var subLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        basedView.layer.cornerRadius = 10.0
        
        subLabel.highlightedTextColor = .brown
    }

}
