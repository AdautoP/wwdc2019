//
//  SpriteComponent.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 15/03/19.
//

import UIKit
import GameplayKit

class SpriteComponent: GKComponent {
    var sprite: SKSpriteNode!
    init(with image: UIImage, size: CGSize = .zero, position: CGPoint = .zero, haveBody: Bool = true) {
        sprite = SKSpriteNode(texture: SKTexture(image: image), size: size)
        sprite.position = position
        if haveBody{
            sprite.physicsBody = SKPhysicsBody(texture: SKTexture(image: image), size: sprite.size)
            sprite.physicsBody?.affectedByGravity = false
            sprite.physicsBody?.contactTestBitMask = BitMask.bitMask(layers: [1])
            sprite.physicsBody?.categoryBitMask = BitMask.bitMask(layers: [1])
        }
        super.init()
    }
    init(with color: UIColor, size: CGSize = .zero, position: CGPoint = .zero, haveBody: Bool = true) {
        sprite = SKSpriteNode(color: color, size: size)
        sprite.position = position
        if haveBody{
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody?.affectedByGravity = false
            sprite.physicsBody?.contactTestBitMask = BitMask.bitMask(layers: [1])
            sprite.physicsBody?.categoryBitMask = BitMask.bitMask(layers: [1])
        }
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
}
