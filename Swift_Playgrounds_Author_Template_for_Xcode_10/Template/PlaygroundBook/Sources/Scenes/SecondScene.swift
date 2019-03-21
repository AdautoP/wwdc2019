//
//  FirstScene.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 14/03/19.
//

import UIKit
import SpriteKit
import GameplayKit

class SecondScene: SKScene {
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        EntityManager.shared.scene = self
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .white
        
        for i in 0...29{
            let x = CGFloat.random(in: self.frame.minX...self.frame.maxX)
            let y = CGFloat.random(in: self.frame.minY...self.frame.maxY)
            var spermatozoon = Spermatozoon()
            if i < 9{
                spermatozoon = Spermatozoon(position: CGPoint(x: x, y: y), size: CGSize(width: 50, height: 50))
                spermatozoon.spriteComponent.sprite.physicsBody = nil
            }
            else{
                spermatozoon = Spermatozoon(position: CGPoint(x: x, y: y), size: CGSize(width: 50, height: 50), isHealthy: false)
                spermatozoon.spriteComponent.sprite.physicsBody = nil
            }
            EntityManager.shared.addEntity(entity: spermatozoon)
        }
        
        for i in EntityManager.shared.moveComponents(){
            if let entity = i.entity as? Spermatozoon {
                if entity.isHealthy{
                    
                    i.auxBehavior = MoveBehavior(avoid: EntityManager.shared.moveComponents(), shouldWander: true, bounds: frame)
                    i.speed = 5
                    i.maxSpeed = 5
                }
                else{
                    
                    i.auxBehavior = MoveBehavior(avoid: EntityManager.shared.moveComponents(), shouldWander: true, bounds: frame)
                    i.speed = 1
                    i.maxSpeed = 1
                }
                
            }
            else{
                i.auxBehavior = MoveBehavior(shouldWander: false, bounds: frame)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        EntityManager.shared.update(deltaTime: 1.0)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let pos = touch.location(in: self)
            let node = atPoint(pos)
            guard let entity = node.entity as? Spermatozoon else {
                return
            }
            if entity.isHealthy{
                //
            }
        }
    }
}

extension SecondScene: SKPhysicsContactDelegate{
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
