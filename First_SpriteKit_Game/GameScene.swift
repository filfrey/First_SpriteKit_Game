//
//  GameScene.swift
//  First_SpriteKit_Game
//
//  Created by Jeffrey Lin on 6/20/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var hero:Hero!
    var touchLocation = CGFloat()
    var gameOver = false
    
    override func didMoveToView(view: SKView) {
        addBG()
        addWhite()
    }
    
    func addBG() {
        let bg = SKSpriteNode(imageNamed:"bg") // Creates Constant bg
        addChild(bg)                           // Adds the created bg
    }
    
    func addWhite(){ // Creates the User sprite
        let white = SKSpriteNode(imageNamed: "white") // Creates the Consant white(player)
        hero = Hero(guy:white)           // Creates a new Hero object called hero
        addChild(white)                  // Adds the newly created hero
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            if !gameOver{               // Only if use did not lose
                touchLocation = (touch.locationInView(self.view!).y * -1) + (self.size.height/2)
                // Get the location in view for y coordinate  // The size of the screen
            }
        }
        
        let moveAction = SKAction.moveToY(touchLocation, duration: 0.5)  // This makes it move smoothly
        moveAction.timingMode = SKActionTimingMode.EaseOut               // By easing the movement
        hero.guy.runAction(moveAction){
            // Add something here if we want the guy to do something afterwards
        }
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
