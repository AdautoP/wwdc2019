//
//  RandomWalk.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 15/03/19.
//

import UIKit
import GameplayKit

class MoveComponent: GKAgent2D, GKAgentDelegate {
    var auxBehavior: GKBehavior?

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        behavior = auxBehavior
    }
    
    init(with behavior: GKBehavior) {
        auxBehavior = behavior
        super.init()
        self.behavior = behavior
        delegate = self
        guard let entity = entity as? Spermatozoon else { return }
        if !entity.isHealthy{
            
        }    
    }
    required init?(coder aDecoder: NSCoder) {
        auxBehavior = GKBehavior()
        super.init(coder: aDecoder)
    }
    
    func agentWillUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        if (entity?.isKind(of: Spermatozoon.self))!{
            self.rotation = Float(spriteComponent.sprite.zRotation)
        }
        position = float2(Float(spriteComponent.sprite.position.x), Float(spriteComponent.sprite.position.y))
    }
    
    // 5
    func agentDidUpdate(_ agent: GKAgent) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else {
            return
        }
        if (entity?.isKind(of: Spermatozoon.self))!{
            spriteComponent.sprite.zRotation = CGFloat(self.rotation)
        }
        spriteComponent.sprite.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y))
    }
}
