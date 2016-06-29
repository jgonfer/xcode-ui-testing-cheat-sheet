//
//  PlayerDetailsViewController.swift
//  Xcuit
//
//  Created by jgonzalez on 28/6/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

let purchaseButtonEnabled = UIColor(red:0.93, green:0.74, blue:0.27, alpha:1.00)
let purchaseButtonDisabled = UIColor(red:0.71, green:0.71, blue:0.71, alpha:1.00)

protocol PlayerDetailsDelegate {
    func playerPurchased(player: Player)
}

class PlayerDetailsViewController: UIViewController {
    @IBOutlet weak var avatarBigImage: UIImageView!
    @IBOutlet weak var roleImage: UIImageView!
    @IBOutlet weak var loreImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    
    var delegate: PlayerDetailsDelegate!
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationController?.navigationBar.topItem?.title = "Players"
        title = player.name
        var image = player.name.lowercaseString
        image = image.stringByReplacingOccurrencesOfString(" ", withString: "-")
        image = image.stringByReplacingOccurrencesOfString("'", withString: "-")
        avatarBigImage.image = UIImage(named: "\(image)-big")
        nameLabel.text = player.name
        roleImage.image = UIImage(named: Role.image[player.role.hashValue])
        loreImage.image = UIImage(named: Lore.image[player.lore.hashValue])
        purchaseButton.layer.cornerRadius = 5.0
        purchaseButton.backgroundColor = player.owned ? purchaseButtonDisabled : purchaseButtonEnabled
        purchaseButton.enabled = !player.owned
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBAction methods
    
    @IBAction func buyPlayer(sender: UIButton) {
        player.owned = true
        delegate.playerPurchased(player)
        navigationController?.popViewControllerAnimated(true)
    }
}
