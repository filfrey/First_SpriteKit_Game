//
//  Hero.swift
//  Not_Like_You
//
//  Created by Jeffrey Lin on 7/4/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit

class Hero: Sprite, SharedAssets {
    
    convenience init(sprites: [SKSpriteNode], atPosition position: CGPoint, usingOffset offset: CGFloat) {
        self.init()
        
    }
    convenience init(){
        self.init()
    }
    convenience init(texture: SKTexture?, atPosition position: CGPoint) {
        let size = texture != nil ? texture!.size() : CGSize(width: 0, height: 0)
        self.init(texture: texture, color: SKColor.whiteColor(), size: size)
    }
    static func loadSharedAssets(){
        
    }
    override func moveInMoveDirection(direction: MoveDirection, withTimeInterval timeInterval: NSTimeInterval) {
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
        
        if action != nil {
            runAction(action)
        }
    }
    
    func faceToPosition(position: CGPoint) -> CGFloat {
        var angle = adjustAssetOrientation(position.radiansToPoint(self.position))
        
        var action = SKAction.rotateToAngle(angle, duration: 0)
        
        runAction(action)
        
        return angle
    }
    
    override func moveTowardsPosition(targetPosition: CGPoint, withTimeInterval timeInterval: NSTimeInterval) {
        // Grab an immutable position in case Sprite Kit changes it underneath us.
        let currentPosition = position
        var deltaX = targetPosition.x - currentPosition.x
        var deltaY = targetPosition.y - currentPosition.y
        var maximumDistance = movementSpeed * CGFloat(timeInterval)
        
        moveFromCurrentPosition(currentPosition, byDeltaX: deltaX, deltaY: deltaY, maximumDistance: maximumDistance)
    }
    
    override func moveInDirection(direction: CGVector, withTimeInterval timeInterval: NSTimeInterval, facing: CGPoint? = nil) {
        // Grab an immutable position in case Sprite Kit changes it underneath us.
        let currentPosition = position
        var deltaX = movementSpeed * direction.dx
        var deltaY = movementSpeed * direction.dy
        var maximumDistance = movementSpeed * CGFloat(timeInterval)
        
        moveFromCurrentPosition(currentPosition, byDeltaX: deltaX, deltaY: deltaY, maximumDistance: maximumDistance, facing: facing)
    }
    
    override func moveFromCurrentPosition(currentPosition: CGPoint, byDeltaX dx: CGFloat, deltaY dy: CGFloat, maximumDistance: CGFloat, facing: CGPoint? = nil) {
        let targetPosition = CGPoint(x: currentPosition.x + dx, y: currentPosition.y + dy)
        
        var angle = adjustAssetOrientation(targetPosition.radiansToPoint(currentPosition))
        
        if facing != nil {
            let facePosition = currentPosition + facing!
            faceToPosition(facePosition)
        }
        else {
            faceToPosition(targetPosition)
        }
        
        var distRemaining = hypot(dx, dy)
        if distRemaining < maximumDistance {
            position = targetPosition
        } else {
            let x = currentPosition.x - (maximumDistance * sin(angle))
            let y = currentPosition.y + (maximumDistance * cos(angle))
            position = CGPoint(x: x, y: y)
        }
    }
}