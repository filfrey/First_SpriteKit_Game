//
//  Hero.swift
//  First_SpriteKit_Game
//
//  Created by Jeffrey Lin on 6/23/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit // Needed to create SKSpriteNode


class Hero : Sprite, SharedAssets{
    var emit = false
    var emitFrameCount = 0
    var maxEmitFrameCount = 30
    convenience init(newParticles : SKEmitterNode){
        self.init(imageNamed : "white")
        self.configurePhysicsBody()
    }
    
    override func configurePhysicsBody(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: 18)
        self.physicsBody!.affectedByGravity = false
        self.physicsBody!.categoryBitMask = ColliderType.Player
        self.physicsBody!.collisionBitMask = ColliderType.Enemy
        self.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
    }
    
    override func remove(){
        self.removeAllActions()
    }
    
    func moveTo(newPosition : CGPoint){
        self.position = newPosition
    }
    
    static func loadSharedAssets(){
        
    }
}