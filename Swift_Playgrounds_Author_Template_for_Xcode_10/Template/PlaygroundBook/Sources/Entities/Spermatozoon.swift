//
//  Spermatozoon.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 15/03/19.
//

import UIKit
import GameplayKit

class Spermatozoon: GKEntity {
    var isHealthy: Bool = true
    let moveComponent = MoveComponent(with: MoveBehavior(targetSpeed: 0,shouldWander: false))
    let spriteComponent: SpriteComponent!
    
    var spermHealthyArray = { () -> [SKTexture] in
        let textureAtlas = SKTextureAtlas(named: "SpermHealthy")
        var auxArray = [SKTexture]()
        for i in 0..<textureAtlas.textureNames.count{
            auxArray.append(textureAtlas.textureNamed("SpermHealthy \(i)"))
        }
        return auxArray
    }()
    var spermUnHealthyArray = {
        
        () -> [SKTexture] in
        let spermNames = ["SpermBigHead","SpermDoubleHead","SpermDoubleTail","SpermDeformed"]
        let random = Int.random(in: 0...3)
        let textureAtlas = SKTextureAtlas(named: spermNames[random])
        var auxArray = [SKTexture]()
        for i in 0..<textureAtlas.textureNames.count{
            auxArray.append(textureAtlas.textureNamed("\(spermNames[random]) \(i)"))
        }
        return auxArray
    }()
    
    init(position: CGPoint = .zero, size: CGSize = CGSize(width: 10, height: 10), isHealthy:Bool = true) {
        self.isHealthy = isHealthy
        if self.isHealthy{
            spriteComponent = SpriteComponent(with: UIImage(named: "SpermHealthy 0")!, size: size, position: position)
            spriteComponent.sprite.run(SKAction.repeatForever(SKAction.animate(with: spermHealthyArray, timePerFrame: 0.15)))
            
        }
        else{
            spriteComponent = SpriteComponent(with: UIImage(cgImage: (spermUnHealthyArray.first?.cgImage())!), size: size, position: position)
            spriteComponent.sprite.run(SKAction.repeatForever(SKAction.animate(with: spermUnHealthyArray, timePerFrame: 0.15)))
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
extension Spermatozoon: EntityContactProtocol{
    func contactDidBegin(with entity: GKEntity) {
        //
    }
    
    func contactDidEnd(with entity: GKEntity) {
        //
    }
    
    
}
