//
//  WavyEnemy.swift
//  Not Like You
//
//  Created by Jeffrey Lin on 6/25/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit

class WavyEnemy : Sprite, SharedAssets{
    var newSpeed = 5 + CGFloat(arc4random_uniform(4))
    var newYPos = CGFloat(arc4random_uniform(300)) - 150
    var movingLeft = true
    
    convenience init(var screen : CGFloat) {
        self.init(imageNamed : "gray")
        
        if Int(arc4random_uniform(2)) == 1{
            movingLeft = false
            screen  *= -1
            newYPos *= -1
        }
        
        yPos = newYPos
        
        self.speed = newSpeed
        self.position.x = screen
        self.position.y = newYPos
        self.motion()
        self.configurePhysicsBody()
    }
    
    override func configurePhysicsBody(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.categoryBitMask = ColliderType.Enemy
        self.physicsBody!.collisionBitMask = ColliderType.All
        self.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
    }
    
    override func motion(){
        if self.moving{
            self.position.y = CGFloat(Double(self.position.y) + sin(self.angle) * self.range)
            self.angle += 0.1
            if movingLeft{
                self.position.x -= CGFloat(self.speed)
            }
            else{
                self.position.x += CGFloat(self.speed)
            }
        }
        else{
            self.currentFrame++
            if self.currentFrame > self.randomFrame{
                self.moving = true
            }
        }
    }
    
    override func remove(){
        self.removeAllActions()
        self.removeFromParent()
        self.removeAllChildren()
        physicsBody = nil
    }
    
    static func loadSharedAssets(){
        
    }
}
