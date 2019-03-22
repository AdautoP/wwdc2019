//
//  SecondPageController.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 18/03/19.
//

import Foundation
import PlaygroundSupport
import GameplayKit
import SpriteKit

@objc(Book_Sources_IntroductionPageController)
public class IntroductionPageController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    /*
     public func liveViewMessageConnectionOpened() {
     // Implement this method to be notified when the live view message connection is opened.
     // The connection will be opened when the process running Contents.swift starts running and listening for messages.
     }
     */
    
    /*
     public func liveViewMessageConnectionClosed() {
     // Implement this method to be notified when the live view message connection is closed.
     // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
     // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
     }
     */
    
    public func receive(_ message: PlaygroundValue) {
        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        EntityManager.shared.addSystem(type: SpriteComponent.self)
        EntityManager.shared.addSystem(type: MoveComponent.self)
        EntityManager.shared.removeAll()
        self.view = SKView(frame: self.view.frame)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'StageScene.sks'
            let scene = IntroductionScene(size: CGSize(width: view.frame.size.width, height: view.frame.size.height))
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.showsPhysics = true
        }
    }
}
