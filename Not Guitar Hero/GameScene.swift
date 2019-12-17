//
//  GameScene.swift
//  Not Guitar Hero
//
//  Created by Matt Luke on 12/16/19.
//  Copyright © 2019 MlukeApps. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var redButton = SKSpriteNode()
    var yellowButton = SKSpriteNode()
    var greenButton = SKSpriteNode()
    var blueButton = SKSpriteNode()
    var redNote = SKSpriteNode()
   
    func makeNote()
    {
        redNote = SKSpriteNode(imageNamed: "RedNote")
        redNote.position = CGPoint(x: 0, y: 0)
        redNote.name = "
    }
    
    func createAIPaddle()
    {
        aiPaddle = SKSpriteNode(color: .green, size: CGSize(width: 200, height: 50))
        aiPaddle.position = CGPoint(x: frame.width * 0.5, y: frame.height * 0.87)
        aiPaddle.name = "AIPaddle"
        addChild(aiPaddle)
        
        aiPaddle.physicsBody = SKPhysicsBody(rectangleOf: aiPaddle.frame.size)
        aiPaddle.physicsBody?.allowsRotation = false
        aiPaddle.physicsBody?.friction = 0
        aiPaddle.physicsBody?.affectedByGravity = false
        aiPaddle.physicsBody?.isDynamic = false
        aiPaddle.physicsBody?.restitution = 1.1
        
        run( SKAction.repeatForever(
                SKAction.sequence([SKAction.run(followBall),SKAction.wait(forDuration: 0.3)])
            ))
    }
    
}
