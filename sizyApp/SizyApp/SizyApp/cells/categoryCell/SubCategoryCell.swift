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
        basedView.layer.borderWidth = 1.0
        basedView.layer.borderColor = UIColor(displayP3Red: 1/255, green: 1/255, blue: 1/255, alpha: 1.0).cgColor
        subLabel.highlightedTextColor = .brown
    }

}
