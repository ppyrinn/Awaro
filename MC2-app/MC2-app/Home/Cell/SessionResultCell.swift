//
//  SessionResultCell.swift
//  Awaro
//
//  Created by Rayhan Martiza Faluda on 16/05/20.
//  Copyright © 2020 Poppy. All rights reserved.
//

import UIKit

class SessionResultCell: UITableViewCell {
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var badgeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var challengeScoreLabel: UILabel!
    @IBOutlet weak var clockInLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
