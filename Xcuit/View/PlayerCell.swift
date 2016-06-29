//
//  PlayerCell.swift
//  Xcuit
//
//  Created by jgonzalez on 28/6/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var roleImage: UIImageView!
    @IBOutlet weak var loreImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    var player: Player!
    
    func setupCell(player: Player) {
        var image = player.name.lowercaseString
        image = image.stringByReplacingOccurrencesOfString(" ", withString: "-")
        image = image.stringByReplacingOccurrencesOfString("'", withString: "-")
        avatarImage.image = UIImage(named: image)
        nameLabel.text = player.name
        roleImage.image = UIImage(named: Role.image[player.role.hashValue])
        loreImage.image = UIImage(named: Lore.image[player.lore.hashValue])
        statusImage.image = UIImage(named: player.owned ? "owned" : "owned-no")
    }
}
