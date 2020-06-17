//
//  TableViewCell.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/22.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var sizeTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       /* contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = CGColor(srgbRed: 1/255, green: 1/255, blue: 1/255, alpha: 1)*/
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
