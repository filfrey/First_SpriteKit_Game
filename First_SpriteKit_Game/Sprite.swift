//
//  Sprite.swift
//  Not_Like_You
//
//  Created by Jeffrey Lin on 7/4/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit


enum MoveDirection {
    case Forward, Left, Right, Back
}

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


class Sprite : SKSpriteNode{
    
    var isAlive = true
    var isVisible = true
    var rotationSpeed: CGFloat = 0.06
    var movementSpeed: CGFloat = 200.00
    
    class var characterType: CharacterType {
        return inferCharacterType(self)
    }
    
    convenience init(StringName : String){
        self.init(imageNamed : StringName)
    }
    
    func remove(){}
    func collidedWith(other : SKPhysicsBody){}
    func motion(){}
    func moveInMoveDirection(direction: MoveDirection, withTimeInterval timeInterval: NSTimeInterval) {
        var action: SKAction!
        
        switch direction {
        case .Forward:
            let x = -sin(zRotation) * movementSpeed * CGFloat(timeInterval)
            let y =  cos(zRotation) * movementSpeed * CGFloat(timeInterval)
            action = SKAction.moveByX(x, y: y, duration: timeInterval)
            
        case .Back:
            let x =  sin(zRotation) * movementSpeed * CGFloat(timeInterval)
            let y = -cos(zRotation) * movementSpeed * CGFloat(timeInterval)
            action = SKAction.moveByX(x, y: y, duration: timeInterval)
            
        case .Left:
            action = SKAction.rotateByAngle(rotationSpeed, duration:timeInterval)
            
        case .Right:
            action = SKAction.rotateByAngle(-rotationSpeed, duration:timeInterval)
        }
        
    }
    func moveTowardsPosition(targetPosition: CGPoint, withTimeInterval timeInterval: NSTimeInterval) {
        // Grab an immutable position in case Sprite Kit changes it underneath us.
        let currentPosition = position
        var deltaX = targetPosition.x - currentPosition.x
        var deltaY = targetPosition.y - currentPosition.y
        var maximumDistance = movementSpeed * CGFloat(timeInterval)
        
        moveFromCurrentPosition(currentPosition, byDeltaX: deltaX, deltaY: deltaY, maximumDistance: maximumDistance)
    }
    
    func moveInDirection(direction: CGVector, withTimeInterval timeInterval: NSTimeInterval, facing: CGPoint? = nil) {
        // Grab an immutable position in case Sprite Kit changes it underneath us.
        let currentPosition = position
        var deltaX = movementSpeed * direction.dx
        var deltaY = movementSpeed * direction.dy
        var maximumDistance = movementSpeed * CGFloat(timeInterval)
        
        moveFromCurrentPosition(currentPosition, byDeltaX: deltaX, deltaY: deltaY, maximumDistance: maximumDistance, facing: facing)
    }
    
    func moveFromCurrentPosition(currentPosition: CGPoint, byDeltaX dx: CGFloat, deltaY dy: CGFloat, maximumDistance: CGFloat, facing: CGPoint? = nil) {
        let targetPosition = CGPoint(x: currentPosition.x + dx, y: currentPosition.y + dy)
        
        var angle = adjustAssetOrientation(targetPosition.radiansToPoint(currentPosition))
        
        var distRemaining = hypot(dx, dy)
        if distRemaining < maximumDistance {
            position = targetPosition
        } else {
            let x = currentPosition.x - (maximumDistance * sin(angle))
            let y = currentPosition.y + (maximumDistance * cos(angle))
            position = CGPoint(x: x, y: y)
        }
        
    }
    
    // MARK: Scene Interactions
// removed addnode(GameSCene) and addToScene(Sprite) To_Be_Deleted
    
    override func removeFromParent() {
        super.removeFromParent()
    }
}