//
//  EntityManager.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 16/03/19.
//

import Foundation
import GameplayKit
class EntityManager: NSObject{
    static let shared = EntityManager.init()
    var componentSystems = [GKComponentSystem]()
    var entities = Set<GKEntity>()
    var scene = SKScene()
    private override init(){}
    func addEntity(entity: GKEntity){
        entities.insert(entity)
        if let spriteComponent = entity.component(ofType: SpriteComponent.self){
            if spriteComponent.sprite.parent == nil{
                scene.addChild(spriteComponent.sprite)
            }
        }
        for i in componentSystems{
            i.addComponent(foundIn: entity)
        }
    }
    func addSystem<T: GKComponent>(type: T.Type){
        componentSystems.append(GKComponentSystem(componentClass: type))
    }
    func moveComponents()->[MoveComponent]{
        var componentsToMove = [MoveComponent]()
        for i in componentSystems{
            if i.componentClass == MoveComponent.self{
                componentsToMove = i.components as! [MoveComponent]
            }
        }
        return componentsToMove
    }
    func update(deltaTime seconds: TimeInterval){
        for i in componentSystems{
            i.update(deltaTime: seconds)
        }
    }
    func removeEntity(entity: GKEntity){
        entities.remove(entity)
        for i in componentSystems{
            i.removeComponent(foundIn: entity)
        }
        if let entity = entity as? Spermatozoon{
            entity.spriteComponent.sprite.removeFromParent()
        }
        else if let entity = entity as? Ovule{
            entity.spriteComponent.sprite.removeFromParent()
        }
    }
    func removeAll(){
        for i in entities{
            if let i = i as? Spermatozoon{
                i.spriteComponent.sprite.removeFromParent()
                entities.remove(i)
            }
            else if let i = i as? Ovule{
                i.spriteComponent.sprite.removeFromParent()
                entities.remove(i)
            }
        }
        for i in componentSystems{
            for j in i.components{
                i.removeComponent(j)
            }
        }
    }
}
