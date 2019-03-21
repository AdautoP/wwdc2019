//
//  Ovule.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 16/03/19.
//

import UIKit
import GameplayKit

class Ovule: GKEntity {
    let moveComponent = MoveComponent(with: MoveBehavior(targetSpeed: 0))
    let spriteComponent: SpriteComponent!
    init(position: CGPoint = .zero, size: CGSize = CGSize(width: 100, height: 100), image: UIImage? = nil, haveBody: Bool = true) {
        if let image = image{
            if haveBody{
                spriteComponent = SpriteComponent(with: image, size: size, position: position)
            }
            else{
                spriteComponent = SpriteComponent(with: image, size: size, position: position, haveBody: false)
            }
        }
        else{
            if haveBody{
                spriteComponent = SpriteComponent(with: .blue, size: size, position: position)
            }
            else{
                spriteComponent = SpriteComponent(with: .blue, size: size, position: position, haveBody: false)
            }
            
        }
        
        
        super.init()
        spriteComponent.sprite.entity = self
        addComponent(spriteComponent)
        addComponent(moveComponent)
    }
    required init?(coder aDecoder: NSCoder) {
        spriteComponent = SpriteComponent(with: .red, size: CGSize(width: 30, height: 30))
        super.init(coder: aDecoder)
    }
}

extension Ovule: EntityContactProtocol{
    func contactDidBegin(with entity: GKEntity) {
        //
    }
    
    func contactDidEnd(with entity: GKEntity) {
        //
    }
}
