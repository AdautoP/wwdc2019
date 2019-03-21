//
//  BitMask.swift
//  Book_Sources
//
//  Created by Adauto Pinheiro on 16/03/19.
//

import Foundation
class BitMask {
    static func bitMask(layers: [Int]) -> UInt32 {
        var bitMask: UInt32 = 0
        for layer in layers {
            bitMask += UInt32(exactly: powf(2, Float(layer))) ?? 0
        }
        return bitMask
    }
}
