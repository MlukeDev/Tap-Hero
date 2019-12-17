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
    var timer: Timer?
    
    
    override func didMove(to view: SKView) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(makeNote), userInfo: nil, repeats: true)
        
    }
    
    
    
    @objc func makeNote()
    {
        redNote = SKSpriteNode(imageNamed: "RedNote")
        redNote.size = CGSize(width: 160, height: 160)
        redNote.position = CGPoint(x: -270, y: 800)
        redNote.name = "RedNote"
        addChild(redNote)
        
        
        let moveDown = SKAction.moveTo(y: -800, duration: 3)
        let removeSprite = SKAction.run {
            self.redNote.removeFromParent()
        }
        let sequence = SKAction.sequence([moveDown, removeSprite])
        
        redNote.run(sequence)
        
    }
    
    
    
}
