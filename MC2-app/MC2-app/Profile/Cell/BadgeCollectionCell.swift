//
//  BadgeCollectionCell.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 19/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class BadgeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var xpProgressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        circleView.layer.cornerRadius = frame.size.width / 2
        circleView.layer.masksToBounds = true
        */
    }
}
