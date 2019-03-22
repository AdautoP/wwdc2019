//
//  FirstScene.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 16/03/19.
//

import UIKit
import GameplayKit

class FirstScene: SKScene {
    var syringeAnimationArray = [SKTexture]()
    var testSpriteNode = SKSpriteNode()
    let uterusSprite = SKSpriteNode(imageNamed: "Uterus")
    let cameraNode = SKCameraNode()
    var ovuleAnimationArray = [SKTexture]()
    var injectedHormone = false
    
    override func didMove(to view: SKView) {
        EntityManager.shared.scene = self
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 24/255, green: 15/255, blue: 66/255, alpha: 1)
        var textureAtlas = SKTextureAtlas(named: "Syringe")
        for i in 0..<textureAtlas.textureNames.count{
            syringeAnimationArray.append(textureAtlas.textureNamed("Syringe \(i)"))
        }
        textureAtlas = SKTextureAtlas(named: "Ovule")
        for i in 0..<textureAtlas.textureNames.count{
            ovuleAnimationArray.append(textureAtlas.textureNamed("Ovule \(i)"))
        }
        camera = cameraNode
        uterusSprite.size = CGSize(width: frame.size.width/2, height: frame.size.width/2)
        uterusSprite.position = CGPoint.zero
        uterusSprite.zPosition = -1
        testSpriteNode = SKSpriteNode(texture: syringeAnimationArray[0],size: CGSize(width: frame.size.width/4, height: frame.size.width/4))
        testSpriteNode.xScale = -1
        testSpriteNode.position = CGPoint(x: 0, y: testSpriteNode.size.height/2)
        addChild(uterusSprite)
        addChild(testSpriteNode)
        addChild(cameraNode)
        cameraNode.position = .zero
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        EntityManager.shared.update(deltaTime: 1.0)
        camera = cameraNode
    }
    
    func injectHormone(){
        if !injectedHormone{
            testSpriteNode.run(SKAction.animate(with: syringeAnimationArray, timePerFrame: 0.08, resize: false, restore: true)) {
                self.testSpriteNode.run(SKAction.move(to: CGPoint(x: 1000, y: self.testSpriteNode.position.y), duration: 1.0), completion: {
                    let actionGroup = [SKAction.moveTo(x: self.uterusSprite.frame.size.width/4, duration: 1.0),SKAction.scale(to: 0.2, duration: 1.0)]
                    self.cameraNode.run(SKAction.group(actionGroup), completion: {
                        for _ in 0...9{
                            let x = CGFloat.random(in: self.cameraNode.position.x - 25...self.cameraNode.position.x + 25)
                            let y = CGFloat.random(in: self.cameraNode.position.y - 12.5...self.cameraNode.position.y + 30)
                            let ovule = Ovule(position: CGPoint(x: x, y: y),size: CGSize(width: 25, height: 25), image: UIImage(named: "Ovule 0"), haveBody: false)
                            ovule.spriteComponent.sprite.zPosition = 1
                            
                            EntityManager.shared.addEntity(entity: ovule)
                            ovule.spriteComponent.sprite.run(SKAction.animate(with: self.ovuleAnimationArray, timePerFrame: 0.2, resize: false, restore: false))
                        }
                    })
                })
            }
        }
        injectedHormone = true
    }
    func extractOvules(){
        if injectedHormone{
            for i in EntityManager.shared.moveComponents(){
                if let entity = i.entity as? Ovule {
                    entity.spriteComponent.sprite.run(SKAction.move(to: CGPoint(x: cameraNode.position.x + uterusSprite.size.width/4, y: cameraNode.position.y - uterusSprite.size.height/2), duration: 1.0)) {
                        EntityManager.shared.removeEntity(entity: entity)
                    }
                }
            }
        }
    }
}
