//
//  FirstScene.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 14/03/19.
//
import UIKit
import SpriteKit
import GameplayKit

class IntroductionScene: SKScene {
    var didSelectSperm = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        EntityManager.shared.scene = self
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 24/255, green: 15/255, blue: 66/255, alpha: 1)
        let musicNode = SKAudioNode(fileNamed: "Background.mp3")
        
        musicNode.autoplayLooped = true
        addChild(musicNode)
        musicNode.run(SKAction.changeVolume(to: 0.2, duration: 0))
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        EntityManager.shared.update(deltaTime: 1.0)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first{
//            let pos = touch.location(in: self)
//            let node = atPoint(pos)
//        }
    }
}

extension IntroductionScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        if let bodyA = contact.bodyA.node?.entity as? Spermatozoon, let bodyB = contact.bodyB.node?.entity as? Ovule{
            bodyA.contactDidBegin(with: bodyB)
            bodyB.contactDidBegin(with: bodyA)
            
            
        }
        else if let bodyA = contact.bodyA.node?.entity as? Ovule, let bodyB = contact.bodyB.node?.entity as? Spermatozoon{
            bodyA.contactDidBegin(with: bodyB)
            bodyB.contactDidBegin(with: bodyA)
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let bodyA = contact.bodyA.node?.entity as? Spermatozoon, let bodyB = contact.bodyB.node?.entity as? Ovule{
            bodyA.contactDidEnd(with: bodyB)
            bodyB.contactDidEnd(with: bodyA)
        }
        else if let bodyA = contact.bodyA.node?.entity as? Ovule, let bodyB = contact.bodyB.node?.entity as? Spermatozoon{
            bodyA.contactDidEnd(with: bodyB)
            bodyB.contactDidEnd(with: bodyA)
        }
    }
    
}
