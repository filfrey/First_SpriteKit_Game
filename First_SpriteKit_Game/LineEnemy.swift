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
    var newSpeed = 5 + Float(arc4random_uniform(4))
    var newYPos = CGFloat(arc4random_uniform(300)) - 150
    var lineEnemySpriteNode = SKSpriteNode(imageNamed: "green")
    init(screen : CGFloat) {
        let type = "wavy"
        super.init(speed: newSpeed,guy: lineEnemySpriteNode)
        yPos = newYPos
        lineEnemySpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: lineEnemySpriteNode.size.width/2)
        lineEnemySpriteNode.physicsBody!.affectedByGravity = false
        lineEnemySpriteNode.physicsBody!.categoryBitMask = ColliderType.EnemySprite.rawValue
        lineEnemySpriteNode.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
        lineEnemySpriteNode.position.x = screen
        lineEnemySpriteNode.position.y = newYPos
        println(self.guy.position.y)
        println(newYPos)
        self.motion()
    }
    
    override func getSpriteNode()->SKSpriteNode{
        return lineEnemySpriteNode
    }
    
    override func motion(){
        if self.moving{
            lineEnemySpriteNode.position.x -= CGFloat(self.speed)
        }
        else{
            self.currentFrame++
            if self.currentFrame > self.randomFrame{
                self.moving = true
            }
        }
        
    }
    
    
}