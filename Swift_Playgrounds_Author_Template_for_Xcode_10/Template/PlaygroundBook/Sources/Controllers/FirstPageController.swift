//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import PlaygroundSupport
import GameplayKit
import SpriteKit

@objc(Book_Sources_FirstPageController)
public class FirstPageController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
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
        
//        guard case let .dictionary(values) = message else { return }
//        
//        guard case let .string(action)? = values["action"] else { return }
//        
//        guard case let .string(target)? = values["target"] else { return }
        
        guard case let .string(function) = message else { return }
        if function == "injectHormone"{
            injectHormone()
        }
        else if function == "extractOvules"{
            extractOvules()
        }
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        EntityManager.shared.addSystem(type: SpriteComponent.self)
        EntityManager.shared.addSystem(type: MoveComponent.self)
        EntityManager.shared.removeAll()
        self.view = SKView(frame: self.view.frame)
        if let view = self.view as! SKView? {
            // Load the SKScene from 'StageScene.sks'
            let scene = FirstScene(size: CGSize(width: view.frame.size.width, height: view.frame.size.height))
            scene.sceneDelegate = self
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }
    func injectHormone(){
        if let view = self.view as? SKView{
            if let scene = view.scene as? FirstScene{
                scene.injectHormone()
            }
        }
    }
    func extractOvules(){
        if let view = self.view as? SKView{
            if let scene = view.scene as? FirstScene{
                scene.extractOvules()
            }
        }
    }
}
extension FirstPageController: FirstSceneDelegate{
    func didFinishScene() {
        if let view = view as? SKView{
            let scene = FirstSceneAux(size: CGSize(width: view.frame.size.width, height: view.frame.size.height))
            view.presentScene(scene, transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}
