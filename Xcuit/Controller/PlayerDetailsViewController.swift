//
//  PlayerDetailsViewController.swift
//  Xcuit
//
//  Created by jgonzalez on 28/6/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UIViewController {
    @IBOutlet weak var playerBigImage: UIImageView!
    @IBOutlet weak var purchaseButton: UIButton!
    
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationController?.navigationBar.topItem?.title = "Players"
        title = player.name
        playerBigImage.image = UIImage(named: "\(player.name.lowercaseString)-big")
        purchaseButton.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
