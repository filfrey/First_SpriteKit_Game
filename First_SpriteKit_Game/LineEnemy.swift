//
//  WavyEnemy.swift
//  Not Like You
//
//  Created by Jeffrey Lin on 6/25/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit

class LineEnemy : EnemySprite{
    var newSpeed = 2 + Float(arc4random_uniform(1))
    var newYPos = CGFloat(arc4random_uniform(10000)) - 5000
    init(guy : SKSpriteNode) {
        let type = "wavy"
        super.init(speed: newSpeed,guy: guy)
        yPos = newYPos
        self.motion()
    }
    
    override func motion(){
        if self.moving{
            self.guy.position.y -= CGFloat(self.guy.position.y)
            self.guy.position.x -= CGFloat(self.speed)
        }
        else{
            self.currentFrame++
            if self.currentFrame > self.randomFrame{
                self.moving = true
            }
        }
        
    }
    
    
}