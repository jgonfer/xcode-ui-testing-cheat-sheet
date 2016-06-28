//
//  Player.swift
//  Xcuit
//
//  Created by jgonzalez on 28/6/16.
//  Copyright © 2016 jgonfer. All rights reserved.
//

import Foundation

struct Player {
    var role: Role
    var name: String
    var lore: Lore
    var owned = false
    
    init(role: Role, name: String, lore: Lore) {
        self.role = role
        self.name = name
        self.lore = lore
    }
}