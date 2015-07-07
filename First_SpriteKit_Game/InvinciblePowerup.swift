//
//  InvinciblePowerup.swift
//  Not Like You
//
//  Created by Jeffrey Lin on 7/6/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit

class InvinciblePowerup : Sprite, SharedAssets{
    var newSpeed = 50
    var newYPos = CGFloat(arc4random_uniform(300)) - 150
    var newValue = Int(arc4random_uniform(10)) + 3
    var movingLeft = true
    
    convenience init(var screen : CGFloat) {
        self.init(imageNamed : "shield")
        
        yPos = newYPos
        self.speed = 0
        self.position.x = CGFloat(arc4random_uniform(300)) - CGFloat(248)
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
    override func remove(){
        self.removeAllActions()
        self.removeFromParent()
        self.removeAllChildren()
        physicsBody = nil
    }
    
    override func motion(){speed--}
    override func getValue() -> Int {
        return newValue
    }
    static func loadSharedAssets(){
        
    }
}