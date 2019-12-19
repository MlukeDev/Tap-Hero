//
//  GameScene.swift
//  Not Guitar Hero
//
//  Created by Matt Luke on 12/16/19.
//  Copyright © 2019 MlukeApps. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var redButton = SKSpriteNode()
    var yellowButton = SKSpriteNode()
    var greenButton = SKSpriteNode()
    var blueButton = SKSpriteNode()
    var redNote = SKSpriteNode()
    var yellowNote = SKSpriteNode()
    var greenNote = SKSpriteNode()
    var blueNote = SKSpriteNode()
    var timer: Timer?
    var deleteTrigger = SKSpriteNode()
    
    
    
    override func didMove(to view: SKView) {
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0.0
        self.physicsBody = borderBody
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        redButton.physicsBody?.categoryBitMask = 1
        yellowButton.physicsBody?.categoryBitMask = 1
        greenButton.physicsBody?.categoryBitMask = 1
        blueButton.physicsBody?.categoryBitMask = 1

        
        
//        redNote.physicsBody?.contactTestBitMask = 3
//        yellowNote.physicsBody?.contactTestBitMask = 3
//        greenNote.physicsBody?.contactTestBitMask = 3
//        blueNote.physicsBody?.contactTestBitMask = 3
        
        deleteTrigger.physicsBody?.contactTestBitMask = 2
        
        //        set the size and position of the node
        
        makeDeleteTrigger()
        
        deleteTrigger.physicsBody?.categoryBitMask = 3
        
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(makeNote), userInfo: nil, repeats: true)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        print("yo")
        
    if (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 3) || (contact.bodyB.categoryBitMask == 2 && contact.bodyA.categoryBitMask == 3)
      {
     
        if contact.bodyA.node == deleteTrigger || contact.bodyB.node == deleteTrigger
        {
            print("touched")
        }
        
      }
       
    }
    
    func makeDeleteTrigger()
    {
        deleteTrigger = SKSpriteNode(color: .red, size: CGSize(width: frame.width, height: 50))
        deleteTrigger.position = CGPoint(x: 0, y: -640)
        deleteTrigger.physicsBody = SKPhysicsBody(rectangleOf: deleteTrigger.frame.size)
        deleteTrigger.physicsBody!.isDynamic = false
        deleteTrigger.name = "DeleteTrigger"
        addChild(deleteTrigger)
        print("Delete Trigger Made")
    }
    
    @objc func makeNote()
    {
        
        let number = Int.random(in: 1...4)
        if number == 1
        {
            
            
            redNote = SKSpriteNode(imageNamed: "RedNote")
            redNote.size = CGSize(width: 160, height: 160)
            redNote.position = CGPoint(x: -270, y: 800)
            redNote.name = "RedNote"
            
            addChild(redNote)
            
            redNote.physicsBody = SKPhysicsBody(rectangleOf: redNote.frame.size)
            redNote.physicsBody?.usesPreciseCollisionDetection = true
            redNote.physicsBody!.isDynamic = false
            redNote.physicsBody?.categoryBitMask = 2
            
            let moveDown = SKAction.moveTo(y: -800, duration: 1)
            let removeSprite = SKAction.run {
 //               self.redNote.removeFromParent()
            }
            let sequence = SKAction.sequence([moveDown, removeSprite])
            
            redNote.run(sequence)

        }
        else if number == 2
        {
            
            
            yellowNote = SKSpriteNode(imageNamed: "YellowNote")
            yellowNote.size = CGSize(width: 160, height: 160)
            yellowNote.position = CGPoint(x: -90, y: 800)
            yellowNote.name = "YellowNote"

            addChild(yellowNote)
            
           yellowNote.physicsBody = SKPhysicsBody(rectangleOf: yellowNote.frame.size)
           yellowNote.physicsBody?.usesPreciseCollisionDetection = true
           yellowNote.physicsBody!.isDynamic = false
           yellowNote.physicsBody?.categoryBitMask = 2
            
            let moveDown = SKAction.moveTo(y: -800, duration: 1)
            let removeSprite = SKAction.run {
//                self.yellowNote.removeFromParent()
            }
            let sequence = SKAction.sequence([moveDown, removeSprite])
            
            yellowNote.run(sequence)

        }
        else if number == 3
        {
            
            
            greenNote = SKSpriteNode(imageNamed: "GreenNote")
            greenNote.size = CGSize(width: 160, height: 160)
            greenNote.position = CGPoint(x: 90, y: 800)
            greenNote.name = "GreenNote"

                       addChild(greenNote)
            
            greenNote.physicsBody = SKPhysicsBody(rectangleOf: greenNote.frame.size)
            greenNote.physicsBody?.usesPreciseCollisionDetection = true
            greenNote.physicsBody!.isDynamic = false
            greenNote.physicsBody?.categoryBitMask = 2
            
            let moveDown = SKAction.moveTo(y: -800, duration: 1)
            let removeSprite = SKAction.run {
//                self.greenNote.removeFromParent()
            }
            let sequence = SKAction.sequence([moveDown, removeSprite])
            
            greenNote.run(sequence)

        }
        else if number == 4
        {
            
            
            blueNote = SKSpriteNode(imageNamed: "BlueNote")
            blueNote.size = CGSize(width: 160, height: 160)
            blueNote.position = CGPoint(x: 270, y: 800)
            blueNote.name = "BlueNote"
            
            addChild(blueNote)
            
            blueNote.physicsBody = SKPhysicsBody(rectangleOf: blueNote.frame.size)
            blueNote.physicsBody?.usesPreciseCollisionDetection = true
            blueNote.physicsBody!.isDynamic = false
            blueNote.physicsBody?.categoryBitMask = 2
            
            let moveDown = SKAction.moveTo(y: -800, duration: 1)
            let removeSprite = SKAction.run {
//                self.blueNote.removeFromParent()
            }
            let sequence = SKAction.sequence([moveDown, removeSprite])
            
            blueNote.run(sequence)

        }
        
    }
    
}
