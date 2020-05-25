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
    
    @IBOutlet weak var bronze1DotView: UIView!
    @IBOutlet weak var bronze2DotView: UIView!
    @IBOutlet weak var bronze3DotView: UIView!
    @IBOutlet weak var silver1DotView: UIView!
    @IBOutlet weak var silver2DotView: UIView!
    @IBOutlet weak var silver3DotView: UIView!
    @IBOutlet weak var gold1DotView: UIView!
    @IBOutlet weak var gold2DotView: UIView!
    @IBOutlet weak var gold3DotView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        circleView.layer.cornerRadius = frame.size.width / 2
        circleView.layer.masksToBounds = true
        */
    }
}
