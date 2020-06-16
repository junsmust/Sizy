//
//  CategoryCell.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/29.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryiV: UIImageView!
    @IBOutlet weak var categoryTitleLb: UILabel!
    @IBOutlet weak var basedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        /*
        basedView.layer.borderWidth = 0.6
        basedView.layer.borderColor = CGColor(srgbRed: 1/255, green: 1/255, blue: 1/255, alpha: 1)
        categoryiV.layer.borderColor = CGColor(srgbRed: 1/255, green: 1/255, blue: 1/255, alpha: 1)
        categoryiV.layer.borderWidth = 0.6
        */
        basedView.layer.cornerRadius = 10.0
        categoryTitleLb.highlightedTextColor = .brown
    }

}
