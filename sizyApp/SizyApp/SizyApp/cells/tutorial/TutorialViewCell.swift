//
//  TutorialViewCell.swift
//  SizyApp
//
//  Created by 임명준 on 2020/05/01.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit

class TutorialViewCell: UICollectionViewCell {
    let tutorialIv: UIImageView = {
            let iv = UIImageView()
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            return iv
        }()
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(tutorialIv)
            tutorialIv.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            tutorialIv.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            tutorialIv.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            tutorialIv.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            tutorialIv.widthAnchor.constraint(equalToConstant: 50).isActive = true
            tutorialIv.heightAnchor.constraint(equalToConstant: 100).isActive = true

        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

