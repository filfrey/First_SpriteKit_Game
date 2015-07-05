//
//  GameViewController.swift
//  Not_Like_You
//
//  Created by Jeffrey Lin on 6/20/15.
//  Copyright (c) 2015 Jeffrey Lin. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    
    @IBOutlet var skView: SKView!
    
    var scene: GameScene!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start the progress indicator animation.
        GameScene.loadSceneAssetsWithCompletionHandler {
            loadedScene in
            var viewSize = self.view.bounds.size
            
            // On iPhone/iPod touch we want to see a similar amount of the scene as on iPad.
            // So, we set the size of the scene to be double the size of the view, which is
            // the whole screen, 3.5- or 4- inch. This effectively scales the scene to 50%.
            if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
                viewSize.height *= 2
                viewSize.width *= 2
            }
            
            self.scene = loadedScene
            self.scene.size = viewSize
            self.scene.scaleMode = .AspectFill
            
            //DEBUGING INFO ToBeDeleted
            self.skView.showsDrawCount = true
            self.skView.showsFPS = true
            
            
            self.skView.presentScene(self.scene)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
