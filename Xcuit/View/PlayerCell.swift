//
//  PlayerCell.swift
//  Xcuit
//
//  Created by jgonzalez on 28/6/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    @IBOutlet weak var roleImage: UIImageView!
    @IBOutlet weak var loreImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    var player: Player!
    
    func setupCell(player: Player) {
        nameLabel.text = player.name
        statusImage.image = UIImage(named: player.owned ? "owned" : "owned-no")
    }
}
