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
    
    override func didMove(to view: SKView) {
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

    }
    
}

