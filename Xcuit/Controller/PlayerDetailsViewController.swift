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
        avatarBigImage.accessibilityLabel = "\(image)-big"
        
        nameLabel.text = player.name
        nameLabel.accessibilityLabel = player.name
        
        roleImage.image = UIImage(named: Role.image[player.role.hashValue])
        roleImage.accessibilityLabel = Role.image[player.role.hashValue]
        
        loreImage.image = UIImage(named: Lore.image[player.lore.hashValue])
        loreImage.accessibilityLabel = Lore.image[player.lore.hashValue]
        
        let screenMidWidth = CGRectGetMidX(view.bounds)
        let screenHeight = CGRectGetHeight(view.bounds)
        
        if player.owned {
            let width: CGFloat = 300.0
            let height: CGFloat = 50.0
            let elementFrame = CGRect(x: screenMidWidth - (width/2.0),
                                      y: screenHeight - 150,
                                      width: width,
                                      height: height)
            
            let messageLabel = UILabel(frame: elementFrame)
            messageLabel.text = "You already purchased this character"
            messageLabel.alpha = 0
            messageLabel.textColor = UIColor.whiteColor()
            self.view.addSubview(messageLabel)
            
            UIView.animateWithDuration(1, delay: 0.5, options: .CurveEaseIn, animations: {
                messageLabel.alpha = 1
                }, completion: { (_) in
            })
        } else {
            let width: CGFloat = 150.0
            let height: CGFloat = 50.0
            let centerPoint = CGPoint(x: screenMidWidth, y: screenHeight - 100)
            let elementFrame = CGRect(x: screenMidWidth - (width/2.0),
                                      y: screenHeight,
                                      width: width,
                                      height: height)
            
            let purchaseButton = UIButton(frame: elementFrame)
            purchaseButton.layer.cornerRadius = 5.0
            purchaseButton.backgroundColor = player.owned ? purchaseButtonDisabled : purchaseButtonEnabled
            purchaseButton.enabled = !player.owned
            purchaseButton.addTarget(self, action: #selector(PlayerDetailsViewController.buyPlayer(_:)), forControlEvents: .TouchUpInside)
            purchaseButton.setTitle("Buy", forState: .Normal)
            
            UIView.animateWithDuration(1, delay: 1, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .CurveEaseIn, animations: {
                self.view.addSubview(purchaseButton)
                purchaseButton.center = centerPoint
                }, completion: { (_) in
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: IBAction methods
    
    func buyPlayer(sender: UIButton) {
        player.owned = true
        delegate.playerPurchased(player)
        navigationController?.popViewControllerAnimated(true)
    }
}
