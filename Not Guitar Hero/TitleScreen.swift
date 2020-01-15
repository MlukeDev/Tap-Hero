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
    var EasyButton = SKLabelNode()
    var MediumButton = SKLabelNode()
    var HardButton = SKLabelNode()
    var easyBackground = SKSpriteNode()
    var mediumBackground = SKSpriteNode()
    var hardBackground = SKSpriteNode()
    var statsButton = SKLabelNode()
    var settingsButton = SKLabelNode()
    let defaults = UserDefaults.standard
    var Difficulty = 0.0
    
    override func didMove(to view: SKView) {
        easyBackground = self.childNode(withName: "easyBackground") as! SKSpriteNode
        mediumBackground = self.childNode(withName: "mediumBackground") as! SKSpriteNode
        hardBackground = self.childNode(withName: "hardBackground") as! SKSpriteNode
        EasyButton = self.childNode(withName: "EasyButton") as! SKLabelNode
        MediumButton = self.childNode(withName: "MediumButton") as! SKLabelNode
        HardButton = self.childNode(withName: "HardButton") as! SKLabelNode
        startButton = self.childNode(withName: "startButton") as! SKLabelNode
        statsButton = self.childNode(withName: "statsButton") as! SKLabelNode
        settingsButton = self.childNode(withName: "settingsButton") as! SKLabelNode
        
        let defaults = UserDefaults.standard
        let difficulty = defaults.double(forKey: "difficulty")
        
            if difficulty == 1.0
            {
                easyBackground.alpha = 0.5
                mediumBackground.alpha = 0.0
                hardBackground.alpha = 0.0
            }
            else if difficulty == 0.5
            {
                easyBackground.alpha = 0.0
                mediumBackground.alpha = 0.5
                hardBackground.alpha = 0.0
            }
            else if difficulty == 0.25
            {
                easyBackground.alpha = 0.0
                mediumBackground.alpha = 0.0
                hardBackground.alpha = 0.5
            }
            else
            {
                easyBackground.alpha = 0.0
                mediumBackground.alpha = 0.0
                hardBackground.alpha = 0.0
            }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first?.location(in: self)
        
        if startButton.frame.contains(location!)
        {
            let gameScene = GameScene(fileNamed: "GameScene")
            gameScene?.scaleMode = .aspectFill
            let reveal = SKTransition.push(with: SKTransitionDirection.down, duration: 0.5)
            view?.presentScene(gameScene!, transition: reveal)
        }
        
        if EasyButton.frame.contains(location!)
        {
            selectDifficulty(difficulty: 1.0, easyAlpha: 0.5, mediumAlpha: 0.0, hardAlpha: 0.0)
        }
        
        if MediumButton.frame.contains(location!)
        {
            selectDifficulty(difficulty: 0.5, easyAlpha: 0.0, mediumAlpha: 0.5, hardAlpha: 0.0)
        }
        
        if HardButton.frame.contains(location!)
        {
            selectDifficulty(difficulty: 0.25, easyAlpha: 0.0, mediumAlpha: 0.0, hardAlpha: 0.5)
        }
        
        if statsButton.frame.contains(location!)
        {
            let statsPage = StatsPage(fileNamed: "StatsPage")
            statsPage?.scaleMode = .aspectFill
            let reveal = SKTransition.push(with: SKTransitionDirection.right, duration: 0.5)
            view?.presentScene(statsPage!, transition: reveal)
                           
        }
        
        if settingsButton.frame.contains(location!)
        {
            let settingsPage = SettingsPage(fileNamed: "SettingsPage")
            settingsPage?.scaleMode = .aspectFill
            let reveal = SKTransition.push(with: SKTransitionDirection.left, duration: 0.5)
            view?.presentScene(settingsPage!, transition: reveal)
                           
        }
    }
    
    func selectDifficulty(difficulty: Double, easyAlpha: CGFloat, mediumAlpha: CGFloat, hardAlpha: CGFloat)
    {
        Difficulty = difficulty
        defaults.set(Difficulty, forKey: "difficulty")
        easyBackground.alpha = easyAlpha
        mediumBackground.alpha = mediumAlpha
        hardBackground.alpha = hardAlpha
    }
    
}

