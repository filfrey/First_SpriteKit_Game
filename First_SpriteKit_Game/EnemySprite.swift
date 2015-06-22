//
//  EnemySprite.swift
//  First_SpriteKit_Game
//
//  Created by Jeffrey Lin on 6/21/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit

class EnemySprite{
    var speed: Float = 0.0
    var guy:SKSpriteNode // Is going to be a member of SKSpriteNode
    var currentFrame = 0
    var randomFrame = 0 // For when the frame the enemy moves into screen
    var moving = false
    var angle = 0.0
    var range = 2.0
    var yPos = CGFloat()
    
    init(speed:Float,guy:SKSpriteNode){
        self.speed = speed
        self.guy = guy
        self.setRandomFrame()
    }
    
    func setRandomFrame(){
        var range = UInt32(50)..<UInt32(200)
        self.randomFrame = Int(range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1))
    }
}
