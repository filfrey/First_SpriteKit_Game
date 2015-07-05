//
//  WavyEnemy.swift
//  Not Like You
//
//  Created by Jeffrey Lin on 6/25/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit
/*
class WavyEnemy : Sprite, SharedAssets{
    var newSpeed = 5 + Float(arc4random_uniform(4))
    var newYPos = CGFloat(arc4random_uniform(300)) - 150
    var wavyEnemySpriteNode = SKSpriteNode(imageNamed: "gray")
    var movingLeft = true
    
    init(var screen : CGFloat) {
        if Int(arc4random_uniform(2)) == 1{
            movingLeft = false
            screen  *= -1
            newYPos *= -1
        }
        super.init(speed: newSpeed,guy: wavyEnemySpriteNode)
        
        yPos = newYPos
        wavyEnemySpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: wavyEnemySpriteNode.size.width/2)
        wavyEnemySpriteNode.physicsBody!.affectedByGravity = false
        wavyEnemySpriteNode.physicsBody!.categoryBitMask = ColliderType.EnemySprite.rawValue
        wavyEnemySpriteNode.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
        wavyEnemySpriteNode.position.x = screen
        wavyEnemySpriteNode.position.y = newYPos
        self.motion()
    }
    
    override func getSpriteNode()->SKSpriteNode{
        return wavyEnemySpriteNode
    }
        
    override func motion(){
        if self.moving{
            self.guy.position.y = CGFloat(Double(self.guy.position.y) + sin(self.angle) * self.range)
            self.angle += 0.1
            if movingLeft{
                self.guy.position.x -= CGFloat(self.speed)
            }
            else{
                self.guy.position.x += CGFloat(self.speed)
            }
        }
        else{
            self.currentFrame++
            if self.currentFrame > self.randomFrame{
                self.moving = true
            }
        }
    }
    override func getColliderType() -> UInt32{
        return ColliderType.EnemySprite.rawValue
    }
    
    
    static func loadSharedAssets(){
        
    }
}
*/