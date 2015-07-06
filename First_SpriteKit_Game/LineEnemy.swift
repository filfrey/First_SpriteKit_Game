//
//  WavyEnemy.swift
//  Not Like You
//
//  Created by Jeffrey Lin on 6/25/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit

class LineEnemy : Sprite, SharedAssets{
    var newSpeed = 5 + CGFloat(arc4random_uniform(4))
    var newYPos = CGFloat(arc4random_uniform(300)) - 150
    var movingLeft = true
    convenience init(var screen : CGFloat) {
        self.init(imageNamed : "green")
        
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
        self.physicsBody = SKPhysicsBody(circleOfRadius: 18)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.categoryBitMask = ColliderType.Enemy
        self.physicsBody!.collisionBitMask = ColliderType.All
        self.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
    }
    
    override func collidedWith(other : SKPhysicsBody){
        if other.categoryBitMask & ColliderType.Hero.rawValue == 0 {
            return
        }
        
        if let enemy = other.node as? Sprite {
        //    enemy.remove()
        }
    }
    
    override func remove(){
        self.removeAllActions()
        self.removeFromParent()
        self.removeAllChildren()
        physicsBody = nil
    }
    
    override func motion(){
        if self.moving{
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
    
    static func loadSharedAssets(){
        
    }
    
}