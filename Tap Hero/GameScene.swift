//
//  GameScene.swift
//  Tap Hero
//
//  Created by Matt Luke on 12/16/19.
//  Copyright © 2019 MlukeApps. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let defaults = UserDefaults.standard
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
    var highScoreLabel = SKLabelNode()
    var homeButton = SKLabelNode()
    var location = CGPoint()
    var touchedLocation = SKSpriteNode()
    
    var notes: [SKSpriteNode] = [SKSpriteNode]()
    
    var difficulty = 1.0
    var highScore = 0
    var gameSpeed = 3.0
    var highStreak = 0
    
    var score = 0
    {
        didSet
        {
            setHighScore()
            varySpeed()
        }
    }
    
    var streak = 0
    {
        didSet
        {
            setHighStreak()
        }
    }
    
    var missed = 0
    {
        didSet
        {
            missedLabel = self.childNode(withName: "missedLabel") as! SKLabelNode
            missedLabel.text = "Missed: \(missed) / 10"
            streak = 0
            
            gameOverCheck()
        }
    }
    
    override func didMove(to view: SKView)
    {
        definePhysics()
        setDefaults()
        setUpNodes()
        makeDeleteTrigger()
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(difficulty), target: self, selector: #selector(makeNote), userInfo: nil, repeats: true)
    }
    
    func addScore()
    {
        score += 1
        streak += 1
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        scoreLabel.text = "Score: \(score)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        location = touches.first!.location(in: self)
        
        deleteNote()
        
       
        if homeButton.frame.contains(location)
        {
            let titleScreen = TitleScreen(fileNamed: "TitleScreen")
            titleScreen?.scaleMode = .aspectFill
            let reveal = SKTransition.push(with: SKTransitionDirection.up, duration: 0.5)
            view?.presentScene(titleScreen!, transition: reveal)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
    if (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 3) || (contact.bodyB.categoryBitMask == 2 && contact.bodyA.categoryBitMask == 3)
      {
        if contact.bodyB.node == deleteTrigger
        {
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
    
    func deleteNote()
    {
        if redButton.frame.contains(location) || blueButton.frame.contains(location) || yellowButton.frame.contains(location) || greenButton.frame.contains(location)
        {
            for i in 0..<notes.count
            {
                let note = notes[i]
                if note.frame.contains(location)
                {
                    note.removeFromParent()
                    notes.remove(at: i)
                    addScore()
                    break
                }
            }
        }
    }
    
    func definePhysics()
    {
          let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
          borderBody.friction = 0.0
          self.physicsBody = borderBody
          physicsWorld.gravity = CGVector(dx: 0, dy: 0)
          physicsWorld.contactDelegate = self
    }
    
    func setDefaults()
    {
        
       difficulty = defaults.double(forKey: "difficulty")
        
       if difficulty == 1.0
       {
           highScore = defaults.integer(forKey: "easyHighScore")
           highStreak = defaults.integer(forKey: "easyHighStreak")
       }
       else if difficulty == 0.5
       {
           highScore = defaults.integer(forKey: "mediumHighScore")
           highStreak = defaults.integer(forKey: "mediumHighStreak")
       }
       else if difficulty == 0.25
       {
           highScore = defaults.integer(forKey: "hardHighScore")
           highStreak = defaults.integer(forKey: "hardHighStreak")
       }
       else
       {
           highScore = defaults.integer(forKey: "easyHighScore")
           highStreak = defaults.integer(forKey: "easyHighStreak")
       }
    }
    
    func makeDeleteTrigger()
    {
        deleteTrigger = SKSpriteNode(color: .red, size: CGSize(width: frame.width, height: 50))
        deleteTrigger.position = CGPoint(x: 0, y: -900)
        deleteTrigger.physicsBody = SKPhysicsBody(rectangleOf: deleteTrigger.frame.size)
        deleteTrigger.name = "DeleteTrigger"
        deleteTrigger.physicsBody?.categoryBitMask = 2
        deleteTrigger.physicsBody?.contactTestBitMask = 3
        deleteTrigger.physicsBody?.pinned = true
        deleteTrigger.physicsBody?.allowsRotation = false
        addChild(deleteTrigger)
    }
    
    func gameOverCheck()
    {
        if missed == 10
        {
            score = 0
            missed = 0
            scoreLabel.text = "Score: 0"
            missedLabel.text = "Missed: 0 / 10"
            
            let titleScreen = GameScene(fileNamed: "TitleScreen")
            titleScreen?.scaleMode = .aspectFill
            let reveal = SKTransition.push(with: SKTransitionDirection.up, duration: 0.5)
            view?.presentScene(titleScreen!, transition: reveal)
        }
    }
    
    func varySpeed()
    {
        switch score {
        case 0...9:
            gameSpeed = 3.0
        case 10...19:
            gameSpeed = 2.75
        case 20...29:
            gameSpeed = 2.5
        case 30...39:
            gameSpeed = 2.25
        case 40...49:
            gameSpeed = 2.0
        case 50...59:
            gameSpeed = 1.75
        case 60...69:
            gameSpeed = 1.5
        case 70...79:
            gameSpeed = 1.25
        case 80...89:
            gameSpeed = 1.0
        case 90...99:
            gameSpeed = 0.75
        default:
            gameSpeed = 0.5
        }
    }
    
    func setUpNodes()
    {
        homeButton = self.childNode(withName: "homeButton") as! SKLabelNode
        highScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
        highScoreLabel.text = "High Score: \(highScore)"
        redButton = self.childNode(withName: "redButton") as! SKSpriteNode
        blueButton = self.childNode(withName: "blueButton") as! SKSpriteNode
        greenButton = self.childNode(withName: "greenButton") as! SKSpriteNode
        yellowButton = self.childNode(withName: "yellowButton") as! SKSpriteNode
    }
    
    func setHighScore()
    {
        if highScore < score
        {
            highScoreLabel = self.childNode(withName: "highScoreLabel") as! SKLabelNode
            highScore = score
            defaults.set(highScore, forKey: "highScore")
            highScoreLabel.text = "High Score: \(highScore)"
            
            if difficulty == 1.0
            {
                defaults.set(highScore, forKey: "easyHighScore")
            }
            else if difficulty == 0.5
            {
                defaults.set(highScore, forKey: "mediumHighScore")
            }
            else if difficulty == 0.25
            {
                defaults.set(highScore, forKey: "hardHighScore")
            }
            else
            {
                defaults.set(highScore, forKey: "easyHighScore")
            }
        }
    }
    
    func setHighStreak()
    {
        if highStreak < streak
        {
            if difficulty == 1.0
            {
                defaults.set(streak, forKey: "easyHighStreak")
                highStreak = streak
            }
            else if difficulty == 0.5
            {
                defaults.set(streak, forKey: "mediumHighStreak")
                highStreak = streak
            }
            else if difficulty == 0.25
            {
                defaults.set(streak, forKey: "hardHighStreak")
                highStreak = streak
            }
            else
            {
                defaults.set(streak, forKey: "easyHighStreak")
                highStreak = streak
            }
        }
        streakLabel = self.childNode(withName: "streakLabel") as! SKLabelNode
        streakLabel.text = "\(streak)"
    }
    
    @objc func makeNote()
    {
        let number = Int.random(in: 1...4)
        var color = redNote
        var image = "RedNote"
        var pos = CGPoint(x: -240, y: 800)
        
        if number == 1
        {
            color = redNote
            image = "RedNote"
            pos = CGPoint(x: -240, y: 800)
        }
        else if number == 2
        {
            color = yellowNote
            image = "YellowNote"
            pos = CGPoint(x: -80, y: 800)
        }
        else if number == 3
        {
            color = greenNote
            image = "GreenNote"
            pos = CGPoint(x: 80, y: 800)
        }
        else if number == 4
        {
            color = blueNote
            image = "BlueNote"
            pos = CGPoint(x: 240, y: 800)
        }
        
        color = SKSpriteNode(imageNamed: image)
        color.size = CGSize(width: 160, height: 160)
        color.position = pos
        color.name = image
        addChild(color)
        color.physicsBody = SKPhysicsBody(rectangleOf: color.frame.size)
        color.physicsBody?.usesPreciseCollisionDetection = true
        color.physicsBody!.isDynamic = false
        color.physicsBody?.categoryBitMask = 3
        let moveDown = SKAction.moveTo(y: -800, duration: TimeInterval(gameSpeed))
        color.run(moveDown)
        notes.append(color)
    }
}
