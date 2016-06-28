//
//  PlayerDetailsViewController.swift
//  Xcuit
//
//  Created by jgonzalez on 28/6/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UIViewController {
    var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationController?.title = player.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
