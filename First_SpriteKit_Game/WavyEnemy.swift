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
    var newSpeed = 1 + Float(arc4random_uniform(2))
    var newYPos = CGFloat(arc4random_uniform(10000)) - 5000
    var wavyEnemySpriteNode = SKSpriteNode(imageNamed: "gray")
    
    init(screen : CGFloat) {
        let type = "gray"
        print(newSpeed)
        super.init(speed: newSpeed,guy: wavyEnemySpriteNode)
        
        yPos = newYPos
        wavyEnemySpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: wavyEnemySpriteNode.size.width/2)
        wavyEnemySpriteNode.physicsBody!.affectedByGravity = false
        wavyEnemySpriteNode.physicsBody!.categoryBitMask = ColliderType.EnemySprite.rawValue
        wavyEnemySpriteNode.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
        wavyEnemySpriteNode.position.x = screen
        self.motion()
    }
    
    func getSpriteNode()->SKSpriteNode{
        return wavyEnemySpriteNode
    }
        
    override func motion(){
        if self.moving{
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