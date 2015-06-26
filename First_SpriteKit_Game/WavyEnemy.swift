//
//  WavyEnemy.swift
//  Not Like You
//
//  Created by Jeffrey Lin on 6/25/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit

class WavyEnemy : EnemySprite{

    init(speed: Float, guy : SKSpriteNode, type : String) {
        let type = "wavy"
        super.init(speed: speed, guy: guy)
        self.motion()
    }
    
    override func motion(){
        if self.moving{
            println("MOTION BEING CALLED")
            self.guy.position.y = CGFloat(Double(self.guy.position.y) + sin(self.angle) * self.range)
            self.angle += 0.1
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