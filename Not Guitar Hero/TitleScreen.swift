//
//  TitleScreen.swift
//  Not Guitar Hero
//
//  Created by Matt Luke on 1/3/20.
//  Copyright © 2020 MlukeApps. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TitleScreen: SKScene, SKPhysicsContactDelegate {
    var startButton = SKLabelNode()
    var easyButton = SKLabelNode()
    var mediumButton = SKLabelNode()
    var hardButton = SKLabelNode()
    var Difficulty = 0.0
    
    override func didMove(to view: SKView) {
        easyButton = self.childNode(withName: "EasyButton") as! SKLabelNode
        startButton = self.childNode(withName: "startButton") as! SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         let location = touches.first?.location(in: self)
        if startButton.frame.contains(location!)
        {
            
            let gameScene = GameScene(fileNamed: "GameScene")
            gameScene?.scaleMode = .aspectFill
            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
            view?.presentScene(gameScene!, transition: reveal)

            
        }
        if easyButton.frame.contains(location!)
        {
            Difficulty = 1.0
            let defaults = UserDefaults.standard
                           defaults.set(Difficulty, forKey: "difficulty")
                           
        }
        if mediumButton.frame.contains(location!)
        {
            Difficulty = 1.0
            let defaults = UserDefaults.standard
                           defaults.set(Difficulty, forKey: "difficulty")
                           
        }
        if hardButton.frame.contains(location!)
        {
            Difficulty = 1.0
            let defaults = UserDefaults.standard
                           defaults.set(Difficulty, forKey: "difficulty")
                           
        }
    }
    
}

