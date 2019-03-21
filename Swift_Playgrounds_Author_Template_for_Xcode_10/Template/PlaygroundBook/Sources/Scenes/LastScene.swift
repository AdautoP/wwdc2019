//
//  FirstScene.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 14/03/19.
//

import UIKit
import SpriteKit
import GameplayKit

class LastScene: SKScene {
    var ovule = Ovule(position: .zero,size: CGSize(width: 200, height: 200), image: UIImage(named: "Ovule 7"))
    var syringeSpermArray = [SKTexture]()
    var inseminated = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        EntityManager.shared.scene = self
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = .white
        
        let textureAtlas = SKTextureAtlas(named: "SyringeSperm")
        for i in 0..<textureAtlas.textureNames.count{
            syringeSpermArray.append(textureAtlas.textureNamed("SyringeSperm \(i)"))
        }
        
        for _ in 0...19{
            let x = CGFloat.random(in: self.frame.minX...self.frame.maxX)
            let y = CGFloat.random(in: self.frame.minY...self.frame.maxY)
            let spermatozoon = Spermatozoon(position: CGPoint(x: x, y: y), size: CGSize(width: 50, height: 50))
            spermatozoon.spriteComponent.sprite.physicsBody = SKPhysicsBody(circleOfRadius: spermatozoon.spriteComponent.sprite.size.width/8, center: CGPoint(x: spermatozoon.spriteComponent.sprite.size.width/2 - spermatozoon.spriteComponent.sprite.size.width/8 , y: 0))
            spermatozoon.spriteComponent.sprite.physicsBody?.affectedByGravity = false
            spermatozoon.spriteComponent.sprite.physicsBody?.contactTestBitMask = BitMask.bitMask(layers: [1])
            spermatozoon.spriteComponent.sprite.physicsBody?.categoryBitMask = BitMask.bitMask(layers: [1])
            EntityManager.shared.addEntity(entity: spermatozoon)
        }
        
        EntityManager.shared.addEntity(entity: ovule)
        for i in EntityManager.shared.moveComponents(){
            if let _ = i.entity as? Spermatozoon {
                i.auxBehavior = MoveBehavior(targetSpeed: 10,seek: ovule.moveComponent, avoid: EntityManager.shared.moveComponents(), shouldWander: true)
                i.speed = 10
            }
            else{
                i.auxBehavior = MoveBehavior(targetSpeed: 0, shouldWander: false)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        EntityManager.shared.update(deltaTime: 1.0)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let pos = touch.location(in: self)
            let node = atPoint(pos)
            if let _ = node.entity as? Ovule{
                node.position = touch.location(in: self)
            }
        }
        
    }
    
    func startInsemination(){
        EntityManager.shared.removeAll()
        ovule = Ovule(position: .zero, size: CGSize(width: 200, height: 200), image: UIImage(named: "Ovule 7"), haveBody: true)
        EntityManager.shared.addEntity(entity: ovule)
        let syringeWithSperm = SKSpriteNode(texture: syringeSpermArray[0])
        syringeWithSperm.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        syringeWithSperm.position = CGPoint(x: syringeWithSperm.size.width/2, y: syringeWithSperm.size.width/2)
        syringeWithSperm.alpha = 0
        addChild(syringeWithSperm)
        syringeWithSperm.run(SKAction.fadeIn(withDuration: 1.0)) {
            syringeWithSperm.run((SKAction.animate(with: self.syringeSpermArray, timePerFrame: 0.08,resize: false, restore: true)),completion: {
                let sperm = Spermatozoon(position: self.ovule.spriteComponent.sprite.position, size: CGSize(width: 50, height: 50), isHealthy: true)
                sperm.spriteComponent.sprite.physicsBody = nil
                self.ovule.spriteComponent.sprite.physicsBody?.isDynamic = false
                self.ovule.spriteComponent.sprite.addChild(sperm.spriteComponent.sprite)
                EntityManager.shared.addEntity(entity: sperm)
                sperm.spriteComponent.sprite.zPosition = 1
                syringeWithSperm.removeFromParent()
            })
        }
        
    }
    func contactX(){
//        if !inseminated{
//            let sperm = Spermatozoon(position: self.ovule.spriteComponent.sprite.position, size: CGSize(width: 50, height: 50), isHealthy: true)
//            sperm.spriteComponent.sprite.physicsBody = nil
//            self.ovule.spriteComponent.sprite.physicsBody?.isDynamic = false
//            self.ovule.spriteComponent.sprite.addChild(sperm.spriteComponent.sprite)
//            EntityManager.shared.addEntity(entity: sperm)
//            sperm.spriteComponent.sprite.zPosition = 1
//            inseminated = true
//        }
    }
}

extension LastScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        if let bodyA = contact.bodyA.node?.entity as? Spermatozoon, let bodyB = contact.bodyB.node?.entity as? Ovule{
            bodyA.contactDidBegin(with: bodyB)
            bodyB.contactDidBegin(with: bodyA)
            contactX()
            
        }
        else if let bodyA = contact.bodyA.node?.entity as? Ovule, let bodyB = contact.bodyB.node?.entity as? Spermatozoon{
            bodyA.contactDidBegin(with: bodyB)
            bodyB.contactDidBegin(with: bodyA)
            contactX()
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
