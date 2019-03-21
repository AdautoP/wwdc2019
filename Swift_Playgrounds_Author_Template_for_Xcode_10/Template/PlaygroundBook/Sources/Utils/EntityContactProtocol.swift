//
//  GKEntityExtension.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 16/03/19.
//

import Foundation
import GameplayKit
protocol EntityContactProtocol{
    func contactDidBegin(with entity: GKEntity)
    func contactDidEnd(with entity: GKEntity)
}
