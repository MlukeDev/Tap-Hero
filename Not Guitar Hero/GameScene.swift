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
   
    override func didMove(to view: SKView) {
        makeNote()
    }
    
    func makeNote()
    {
        redNote = SKSpriteNode(imageNamed: "RedNote")
        redNote.size = CGSize(width: 160, height: 160)
        redNote.position = CGPoint(x: 0, y: 0)
        redNote.name = "RedNote"
        addChild(redNote)
    }
    
    
    
}
