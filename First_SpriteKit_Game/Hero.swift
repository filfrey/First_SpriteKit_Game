//
//  Hero.swift
//  First_SpriteKit_Game
//
//  Created by Jeffrey Lin on 6/20/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit // Needed to create SKSpriteNode


class Hero{ // Needs a initalizer in order to work
    var guy :SKSpriteNode
    var speed = 0.1
    
    init(guy:SKSpriteNode){
        self.guy = guy
    }
}