//
//  GameScene.swift
//  Not Like You
//
//  Created by Jeffrey Lin on 6/20/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var hero:Hero!
    var touchLocation = CGPoint()
    var gameOver = false
    var enemySprites:[Sprite] = []
    var endOfScreenRight = CGFloat()
    var endOfScreenLeft = CGFloat()
    var endOfScreenTop = CGFloat()
    var endOfScreenBottom = CGFloat()
    var score = 0
    var scoreLabel = SKLabelNode()
    var reset = SKSpriteNode(imageNamed: "reset")
    var timer = NSTimer()
    var countDownText = SKLabelNode(text: "5")
    var countDown = 5
    var money = 0
    var moneyText = SKLabelNode(text: "Money: ")
    let white = SKSpriteNode(imageNamed: "white") // Creates the Consant white(player)
    
    
    enum ColliderType:UInt32{
        case Hero        = 1
        case EnemySprite = 2
        case PowerUps    = 3
    }
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.contactDelegate = self
        endOfScreenLeft = (self.size.width / 2 ) * CGFloat(-1)
        endOfScreenRight =  self.size.width / 2
        endOfScreenTop =  self.size.height / 2
        endOfScreenBottom =  self.size.height / 2 * -1
        addBG()
        addWhite()
        //6-26 addEnemies()
        scoreLabel = SKLabelNode(text: "0")
        scoreLabel.position.y = -(self.size.height/4)
        countDownText.position.y += 20
        moneyText.fontColor = SKColor.redColor()
        moneyText.position = CGPoint(x:endOfScreenLeft+32, y:endOfScreenTop-20)
        moneyText.fontSize = 20
        addChild(scoreLabel)
        addChild(countDownText)
        addChild(moneyText)
        addChild(reset)
        countDownText.hidden = true
        reset.name = "reset"
        reset.hidden = true
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var mask = contact.bodyB.categoryBitMask

        if(contact.bodyA.categoryBitMask == ColliderType.Hero.rawValue){
            mask = contact.bodyB.categoryBitMask
        }
        else if(contact.bodyB.categoryBitMask == ColliderType.Hero.rawValue){
            mask = contact.bodyA.categoryBitMask
        }
        else{return}
        if(mask == ColliderType.PowerUps.rawValue){
            money++
            moneyText.text = String(money)
        }
        else{
            print(contact.bodyB.categoryBitMask)
            hero.emit = true
            gameOver = true
            reset.hidden = false
        }
    }
    
    func restartGame(){
        countDownText.hidden = false
        reset.hidden = true
        score = 0
        scoreLabel.text = "0"
        var int = 0
        while !enemySprites.isEmpty {
            enemySprites.last?.guy.removeFromParent()
            enemySprites.removeLast()
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
            countDown = 3
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
        print("WHAT?")
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
    
    func addNewEnemy(){
        var newEnemySprite : Sprite
        var random = arc4random_uniform(3)
        if random == 1{
            newEnemySprite = WavyEnemy(screen : self.size.width / 2)
        }
        else if random == 2{
            newEnemySprite = LineEnemy(screen : self.size.width / 2)
        }
        else {
            newEnemySprite = CoinSprite(screen : self.size.width / 2)
        }
        enemySprites.append(newEnemySprite)
        addChild(newEnemySprite.getSpriteNode())
    }
    
    /*func resetEnemySprite(enemySpriteNode:SKSpriteNode, yPos:CGFloat){
        enemySpriteNode.position.x = endOfScreenRight
        enemySpriteNode.position.y = yPos
        println("reset x and Y position for sprite")
    }*/
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            if !gameOver{
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
                        if spriteNode.name == "reset" && !reset.hidden{
                            restartGame()
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
            if (enemySprites.count < 5){
                addNewEnemy()
            }
            if (arc4random_uniform(75) == 1 && enemySprites.count < 10){
                addNewEnemy()
            }
            for  index = 0; index < enemySprites.count; ++index {
                if enemySprites[index].guy.position.x < endOfScreenLeft ||
                   enemySprites[index].guy.position.x > endOfScreenRight {
                    enemySprites[index].guy.removeAllChildren()
                    enemySprites[index].guy.removeFromParent()
                    enemySprites.removeAtIndex(index)
                    updateScore()
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
            //hero.particles.hidden = false
        }
        else{
            hero.emit = false
            //hero.particles.hidden = true
            hero.emitFrameCount = 0
        }
    }
    
    func updateScore(){
        score++
        scoreLabel.text = String(score)
    }
}
