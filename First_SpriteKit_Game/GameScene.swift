//
//  GameScene.swift
//  First_SpriteKit_Game
//
//  Created by Jeffrey Lin on 6/20/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var hero:Hero!
    var touchLocation = CGPoint()
    var gameOver = false
    var enemySprites:[EnemySprite] = []
    var endOfScreenRight = CGFloat()
    var endOfScreenLeft = CGFloat()
    var score = 0
    var scoreLabel = SKLabelNode()
    var reset = SKSpriteNode(imageNamed: "reset")
    var timer = NSTimer()
    var countDownText = SKLabelNode(text: "5")
    var countDown = 5
    let white = SKSpriteNode(imageNamed: "white") // Creates the Consant white(player)
    
    enum ColliderType:UInt32{
        case Hero = 1
        case EnemySprite = 2
    }
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        endOfScreenLeft = (self.size.width / 2 ) * CGFloat(-1)
        endOfScreenRight =  self.size.width / 2
        
        addBG()
        addWhite()
        //6-26 addEnemies()
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.position.y = -(self.size.height/4)
        addChild(scoreLabel)
        addChild(countDownText)
        addChild(reset)
        countDownText.hidden = true
        reset.name = "reset"
        reset.hidden = true
        println("Init View")
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        hero.emit = true
        gameOver = true
        reset.hidden = false
        println("Collided")
    }
    
    func restartGame(){
        countDownText.hidden = false
        reset.hidden = true
        score = 0
        scoreLabel.text = "0"
        for enemySprite in enemySprites {
            resetEnemySprite(enemySprite.guy, yPos: enemySprite.yPos)
        }
        var origin = CGPoint(x: 0, y: 0)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)

        hero.guy.position.y=0
        hero.guy.position.x=0
        hero.guy.removeAllActions()
        println("Restarting Game")
    }
    
    func updateTimer() {
        if countDown > 0 {
            countDown--
            countDownText.text = String(countDown)
        }
        else {
            countDown = 5
            countDownText.text = String(countDown)
            countDownText.hidden = true
            gameOver = false
            timer.invalidate()
        }
    }
    
    func addBG() {
        let bg = SKSpriteNode(imageNamed:"bg") // Creates Constant bg
        addChild(bg)                           // Adds the created bg
    }
    
    func addWhite(){ // Creates the User sprite
        
        white.physicsBody = SKPhysicsBody(circleOfRadius: white.size.width/2)
        white.physicsBody!.affectedByGravity = false
        white.physicsBody!.categoryBitMask = ColliderType.Hero.rawValue
        white.physicsBody!.contactTestBitMask = ColliderType.EnemySprite.rawValue
        white.physicsBody!.collisionBitMask = ColliderType.EnemySprite.rawValue
        let heroParticles = SKEmitterNode(fileNamed: "HitParticle.sks")
        heroParticles.hidden = true
        hero = Hero(guy:white, particles: heroParticles)// Creates a new Hero object called hero
        white.addChild(heroParticles)
        addChild(white)                     // Adds the newly created hero
        println("Add White")
    }
    
    /*func addEnemies(){
        addEnemy(named: "blue", speed: 3, yPos: -self.size.height / 4)
        addNewEnemy("red")
    }
    
    func addEnemy(#named:String, speed:Float, yPos:CGFloat){
        var enemySpriteNode = SKSpriteNode(imageNamed: named)
        
        enemySpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: enemySpriteNode.size.width/2)
        enemySpriteNode.physicsBody!.affectedByGravity = false
        enemySpriteNode.physicsBody!.categoryBitMask = ColliderType.EnemySprite.rawValue
        enemySpriteNode.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
        
        //var enemySprite = EnemySprite(speed: speed,guy: enemySpriteNode)
        var enemySprite = EnemySprite(speed: speed, guy: enemySpriteNode)
        enemySprites.append(enemySprite)
        resetEnemySprite(enemySpriteNode, yPos: yPos)
        enemySprite.yPos = enemySpriteNode.position.y
        addChild(enemySpriteNode)
        print("Adding Enemies")
    }*/
    func addNewEnemy(type : String){
        
        var wavyEnemySpriteNode = SKSpriteNode(imageNamed: type)
        
        wavyEnemySpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: wavyEnemySpriteNode.size.width/2)
        wavyEnemySpriteNode.physicsBody!.affectedByGravity = false
        wavyEnemySpriteNode.physicsBody!.categoryBitMask = ColliderType.EnemySprite.rawValue
        wavyEnemySpriteNode.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
        
        var wavyEnemySprite = WavyEnemy(guy: wavyEnemySpriteNode)
        enemySprites.append(wavyEnemySprite)
        wavyEnemySpriteNode.position.x = endOfScreenRight//removed later
        addChild(wavyEnemySpriteNode)
        
    }
    
    func resetEnemySprite(enemySpriteNode:SKSpriteNode, yPos:CGFloat){
        enemySpriteNode.position.x = endOfScreenRight
        enemySpriteNode.position.y = yPos
        println("reset x and Y position for sprite")
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            if !gameOver{               // Only if use did not lose
                //touchLocation = (touch.locationInView(self.view!).y * -1) + (self.size.height/2)
                // Get the location in view for y coordinate  // The size of the screen
                touchLocation = CGPoint(
                    x:(touch.locationInView(self.view!).x) - (self.size.width/2),
                    y:(touch.locationInView(self.view!).y * -1) + (self.size.height/2)
                    )
            }
            else {
                let location = touch.locationInNode(self)
                var sprites = nodesAtPoint((location))
                for sprite in sprites {
                    if let spriteNode = sprite as? SKSpriteNode{
                        if spriteNode.name != nil{
                            if (spriteNode.name == "reset" && !reset.hidden){
                                restartGame()
                            }
                        }
                    }
                }
            }
        }
        
        // This makes it move smoothly
        let moveAction = SKAction.moveTo(touchLocation, duration: 0.5)
        if !gameOver{
            hero.guy.runAction(moveAction){}
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        var index = 0
        if !gameOver{
            if (enemySprites.count < 3){
                addNewEnemy("green")
                addNewEnemy("gray")
                println("Adding New Enemy")
            }
            for  index = 0; index < enemySprites.count; ++index {
                if enemySprites[index].guy.position.x < endOfScreenLeft {
                    enemySprites[index].guy.removeAllChildren()
                    enemySprites[index].guy.removeFromParent()
                    enemySprites.removeAtIndex(index)
                    updateScore()
                    print("DEAD")
                }
                else{
                    enemySprites[index].motion()
                }
            }
        }
        updateHeroEmitter()
    }
    
    func updateHeroEmitter(){
        if hero.emit && hero.emitFrameCount < hero.maxEmitFrameCount{
            hero.emitFrameCount++
            hero.particles.hidden = false
        }
        else{
            hero.emit = false
            hero.particles.hidden = true
            hero.emitFrameCount = 0
        }
    }
    
    func updateScore(){
        score++
        scoreLabel.text = String(score)
    }
}
