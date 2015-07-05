//
//  EnemySprite.swift
//  First_SpriteKit_Game
//
//  Created by Jeffrey Lin on 6/21/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit

class Sprite : SKSpriteNode{
    var currentFrame = 0
    var randomFrame = 0 // For when the frame the enemy moves into screen
    var moving = false
    var angle = 0.0
    var range = 2.0
    var yPos = CGFloat()
    enum SpriteType {
        case Hero, LineEnemy, WavyEnemy, CoinSprite
    }
    enum ColliderType:UInt32{
        case Hero = 1
        case LineEnemy = 5
        case WavyEnemy = 6
        case CoinSprite = 10
        
        static var All = ColliderType.Hero.rawValue | ColliderType.LineEnemy.rawValue | ColliderType.WavyEnemy.rawValue | ColliderType.CoinSprite.rawValue
        
        static var Enemy = ColliderType.LineEnemy.rawValue | ColliderType.WavyEnemy.rawValue
        
        static var PowerUp = ColliderType.CoinSprite.rawValue
    }
    
    convenience init(named : String) {
        self.init(imageNamed: named)
    }
    
    func setRandomFrame(){
        var range = UInt32(0)..<UInt32(100)
        self.randomFrame = Int(range.startIndex + arc4random_uniform(range.endIndex - range.startIndex + 1))
    }
    func collidedWith(other : SKPhysicsBody){}
    func motion(){}
    func configurePhysicsBody(){}
    func remove(){}
    
}
