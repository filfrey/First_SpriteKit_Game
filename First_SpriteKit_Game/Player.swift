//
//  Player.swift
//  Not_Like_You
//
//  Created by Jeffrey Lin on 7/4/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit
import GameController

class Player: NSObject {
    
    // MARK: Properties
    
    var hero: Hero?
    var score = 0
    
    // Convenience properties for the nodes that make up the player's HUD.
    var hudAvatar: SKSpriteNode!
    var hudScore: SKLabelNode!
    var hudLifeHearts = [SKSpriteNode]()
    
    var moveForward = false
    var moveLeft = false
    var moveRight = false
    var moveBackward = false
    var fireAction = false
    
    var heroMoveDirection: CGVector?
    var heroFaceLocation: CGPoint?
    var controller: GCController?
    
    var movementTouch: UITouch?
    var targetLocation = CGPointZero
    var moveRequested = false
}
