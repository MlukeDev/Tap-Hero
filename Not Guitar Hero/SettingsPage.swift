//
//  SettingsPage.swift
//  Not Guitar Hero
//
//  Created by Matt Luke on 1/9/20.
//  Copyright © 2020 MlukeApps. All rights reserved.
//

import SpriteKit
import GameplayKit

class SettingsPage: SKScene {

    var homeButton = SKLabelNode()

    override func didMove(to view: SKView) {
        
        homeButton = self.childNode(withName: "homeButton") as! SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)
        
        if homeButton.frame.contains(location)
        {
            let titleScreen = TitleScreen(fileNamed: "TitleScreen")
            titleScreen?.scaleMode = .aspectFill
            let reveal = SKTransition.push(with: SKTransitionDirection.right, duration: 0.5)
            view?.presentScene(titleScreen!, transition: reveal)
        }
    }
    
    
}
