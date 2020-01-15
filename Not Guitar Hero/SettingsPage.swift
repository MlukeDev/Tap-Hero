//
//  SettingsPage.swift
//  Not Guitar Hero
//
//  Created by Matt Luke on 1/9/20.
//  Copyright © 2020 MlukeApps. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class SettingsPage: SKScene {

    var homeButton = SKLabelNode()
    var scoreResetButton = SKLabelNode()
    var streakResetButton = SKLabelNode()
    let defaults = UserDefaults.standard

    override func didMove(to view: SKView) {
        
        homeButton = self.childNode(withName: "homeButton") as! SKLabelNode
        scoreResetButton = self.childNode(withName: "scoreResetButton") as! SKLabelNode
        streakResetButton = self.childNode(withName: "streakResetButton") as! SKLabelNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let location = touches.first!.location(in: self)
        
        if streakResetButton.frame.contains(location)
        {
            displayAlert(value: "Streak")
        }
        
        if scoreResetButton.frame.contains(location)
        {
            displayAlert(value: "Score")
        }
        
        if homeButton.frame.contains(location)
        {
            let titleScreen = TitleScreen(fileNamed: "TitleScreen")
            titleScreen?.scaleMode = .aspectFill
            let reveal = SKTransition.push(with: SKTransitionDirection.right, duration: 0.5)
            view?.presentScene(titleScreen!, transition: reveal)
        }
        
    }
    
    func displayAlert(value: String)
    {
        let resetAlert = UIAlertController(title: "Are you sure you want to reset your High \(value)?", message: "", preferredStyle: .alert)

        let deleteAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive) {
                UIAlertAction in
            self.defaults.set(0, forKey: "easyHigh\(value)")
            self.defaults.set(0, forKey: "mediumHigh\(value)")
            self.defaults.set(0, forKey: "hardHigh\(value)")
            }
        
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default)
        
            resetAlert.addAction(deleteAction)
            resetAlert.addAction(cancelAction)
        
            self.view?.window?.rootViewController?.present(resetAlert, animated: true, completion: nil)
    }
    
}
