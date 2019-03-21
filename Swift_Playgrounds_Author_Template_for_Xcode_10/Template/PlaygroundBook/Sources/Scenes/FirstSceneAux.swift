//
//  FirstSceneAux.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 16/03/19.
//

import UIKit
import GameplayKit

class FirstSceneAux: SKScene {
    var ovuleAnimationArray = [SKTexture]()
    
    override func didMove(to view: SKView) {
        EntityManager.shared.scene = self
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundColor = UIColor(red: 24/255, green: 15/255, blue: 66/255, alpha: 1)
        let textureAtlas = SKTextureAtlas(named: "Ovule")
        for i in 0..<textureAtlas.textureNames.count{
            ovuleAnimationArray.append(textureAtlas.textureNamed("Ovule \(i)"))
        }
        let ovaryNode = SKSpriteNode(imageNamed: "Ovary")
        addChild(ovaryNode)
        for i in 0...9{
            let x = CGFloat.random(in: ovaryNode.position.x - 100...ovaryNode.position.x + 100)
            let y = CGFloat.random(in: ovaryNode.position.y - 50...ovaryNode.position.y + 50)
            let ovule = Ovule(position: CGPoint(x: x, y: y),size: CGSize(width: 50, height: 50), image: UIImage(named: "Ovule 0"), haveBody: false)
            ovule.spriteComponent.sprite.zPosition = 1
            
            EntityManager.shared.addEntity(entity: ovule)
            ovule.spriteComponent.sprite.run(SKAction.animate(with: ovuleAnimationArray, timePerFrame: 0.2, resize: false, restore: false))
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        EntityManager.shared.update(deltaTime: 1.0)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        extractOvules()
    }
    func extractOvules(){
        for i in EntityManager.shared.moveComponents(){
            if let entity = i.entity as? Ovule {
                entity.spriteComponent.sprite.run(SKAction.move(to: CGPoint(x: frame.maxX, y: frame.minY), duration: 1.0)) {
                    EntityManager.shared.removeEntity(entity: entity)
                }
            }
        }
    }
}

