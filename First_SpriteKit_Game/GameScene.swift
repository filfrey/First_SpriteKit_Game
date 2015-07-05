//
//  GameScene.swift
//  Not_Like_You
//
//  Created by Jeffrey Lin on 6/20/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import SpriteKit
import GameController

var lastUpdateTimeInterval: NSTimeInterval = 0

class GameScene: SKScene {
    
    var world = SKNode()
    var heroes = [Hero]()
    
    static let minimumUpdateInterval = 1.0 / 60.0
    
    class func loadSceneAssetsWithCompletionHandler(completionHandler: GameScene -> Void) {
        let loadedScene = GameScene(size: CGSize(width: 1024, height: 768))
    }
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        self.addChild(myLabel)
        let bg = SKSpriteNode(imageNamed:"bg") // Creates Constant bg
        addChild(bg)                           // Adds the created bg
        addHero()
    }
    
    func addHero(){
        let white = Hero()
        addChild(white)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        if paused {
            lastUpdateTimeInterval = currentTime
            
            return
        }
        var timeSinceLast = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        
        /*if let heroMoveDirection = Sprite.heroMoveDirection {
            var moveFacing: CGPoint?
            if let heroFaceLocation = Hero.heroFaceLocation {
                moveFacing = heroFaceLocation
            }
            
            let magnitude = hypotf(Float(heroMoveDirection.dx), Float(heroMoveDirection.dy))
            if  magnitude > 0.0 || moveFacing != nil {
                hero.moveInDirection(heroMoveDirection, withTimeInterval: timeSinceLast, facing: moveFacing)
            }
        }
        else {
            if let heroFaceLocation = player.heroFaceLocation {
                hero.faceToPosition(heroFaceLocation)
            }
            
            if player.moveForward {
                hero.moveInMoveDirection(.Forward, withTimeInterval: timeSinceLast)
            }
            else if player.moveBackward {
                hero.moveInMoveDirection(.Back, withTimeInterval: timeSinceLast)
            }
            
            if player.moveLeft {
                hero.moveInMoveDirection(.Left, withTimeInterval: timeSinceLast)
            }
            else if player.moveRight {
                hero.moveInMoveDirection(.Right, withTimeInterval: timeSinceLast)
            }
        }*/
    }
    func didBeginContact(contact: SKPhysicsContact) {
        print("Testing Contact")
        if let character = contact.bodyA.node as? Sprite {
            character.collidedWith(contact.bodyB)
        }
        
        if let character = contact.bodyB.node as? Sprite {
            character.collidedWith(contact.bodyA)
        }
        /*
        let rawProjectileType = ColliderType.LineEnemy.rawValue
        let bodyAIsProjectile = contact.bodyA.categoryBitMask & rawProjectileType == rawProjectileType
        let bodyBIsProjectile = contact.bodyB.categoryBitMask & rawProjectileType == rawProjectileType
        
        if bodyAIsProjectile || bodyBIsProjectile {
            // Conditionally set `bodyA` as the projectile; if it isn't then `bodyB` is the projectile.
            print("CONTACT")
        }*/

    }
    func startLevel() {
        
        //configureGameControllers()
    }
    
    /*func addHeroForPlayer() -> Hero {
        var hero: Hero
        heroes.append(hero)
        
        return hero
    }
    func configureGameControllers() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "gameControllerDidConnect:", name: GCControllerDidConnectNotification, object: nil)
        notificationCenter.addObserver(self, selector: "gameControllerDidDisconnect:", name: GCControllerDidDisconnectNotification, object: nil)
        
        configureConnectedGameControllers()
        
        GCController.startWirelessControllerDiscoveryWithCompletionHandler(nil)
    }
    func configureConnectedGameControllers() {
        let gameControllers = GCController.controllers() as! [GCController]
        
        for controller in gameControllers {
            let playerIndex = controller.playerIndex
            if playerIndex == GCControllerPlayerIndexUnset {
                continue
            }
            
            assignPresetController(controller, toIndex: playerIndex)
        }
        
        for controller in gameControllers {
            let playerIndex = controller.playerIndex
            if playerIndex != GCControllerPlayerIndexUnset {
                continue
            }
            
            assignUnknownController(controller)
        }
    }
    func gameControllerDidConnect(notification: NSNotification) {
        let controller = notification.object as! GCController
        let playerIndex = controller.playerIndex
        if playerIndex == GCControllerPlayerIndexUnset {
            assignUnknownController(controller)
        }
        else {
            assignPresetController(controller, toIndex: playerIndex)
        }
    }
    
    func assignUnknownController(controller: GCController) {
        // Specifically declare `player` as mutable so that we can reassign it while processing.

            configureController(controller)
            return
        
    }
    
    func assignPresetController(controller: GCController, toIndex index: Int) {
        
        configureController(controller)
    }
    
    func configureController(controller: GCController) {
        Hero.controller = controller
        
        let directionPadMoveHandler: GCControllerDirectionPadValueChangedHandler = { dpad, x, y in
            let length = hypotf(x, y)
            if length > 0.0 {
                let inverseLength = 1 / length
                Hero.heroMoveDirection = CGVector(dx: CGFloat(x * inverseLength), dy: CGFloat(y * inverseLength))
            }
            else {
                Hero.heroMoveDirection = CGVector(dx: 0, dy: 0)
            }
        }
        
        let rightThumbstickHandler: GCControllerDirectionPadValueChangedHandler = { dpad, x, y in
            let length = hypotf(x, y)
            if length <= 0.5 {
                player.heroFaceLocation = nil
                return
            }
            
            let point = CGPoint(x: CGFloat(x), y: CGFloat(y))
            player.heroFaceLocation = point
        }
        
        controller.extendedGamepad?.leftThumbstick.valueChangedHandler = directionPadMoveHandler
        controller.extendedGamepad?.rightThumbstick.valueChangedHandler = rightThumbstickHandler
        controller.gamepad?.dpad.valueChangedHandler = directionPadMoveHandler
        
    }*/
}
