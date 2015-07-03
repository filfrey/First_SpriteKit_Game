//
//  Hero.swift
//  First_SpriteKit_Game
//
//  Created by Jeffrey Lin on 6/23/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import Foundation
import SpriteKit // Needed to create SKSpriteNode


class Hero : Sprite, SharedAssets{ // Needs a initalizer in order to work
    
    var emit = false
    var emitFrameCount = 0
    var maxEmitFrameCount = 30
    
    var heroSpriteNode = SKSpriteNode(imageNamed: "white")
    // Have to eventually add the creation of hero her instead of Game Scene
    
    
    init(guy:SKSpriteNode, particles:SKEmitterNode){
        super.init(speed: 5,guy: heroSpriteNode)
    }
    
    static func loadSharedAssets(){
        
    }
}