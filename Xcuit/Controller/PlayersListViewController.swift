//
//  EpisodesListViewController.swift
//  Xcuit
//
//  Created by jgonzalez on 28/6/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import UIKit

class PlayersListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var players: [Player]?
    var selectedIndex: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        getPlayersList()
        tableView.contentInset = UIEdgeInsetsMake(65, 0, 0, 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPlayersList() {
        players = [Player]()
        players?.append(Player(role: .Specialist, name: "Sylvanas", lore: .Warcraft))
        players?.append(Player(role: .Assassin, name: "Valla", lore: .Diablo))
        players?.append(Player(role: .Warrior, name: "Arthas", lore: .Warcraft))
        players?.append(Player(role: .Specialist, name: "The Lost Vikings", lore: .LostVikings))
        players?.append(Player(role: .Support, name: "Malfurion", lore: .Warcraft))
        players?.append(Player(role: .Specialist, name: "Gazlowe", lore: .Warcraft))
        players?.append(Player(role: .Assassin, name: "Nova", lore: .Starcraft))
        players?.append(Player(role: .Support, name: "Uther", lore: .Warcraft))
        players?.append(Player(role: .Specialist, name: "Azmodan", lore: .Diablo))
        players?.append(Player(role: .Warrior, name: "Artanis", lore: .Starcraft))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlayerDetails" {
            guard let vc = segue.destinationViewController as? PlayerDetailsViewController, let index = selectedIndex, let players = players else {
                return
            }
            vc.delegate = self
            vc.player = players[index.row]
        }
    }
}

extension PlayersListViewController: UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let players = players else {
            return 0
        }
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! PlayerCell
        
        guard let players = players else {
            return cell
        }
        cell.setupCell(players[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("showPlayerDetails", sender: nil)
    }
}

extension PlayersListViewController: PlayerDetailsDelegate {
    func playerPurchased(player: Player) {
        guard let players = players, let selectedIndex = selectedIndex,let i = players.indexOf({ $0.name == player.name }) else {
            return
        }
        self.players![i] = player
        tableView.reloadRowsAtIndexPaths([selectedIndex], withRowAnimation: UITableViewRowAnimation.Fade)
    }
}