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
    var value = 0
    enum SpriteType {
        case Hero, LineEnemy, WavyEnemy, CoinPowerup, InvinciblePowerup
    }
    enum ColliderType:UInt32{
        case Hero = 1
        case LineEnemy = 5
        case WavyEnemy = 6
        case CoinPowerup = 10
        case InvinciblePowerup = 11
        
        static var All = ColliderType.Hero.rawValue | ColliderType.LineEnemy.rawValue | ColliderType.WavyEnemy.rawValue | ColliderType.CoinPowerup.rawValue
        static var Player = ColliderType.Hero.rawValue
        static var Enemy = ColliderType.LineEnemy.rawValue | ColliderType.WavyEnemy.rawValue
        
        static var PowerUp = ColliderType.CoinPowerup.rawValue | ColliderType.InvinciblePowerup.rawValue
    }
    
    convenience init(named : String) {
        self.init(imageNamed: named)
    }
    
    func collidedWith(other : SKPhysicsBody){}
    func motion(){}
    func configurePhysicsBody(){}
    func remove(){}
    func getValue()-> Int {return value}
    
}
