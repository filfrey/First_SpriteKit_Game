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
class CoinSprite : Sprite, SharedAssets{
    var newSpeed = (Float)(10)
    var newYPos = CGFloat(arc4random_uniform(300)) - 150
    var coinSpriteNode = SKSpriteNode(imageNamed: "money")
    var value = CGFloat(arc4random_uniform(10)) - 3
    var randomXPos : (CGFloat)
    var movingLeft = true
    
    init(var screen : CGFloat) {
        if Int(arc4random_uniform(2)) == 1{
            movingLeft = false
            screen  *= -1
            newYPos *= -1
        }
        
        randomXPos = CGFloat(arc4random_uniform(496)) - CGFloat(248)
        
        super.init(speed: newSpeed,guy: coinSpriteNode)
        
        coinSpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: coinSpriteNode.size.width/2)
        coinSpriteNode.physicsBody!.affectedByGravity = false
        coinSpriteNode.physicsBody!.categoryBitMask = ColliderType.PowerUp.rawValue
        coinSpriteNode.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
        coinSpriteNode.position.x = randomXPos
        coinSpriteNode.position.y = newYPos
        self.motion()
        self.randomFrame = 0
    }
    
    
    override func getSpriteNode()->SKSpriteNode{
        return coinSpriteNode
    }
    
    override func motion(){
        if self.moving{
            if movingLeft{
                coinSpriteNode.position.x -= CGFloat(self.speed)
            }
            else{
                coinSpriteNode.position.x += CGFloat(self.speed)
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
        return ColliderType.PowerUp.rawValue
    }
    
    
    static func loadSharedAssets(){
        
    }
}
*/