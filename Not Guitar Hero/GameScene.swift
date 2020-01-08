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
    var scoreLabel = SKLabelNode()
    var streakLabel = SKLabelNode()
    var missedLabel = SKLabelNode()
    
    var gameSpeed = 3.0
    var score = 0
    {
        didSet
        {
            switch score {
            case 10...19:
                gameSpeed = 2.75
            case 20...29:
                gameSpeed = 2.5
            case 30...39:
                gameSpeed = 2.25
            case 40...49:
                gameSpeed = 2.0
            default:
               gameSpeed = 3
            }
            
        }
    }
    
    var streak = 0
    {
        didSet
        {
            streakLabel = self.childNode(withName: "streakLabel") as! SKLabelNode
            streakLabel.text = "\(streak)"
        }
    }
    
    var missed = 0
    {
        didSet
        {
            missedLabel = self.childNode(withName: "missedLabel") as! SKLabelNode
            missedLabel.text = "Missed: \(missed) / 10"
            streak = 0
            
            if missed == 10
            {
                score = 0
                missed = 0
                scoreLabel.text = "Score: 0"
                missedLabel.text = "Missed: 0 / 10"
                
                let titleScreen = GameScene(fileNamed: "TitleScreen")
                titleScreen?.scaleMode = .aspectFill
                let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
                view?.presentScene(titleScreen!, transition: reveal)
            }
        }
    }
    
    var notes: [SKSpriteNode] = [SKSpriteNode]()
    
    
    
    override func didMove(to view: SKView) {
        
        
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0.0
        self.physicsBody = borderBody
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        redButton = self.childNode(withName: "redButton") as! SKSpriteNode
        blueButton = self.childNode(withName: "blueButton") as! SKSpriteNode
        greenButton = self.childNode(withName: "greenButton") as! SKSpriteNode
        yellowButton = self.childNode(withName: "yellowButton") as! SKSpriteNode
        
        makeDeleteTrigger()
        
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(makeNote), userInfo: nil, repeats: true)
        
    }
    
    func addScore()
    {
        score += 1
        streak += 1
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "Score: \(score)"
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        
        
        
        if redButton.frame.contains(location)
        {
            // touched red button
            for i in 0..<notes.count
//            for note in notes
            {
                let note = notes[i]
                if note.frame.contains(location)
                {
                    note.removeFromParent()
                    notes.remove(at: i)
                    print("remove red note")
                    addScore()
                    break
                }
            }
        }
        if blueButton.frame.contains(location)
        {
            // touched blue button
            for i in 0..<notes.count
            {
                
                let note = notes[i]
                if note.frame.contains(location)
                {
                    note.removeFromParent()
                    notes.remove(at: i)
                    print("remove blue note")
                    addScore()
                    break
                }
            }
        }
        
        if yellowButton.frame.contains(location)
        {
            // touched yellow button
            for i in 0..<notes.count
            {
                let note = notes[i]
                if note.frame.contains(location)
                {
                    note.removeFromParent()
                    notes.remove(at: i)
                    print("remove yellow note")
                    addScore()
                    break
                }
            }
        }
        
        if greenButton.frame.contains(location)
        {
            // touched green button
            for i in 0..<notes.count
            {
                let note = notes[i]
                if note.frame.contains(location)
                {
                    note.removeFromParent()
                    notes.remove(at: i)
                    print("remove green note")
                    addScore()
                    break
                }
            }
        }
//        if redNote.frame.contains(CGPoint(x: -240, y: -560))
//        {
//            if redButton.frame.contains(CGPoint(x: -240, y: -560))
//
//            {
//                redNote.removeFromParent()
//                print("cool")
//            }
//        }
        
    }
    
    
    
    func deleteNote()
    {
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        
    if (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 3) || (contact.bodyB.categoryBitMask == 2 && contact.bodyA.categoryBitMask == 3)
      {
     
        if contact.bodyB.node == deleteTrigger
        {
            // rmeove note from array
//            for note in notes
//              {
//                  if contact.bodyB.node == note
//                  {
//                    notes.remove(at: <#T##Int#>)
//                  }
//              }
            contact.bodyA.node?.removeFromParent()
            missed += 1
  
            
        }
        else
        {
            contact.bodyB.node?.removeFromParent()
            missed += 1
        }
        
      }
       
    }
    
    func makeDeleteTrigger()
    {
        deleteTrigger = SKSpriteNode(color: .red, size: CGSize(width: frame.width, height: 50))
//        deleteTrigger.position = CGPoint(x: 0, y: -frame.height/2 - 20)
        deleteTrigger.position = CGPoint(x: 0, y: -900)
        deleteTrigger.physicsBody = SKPhysicsBody(rectangleOf: deleteTrigger.frame.size)
        //deleteTrigger.physicsBody!.isDynamic = false
        deleteTrigger.name = "DeleteTrigger"
        deleteTrigger.physicsBody?.categoryBitMask = 2
        deleteTrigger.physicsBody?.contactTestBitMask = 3
//        deleteTrigger.physicsBody?.isDynamic = true
        deleteTrigger.physicsBody?.pinned = true
        deleteTrigger.physicsBody?.allowsRotation = false

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
            redNote.position = CGPoint(x: -240, y: 800)
            redNote.name = "RedNote"
            
            addChild(redNote)
            
            redNote.physicsBody = SKPhysicsBody(rectangleOf: redNote.frame.size)
            redNote.physicsBody?.usesPreciseCollisionDetection = true
            redNote.physicsBody!.isDynamic = false
            redNote.physicsBody?.categoryBitMask = 3
            
            let moveDown = SKAction.moveTo(y: -800, duration: TimeInterval(gameSpeed))
            let removeSprite = SKAction.run {
 //               self.redNote.removeFromParent()
            }
            let sequence = SKAction.sequence([moveDown, removeSprite])
            
            redNote.run(sequence)
            
            notes.append(redNote)

        }
        else if number == 2
        {
            
            
            yellowNote = SKSpriteNode(imageNamed: "YellowNote")
            yellowNote.size = CGSize(width: 160, height: 160)
            yellowNote.position = CGPoint(x: -80, y: 800)
            yellowNote.name = "YellowNote"

            addChild(yellowNote)
            
           yellowNote.physicsBody = SKPhysicsBody(rectangleOf: yellowNote.frame.size)
           yellowNote.physicsBody?.usesPreciseCollisionDetection = true
           yellowNote.physicsBody!.isDynamic = false
           yellowNote.physicsBody?.categoryBitMask = 3
            
            let moveDown = SKAction.moveTo(y: -800, duration: TimeInterval(gameSpeed))
            let removeSprite = SKAction.run {
//                self.yellowNote.removeFromParent()
            }
            let sequence = SKAction.sequence([moveDown, removeSprite])
            
            yellowNote.run(sequence)
            notes.append(yellowNote)

        }
        else if number == 3
        {
            
            
            greenNote = SKSpriteNode(imageNamed: "GreenNote")
            greenNote.size = CGSize(width: 160, height: 160)
            greenNote.position = CGPoint(x: 80, y: 800)
            greenNote.name = "GreenNote"

                       addChild(greenNote)
            
            greenNote.physicsBody = SKPhysicsBody(rectangleOf: greenNote.frame.size)
            greenNote.physicsBody?.usesPreciseCollisionDetection = true
            greenNote.physicsBody!.isDynamic = false
            greenNote.physicsBody?.categoryBitMask = 3
            
            let moveDown = SKAction.moveTo(y: -800, duration: TimeInterval(gameSpeed))
            let removeSprite = SKAction.run {
//                self.greenNote.removeFromParent()
            }
            let sequence = SKAction.sequence([moveDown, removeSprite])
            
            greenNote.run(sequence)
            notes.append(greenNote)

        }
        else if number == 4
        {
            
            
            blueNote = SKSpriteNode(imageNamed: "BlueNote")
            blueNote.size = CGSize(width: 160, height: 160)
            blueNote.position = CGPoint(x: 240, y: 800)
            blueNote.name = "BlueNote"
            
            addChild(blueNote)
            
            blueNote.physicsBody = SKPhysicsBody(rectangleOf: blueNote.frame.size)
            blueNote.physicsBody?.usesPreciseCollisionDetection = true
            blueNote.physicsBody!.isDynamic = false
            blueNote.physicsBody?.categoryBitMask = 3
            
            let moveDown = SKAction.moveTo(y: -800, duration: TimeInterval(gameSpeed))
            let removeSprite = SKAction.run {
//                self.blueNote.removeFromParent()
            }
            let sequence = SKAction.sequence([moveDown, removeSprite])
            
            blueNote.run(sequence)
            notes.append(blueNote)

        }
        
    }
    
}
