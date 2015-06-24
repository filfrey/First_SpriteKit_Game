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
    var touchLocation = CGFloat()
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
        addEnemies()
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.position.y = -(self.size.height/4)
        addChild(scoreLabel)
        addChild(countDownText)
        addChild(reset)
        countDownText.hidden = true
        reset.name = "reset"
        reset.hidden = true
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        hero.emit = true
        gameOver = true
        reset.hidden = false
        println("Collided")
    }
    
    func restartGame(){
        countDownText.hidden = false
        hero.guy.position.y=0
        hero.guy.position.x=0
        reset.hidden = true
        score = 0
        scoreLabel.text = "0"
        for enemySprite in enemySprites {
            resetEnemySprite(enemySprite.guy, yPos: enemySprite.yPos)
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
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
        let white = SKSpriteNode(imageNamed: "white") // Creates the Consant white(player)
        white.physicsBody = SKPhysicsBody(circleOfRadius: white.size.width/2)
        white.physicsBody!.affectedByGravity = false
        white.physicsBody!.categoryBitMask = ColliderType.Hero.rawValue
        white.physicsBody!.contactTestBitMask = ColliderType.EnemySprite.rawValue
        white.physicsBody!.collisionBitMask = ColliderType.EnemySprite.rawValue
        let heroParticles = SKEmitterNode(fileNamed: "HitParticle.sks")
        heroParticles.hidden = true
        hero = Hero(guy:white, particles: heroParticles)// Creates a new Hero object called hero
        white.addChild(heroParticles)
        addChild(white)                  // Adds the newly created hero
    }
    
    func addEnemies(){
        addEnemy(named: "red", speed: 1, yPos: self.size.height / 4)
        addEnemy(named: "yellow", speed: 1.5, yPos: 0)
        addEnemy(named: "blue", speed: 3, yPos: -self.size.height / 4)
    }
    
    func addEnemy(#named:String, speed:Float, yPos:CGFloat){
        var enemySpriteNode = SKSpriteNode(imageNamed: named)
        
        enemySpriteNode.physicsBody = SKPhysicsBody(circleOfRadius: enemySpriteNode.size.width/2)
        enemySpriteNode.physicsBody!.affectedByGravity = false
        enemySpriteNode.physicsBody!.categoryBitMask = ColliderType.EnemySprite.rawValue
        enemySpriteNode.physicsBody!.contactTestBitMask = ColliderType.Hero.rawValue
        
        var enemySprite = EnemySprite(speed: speed, guy: enemySpriteNode)
        enemySprites.append(enemySprite)
        resetEnemySprite(enemySpriteNode, yPos: yPos)
        enemySprite.yPos = enemySpriteNode.position.y
        addChild(enemySpriteNode)
        
    }
    
    func resetEnemySprite(enemySpriteNode:SKSpriteNode, yPos:CGFloat){
        enemySpriteNode.position.x = endOfScreenRight
        enemySpriteNode.position.y = yPos
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            if !gameOver{               // Only if use did not lose
                touchLocation = (touch.locationInView(self.view!).y * -1) + (self.size.height/2)
                // Get the location in view for y coordinate  // The size of the screen
            }
            else {
                let location = touch.locationInNode(self)
                var sprites = nodesAtPoint((location))
                for sprite in sprites {
                    if let spriteNode = sprite as? SKSpriteNode{
                        if spriteNode.name != nil{
                            if spriteNode.name == "reset"{
                                restartGame()
                            }
                        }
                    }
                }
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
        if !gameOver{
            updateEnemySpritePositions()
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
    
    func updateEnemySpritePositions(){
        for enemySprite in enemySprites {
            if !enemySprite.moving{
                enemySprite.currentFrame++
                if enemySprite.currentFrame > enemySprite.randomFrame{
                    enemySprite.moving = true
                }
            }
            else{
                enemySprite.guy.position.y = CGFloat(Double(enemySprite.guy.position.y) + sin(enemySprite.angle) * enemySprite.range)
                enemySprite.angle += hero.speed
                if enemySprite.guy.position.x > endOfScreenLeft {
                    
                    enemySprite.guy.position.x -= CGFloat(enemySprite.speed)
                }
                else{
                    enemySprite.guy.position.x = endOfScreenRight
                    enemySprite.currentFrame = 0
                    enemySprite.setRandomFrame()
                    enemySprite.moving = false
                    enemySprite.range += 0.1
                    updateScore()
                }
            }
        }
    }
    func updateScore(){
        score++
        scoreLabel.text = String(score)
    }
}
