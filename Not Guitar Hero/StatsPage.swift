//
//  StatsPage.swift
//  Not Guitar Hero
//
//  Created by Matt Luke on 1/9/20.
//  Copyright © 2020 MlukeApps. All rights reserved.
//

import SpriteKit
import GameplayKit

class StatsPage: SKScene {

    var homeButton = SKLabelNode()
    var easyHighScore = SKLabelNode()
    var mediumHighScore = SKLabelNode()
    var hardHighScore = SKLabelNode()
    var easyHighStreak = SKLabelNode()
    var mediumHighStreak = SKLabelNode()
    var hardHighStreak = SKLabelNode()
    
    var difficulty = "easy"

    override func didMove(to view: SKView) {
        
        let defaults = UserDefaults.standard
        
        homeButton = self.childNode(withName: "homeButton") as! SKLabelNode
        easyHighScore = self.childNode(withName: "easyHighScore") as! SKLabelNode
        mediumHighScore = self.childNode(withName: "mediumHighScore") as! SKLabelNode
        hardHighScore = self.childNode(withName: "hardHighScore") as! SKLabelNode
        easyHighStreak = self.childNode(withName: "easyHighStreak") as! SKLabelNode
        mediumHighStreak = self.childNode(withName: "mediumHighStreak") as! SKLabelNode
        hardHighStreak = self.childNode(withName: "hardHighStreak") as! SKLabelNode
        
        let easyHighScoreVar = defaults.integer(forKey: "easyHighScore")
        let mediumHighScoreVar = defaults.integer(forKey: "mediumHighScore")
        let hardHighScoreVar = defaults.integer(forKey: "hardHighScore")
        let easyHighStreakVar = defaults.integer(forKey: "easyHighStreak")
        let mediumHighStreakVar = defaults.integer(forKey: "mediumHighStreak")
        let hardHighStreakVar = defaults.integer(forKey: "hardHighStreak")
        
        easyHighScore.text = "\(easyHighScoreVar)"
        mediumHighScore.text = "\(mediumHighScoreVar)"
        hardHighScore.text = "\(hardHighScoreVar)"
        easyHighStreak.text = "\(easyHighStreakVar)"
        mediumHighStreak.text = "\(mediumHighStreakVar)"
        hardHighStreak.text = "\(hardHighStreakVar)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)
        
        if homeButton.frame.contains(location)
        {
            let titleScreen = TitleScreen(fileNamed: "TitleScreen")
            titleScreen?.scaleMode = .aspectFill
            let reveal = SKTransition.push(with: SKTransitionDirection.left, duration: 0.5)
            view?.presentScene(titleScreen!, transition: reveal)
        }
    }
    
    
}
